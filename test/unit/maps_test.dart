import 'package:flutter_test/flutter_test.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:satha/features/users/user/create_order/data/models/location_models.dart';
import 'package:satha/features/users/user/create_order/data/services/current_location_service.dart';
import 'package:satha/features/users/user/create_order/data/services/geocoding_service.dart';
import 'package:satha/features/users/user/create_order/data/services/location_permission_service.dart';
import 'package:satha/features/users/user/create_order/data/services/route_service.dart';
import 'package:satha/features/users/user/create_order/logic/select_locations/select_locations_cubit.dart';

void main() {
  group('MockRouteService', () {
    test('يرجّع مسافة ومدة و polyline', () async {
      final route = await MockRouteService().getRoute(
        const LatLng(24.7136, 46.6753),
        const LatLng(21.5433, 39.1728),
      );
      expect(route.distanceKm, greaterThan(0));
      expect(route.durationMin, greaterThan(0));
      expect(route.polyline, isNotEmpty);
    });
  });

  group('SelectLocationsCubit', () {
    SelectLocationsCubit build() => SelectLocationsCubit(
      LocationPermissionService(),
      CurrentLocationService(GeocodingService()),
      GeocodingService(),
      MockRouteService(),
    );

    test('لا يمكن التأكيد قبل تحديد النقطتين', () async {
      final cubit = build();
      expect(cubit.canConfirm, isFalse);
      await cubit.setLocation(
        const LocationModel(lat: 24.71, lng: 46.67, address: 'الرياض'),
        isDestination: false,
      );
      expect(cubit.canConfirm, isFalse);
      await cubit.setLocation(
        const LocationModel(lat: 21.54, lng: 39.17, address: 'جدة'),
        isDestination: true,
      );
      expect(cubit.canConfirm, isTrue);
      expect(cubit.route, isNotNull);
      expect(cubit.route!.distanceKm, greaterThan(0));
      cubit.close();
    });
  });
}
