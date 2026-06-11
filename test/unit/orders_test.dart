import 'package:flutter_test/flutter_test.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:satha/features/users/user/create_order/data/models/location_models.dart';
import 'package:satha/features/users/user/create_order/data/models/order_flow_models.dart';
import 'package:satha/features/users/user/create_order/data/services/route_service.dart';
import 'package:satha/features/users/user/create_order/logic/create_order_cubit.dart';
import 'package:satha/features/users/user/orders/data/models/order_model.dart';
import 'package:satha/features/users/user/orders/data/repos/mock_orders_repository.dart';
import 'package:satha/features/users/user/vehicles/data/models/vehicle_model.dart';
import 'package:satha/features/users/user/vehicles/data/repos/mock_vehicles_repository.dart';

void main() {
  const sampleVehicle = VehicleModel(
    id: 'v1',
    name: 'سيارة',
    brand: 'Toyota',
    model: 'Camry',
    year: 2023,
    color: 'أبيض',
    plateNumber: 'أ ب ج',
    chassisNumber: 'CH1',
    category: VehicleCategory.sedan,
  );

  const pickup =
      LocationModel(lat: 24.7136, lng: 46.6753, address: 'الرياض - العليا');
  const destination =
      LocationModel(lat: 24.6877, lng: 46.7219, address: 'الرياض - الملز');
  const route = RouteInfoModel(
    distanceKm: 7.4,
    durationMin: 15,
    polyline: [LatLng(24.7136, 46.6753), LatLng(24.6877, 46.7219)],
  );

  group('CreateOrderCubit locations & draft', () {
    test('hasLocations يصبح صحيحًا بعد ضبط المواقع', () {
      final cubit = CreateOrderCubit(MockVehiclesRepository());
      expect(cubit.hasLocations, isFalse);
      cubit.setLocations(
        pickup: pickup,
        destination: destination,
        route: route,
      );
      expect(cubit.hasLocations, isTrue);
      cubit.close();
    });

    test('buildDraft يجمع كل بيانات المسودّة', () {
      final cubit = CreateOrderCubit(MockVehiclesRepository());
      cubit.selectService(OrderServiceType.hydraulic);
      cubit.selectVehicle(sampleVehicle);
      cubit.selectProblem(OrderProblemType.tire);
      cubit.setLocations(
        pickup: pickup,
        destination: destination,
        route: route,
      );

      final draft = cubit.buildDraft();
      expect(draft.status, OrderStatus.draft);
      expect(draft.service, OrderServiceType.hydraulic);
      expect(draft.vehicle.id, 'v1');
      expect(draft.problem, OrderProblemType.tire);
      expect(draft.pickup.address, 'الرياض - العليا');
      expect(draft.destination.address, 'الرياض - الملز');
      expect(draft.route.distanceKm, 7.4);
      cubit.close();
    });
  });

  group('MockOrdersRepository', () {
    test('يُهيّئ ثلاثة طلبات في البداية', () async {
      final repo = MockOrdersRepository();
      final orders = await repo.getOrders();
      expect(orders.length, 3);
    });

    test('createOrder يحوّل المسودّة إلى طلب بحالة البحث عن سائقين', () async {
      final repo = MockOrdersRepository();
      final draft = OrderModel(
        id: '',
        orderNumber: '',
        status: OrderStatus.draft,
        service: OrderServiceType.normal,
        vehicle: sampleVehicle,
        problem: OrderProblemType.battery,
        pickup: pickup,
        destination: destination,
        route: route,
        createdAt: _epoch,
      );
      final created = await repo.createOrder(draft);
      expect(created.status, OrderStatus.searchingDrivers);
      expect(created.orderNumber, startsWith('ST-'));
      expect(created.id, isNotEmpty);

      final orders = await repo.getOrders();
      expect(orders.length, 4);
      expect(orders.first.id, created.id);
    });

    test('getById يعيد الطلب الصحيح أو null', () async {
      final repo = MockOrdersRepository();
      final found = await repo.getById('o10245');
      expect(found, isNotNull);
      expect(found!.orderNumber, 'ST-10245');

      final missing = await repo.getById('does-not-exist');
      expect(missing, isNull);
    });
  });

  group('MockRouteService', () {
    test('يعيد مسافة وزمنًا موجبين', () async {
      final service = MockRouteService();
      final result = await service.getRoute(
        const LatLng(24.7136, 46.6753),
        const LatLng(24.6877, 46.7219),
      );
      expect(result.distanceKm, greaterThan(0));
      expect(result.durationMin, greaterThanOrEqualTo(3));
      expect(result.polyline, isNotEmpty);
    });
  });
}

final DateTime _epoch = DateTime.fromMillisecondsSinceEpoch(0);
