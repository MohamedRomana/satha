import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../models/order_model.dart';

/// تحديث موقع السائق أثناء التتبّع المباشر.
class TrackingUpdate {
  final LatLng driver;
  final int etaMin;
  final double distanceRemainingKm;
  final OrderStatus status;

  const TrackingUpdate({
    required this.driver,
    required this.etaMin,
    required this.distanceRemainingKm,
    required this.status,
  });
}

/// واجهة خدمة التتبّع المباشر.
abstract class LiveTrackingService {
  /// مسار وهمي لنقاط السائق من البداية حتى الوجهة.
  List<LatLng> buildPath(OrderModel order);

  /// تدفّق تحديثات موقع السائق عبر نقاط [buildPath].
  Stream<TrackingUpdate> track(OrderModel order);
}

/// تنفيذ وهمي يحرّك السائق عبر polyline ويحدّث ETA/المسافة والحالة.
class MockLiveTrackingService implements LiveTrackingService {
  @override
  List<LatLng> buildPath(OrderModel order) {
    final pickup = order.pickup.latLng;
    final dest = order.destination.latLng;
    // نقطة انطلاق السائق على بُعد بسيط من نقطة البداية.
    final start = LatLng(pickup.latitude + 0.018, pickup.longitude + 0.014);
    final toPickup = _interpolate(start, pickup, 8);
    final toDest = order.route.polyline.isNotEmpty
        ? order.route.polyline
        : _interpolate(pickup, dest, 12);
    return [...toPickup, ...toDest];
  }

  @override
  Stream<TrackingUpdate> track(OrderModel order) async* {
    final pickup = order.pickup.latLng;
    final dest = order.destination.latLng;
    final toPickup = _interpolate(
      LatLng(pickup.latitude + 0.018, pickup.longitude + 0.014),
      pickup,
      8,
    );
    final toDest = order.route.polyline.isNotEmpty
        ? order.route.polyline
        : _interpolate(pickup, dest, 12);

    // المرحلة 1: السائق في الطريق إلى نقطة البداية.
    for (final p in toPickup) {
      await Future.delayed(const Duration(milliseconds: 900));
      final remaining = _distanceKm(p, pickup);
      yield TrackingUpdate(
        driver: p,
        distanceRemainingKm: remaining,
        etaMin: _eta(remaining),
        status: OrderStatus.driverOnWay,
      );
    }

    // وصل السائق.
    await Future.delayed(const Duration(milliseconds: 600));
    yield TrackingUpdate(
      driver: pickup,
      distanceRemainingKm: 0,
      etaMin: 0,
      status: OrderStatus.driverArrived,
    );

    // المرحلة 2: بدأت الرحلة نحو الوجهة.
    for (final p in toDest) {
      await Future.delayed(const Duration(milliseconds: 900));
      final remaining = _distanceKm(p, dest);
      yield TrackingUpdate(
        driver: p,
        distanceRemainingKm: remaining,
        etaMin: _eta(remaining),
        status: OrderStatus.tripStarted,
      );
    }

    // وصلت الوجهة.
    await Future.delayed(const Duration(milliseconds: 600));
    yield TrackingUpdate(
      driver: dest,
      distanceRemainingKm: 0,
      etaMin: 0,
      status: OrderStatus.destinationReached,
    );
  }

  double _distanceKm(LatLng a, LatLng b) =>
      Geolocator.distanceBetween(
        a.latitude,
        a.longitude,
        b.latitude,
        b.longitude,
      ) /
      1000.0;

  int _eta(double km) => (2 + (km / 40.0) * 60).round().clamp(1, 120);

  List<LatLng> _interpolate(LatLng a, LatLng b, int count) => [
    for (var i = 0; i <= count; i++)
      LatLng(
        a.latitude + (b.latitude - a.latitude) * (i / count),
        a.longitude + (b.longitude - a.longitude) * (i / count),
      ),
  ];
}
