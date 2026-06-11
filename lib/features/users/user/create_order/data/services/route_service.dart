import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../models/location_models.dart';

/// واجهة حساب المسار بين نقطتين.
abstract class RouteService {
  Future<RouteInfoModel> getRoute(LatLng origin, LatLng destination);
}

/// تنفيذ وهمي: مسافة تقريبية + زمن قيادة + نقاط polyline + تأخير.
class MockRouteService implements RouteService {
  @override
  Future<RouteInfoModel> getRoute(LatLng origin, LatLng destination) async {
    await Future.delayed(const Duration(milliseconds: 800));
    final meters = Geolocator.distanceBetween(
      origin.latitude,
      origin.longitude,
      destination.latitude,
      destination.longitude,
    );
    final km = meters / 1000.0;
    // افتراض متوسط سرعة ~40 كم/س + 4 دقائق ثابتة.
    final durationMin = (4 + (km / 40.0) * 60).round().clamp(3, 600);
    return RouteInfoModel(
      distanceKm: double.parse(km.toStringAsFixed(1)),
      durationMin: durationMin,
      polyline: _interpolate(origin, destination, 16),
    );
  }

  List<LatLng> _interpolate(LatLng a, LatLng b, int count) {
    return [
      for (var i = 0; i <= count; i++)
        LatLng(
          a.latitude + (b.latitude - a.latitude) * (i / count),
          a.longitude + (b.longitude - a.longitude) * (i / count),
        ),
    ];
  }
}

/// تنفيذ حقيقي (جاهز للربط بـ Directions API لاحقًا).
class RemoteRouteService implements RouteService {
  @override
  Future<RouteInfoModel> getRoute(LatLng origin, LatLng destination) async {
    // TODO: ربط Google Directions API عند توفّر الباك إند.
    return MockRouteService().getRoute(origin, destination);
  }
}
