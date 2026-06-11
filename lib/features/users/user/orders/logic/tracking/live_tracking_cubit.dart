import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../data/models/order_model.dart';
import '../../data/repos/orders_repository.dart';
import '../../data/services/live_tracking_service.dart';
import 'live_tracking_state.dart';

/// كيوبت التتبّع المباشر — يستهلك تدفّق مواقع السائق ويحدّث الخريطة.
class LiveTrackingCubit extends Cubit<LiveTrackingState> {
  final LiveTrackingService _service;
  final OrdersRepository _ordersRepo;
  final OrderModel order;

  LiveTrackingCubit(this._service, this._ordersRepo, this.order)
    : super(const LiveTrackingLoading());

  StreamSubscription<TrackingUpdate>? _sub;
  int _tick = 0;

  List<LatLng> path = [];
  LatLng? driverPosition;
  int etaMin = 0;
  double distanceRemainingKm = 0;
  OrderStatus currentStatus = OrderStatus.driverOnWay;

  void start() {
    path = _service.buildPath(order);
    driverPosition = path.isNotEmpty ? path.first : order.pickup.latLng;
    currentStatus = order.status;
    emit(LiveTrackingState.tracking(_tick++));

    _sub = _service.track(order).listen(
      (u) {
        driverPosition = u.driver;
        etaMin = u.etaMin;
        distanceRemainingKm = u.distanceRemainingKm;
        currentStatus = u.status;
        if (!isClosed) emit(LiveTrackingState.tracking(_tick++));
      },
      onError: (e) {
        if (!isClosed) emit(LiveTrackingState.error(e.toString()));
      },
    );
  }

  /// تأكيد وصول السائق (بعد إدخال رمز التحقق).
  Future<void> confirmArrival() async {
    currentStatus = OrderStatus.pickupConfirmed;
    await _ordersRepo.updateOrder(
      order.copyWith(status: OrderStatus.pickupConfirmed),
    );
    if (!isClosed) emit(LiveTrackingState.tracking(_tick++));
  }

  /// تأكيد إتمام الرحلة (بعد إدخال رمز التحقق).
  Future<void> completeTrip() async {
    currentStatus = OrderStatus.completed;
    await _ordersRepo.updateOrder(
      order.copyWith(status: OrderStatus.completed),
    );
    if (!isClosed) emit(LiveTrackingState.tracking(_tick++));
  }

  @override
  Future<void> close() {
    _sub?.cancel();
    return super.close();
  }
}
