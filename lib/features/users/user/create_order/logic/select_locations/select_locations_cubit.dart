import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../data/models/location_models.dart';
import '../../data/services/current_location_service.dart';
import '../../data/services/geocoding_service.dart';
import '../../data/services/location_permission_service.dart';
import '../../data/services/route_service.dart';
import 'select_locations_state.dart';

/// كيوبت اختيار مواقع الطلب (البداية/الوصول) + حساب المسار.
class SelectLocationsCubit extends Cubit<SelectLocationsState> {
  final LocationPermissionService _permission;
  final CurrentLocationService _currentLocation;
  final GeocodingService _geocoding;
  final RouteService _routeService;

  SelectLocationsCubit(
    this._permission,
    this._currentLocation,
    this._geocoding,
    this._routeService,
  ) : super(const SelectLocationsState.loading());

  /// نقطة افتراضية في الرياض عند تعذّر تحديد الموقع.
  static const LatLng defaultCenter = LatLng(24.7136, 46.6753);

  LocationModel? pickup;
  LocationModel? destination;
  LocationModel? current;
  RouteInfoModel? route;
  bool selectingDestination = false;
  bool routeLoading = false;
  bool confirming = false;

  int _tick = 0;
  void _emitReady() => emit(SelectLocationsState.ready(++_tick));

  bool get canConfirm =>
      pickup != null && destination != null && route != null;

  Future<void> init() async {
    emit(const SelectLocationsState.loading());
    final status = await _permission.ensurePermission();
    if (isClosed) return;
    switch (status) {
      case LocationPermissionStatus.servicesDisabled:
        emit(const SelectLocationsState.servicesDisabled());
        return;
      case LocationPermissionStatus.deniedForever:
        emit(const SelectLocationsState.permissionDenied(true));
        return;
      case LocationPermissionStatus.denied:
        emit(const SelectLocationsState.permissionDenied(false));
        return;
      case LocationPermissionStatus.granted:
        await _loadCurrentAsPickup();
        if (isClosed) return;
        _emitReady();
    }
  }

  /// متابعة يدويًا (تجاهل الإذن واستخدام الخريطة مباشرة).
  void useManual() => _emitReady();

  Future<void> _loadCurrentAsPickup() async {
    try {
      current = await _currentLocation.getCurrent();
      pickup ??= current;
      await _recomputeRoute();
    } catch (_) {
      // تجاهل — يحدّد المستخدم يدويًا.
    }
  }

  Future<void> useCurrentLocation() async {
    try {
      current = await _currentLocation.getCurrent();
      pickup = current;
      selectingDestination = true;
      await _recomputeRoute();
      if (isClosed) return;
      _emitReady();
    } catch (_) {
      if (isClosed) return;
      _emitReady();
    }
  }

  void setActive(bool isDestination) {
    selectingDestination = isDestination;
    _emitReady();
  }

  /// ضبط الموقع الفعّال مباشرة (يُستخدم من المواقع الحديثة/الاختبارات).
  Future<void> setLocation(LocationModel location, {bool? isDestination}) async {
    final dest = isDestination ?? selectingDestination;
    if (dest) {
      destination = location;
    } else {
      pickup = location;
      selectingDestination = true;
    }
    await _recomputeRoute();
    if (isClosed) return;
    _emitReady();
  }

  /// تأكيد مركز الخريطة كموقع للنقطة الفعّالة (يحوّل الإحداثيات لعنوان).
  Future<void> confirmCenter(LatLng center) async {
    confirming = true;
    _emitReady();
    final address =
        await _geocoding.addressFor(center.latitude, center.longitude);
    if (isClosed) return;
    confirming = false;
    await setLocation(
      LocationModel(
        lat: center.latitude,
        lng: center.longitude,
        address: address,
      ),
    );
  }

  Future<void> _recomputeRoute() async {
    if (pickup == null || destination == null) {
      route = null;
      return;
    }
    routeLoading = true;
    if (!isClosed) _emitReady();
    route = await _routeService.getRoute(pickup!.latLng, destination!.latLng);
    routeLoading = false;
  }

  Future<LocationPermissionStatus> requestPermissionAgain() async {
    final status = await _permission.ensurePermission();
    if (isClosed) return status;
    if (status == LocationPermissionStatus.granted) {
      await _loadCurrentAsPickup();
      if (!isClosed) _emitReady();
    }
    return status;
  }

  Future<void> openSettings() => _permission.openAppSettings();
}
