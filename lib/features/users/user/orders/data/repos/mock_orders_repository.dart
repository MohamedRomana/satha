import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../create_order/data/models/location_models.dart';
import '../../../create_order/data/models/order_flow_models.dart';
import '../../../vehicles/data/models/vehicle_model.dart';
import '../models/order_model.dart';
import 'orders_repository.dart';

/// مستودع طلبات وهمي في الذاكرة (mock).
class MockOrdersRepository implements OrdersRepository {
  MockOrdersRepository() {
    _orders.addAll(_seed());
  }

  final List<OrderModel> _orders = [];
  int _counter = 10250;

  Future<void> _delay() => Future.delayed(const Duration(milliseconds: 500));

  @override
  Future<List<OrderModel>> getOrders() async {
    await _delay();
    final list = [..._orders];
    list.sort((a, b) => b.createdAt.compareTo(a.createdAt));
    return list;
  }

  @override
  Future<OrderModel?> getById(String id) async {
    await _delay();
    try {
      return _orders.firstWhere((o) => o.id == id);
    } catch (_) {
      return null;
    }
  }

  @override
  Future<OrderModel> createOrder(OrderModel draft) async {
    await _delay();
    final number = ++_counter;
    final created = OrderModel(
      id: 'o$number',
      orderNumber: 'ST-$number',
      status: OrderStatus.searchingDrivers,
      service: draft.service,
      vehicle: draft.vehicle,
      problem: draft.problem,
      description: draft.description,
      problemImages: draft.problemImages,
      pickup: draft.pickup,
      destination: draft.destination,
      route: draft.route,
      createdAt: DateTime.now(),
    );
    _orders.add(created);
    return created;
  }

  @override
  Future<void> updateOrder(OrderModel order) async {
    await _delay();
    final i = _orders.indexWhere((o) => o.id == order.id);
    if (i != -1) _orders[i] = order;
  }

  // ---- بيانات وهمية ----
  static const _vehicle = VehicleModel(
    id: 'v1',
    name: 'سيارتي الأساسية',
    brand: 'Toyota',
    model: 'Camry',
    year: 2023,
    color: 'أبيض',
    plateNumber: 'أ ب ج ١٢٣٤',
    chassisNumber: 'JTNB11HK1P3000001',
    category: VehicleCategory.sedan,
  );

  static const _pickup =
      LocationModel(lat: 24.7136, lng: 46.6753, address: 'الرياض - العليا');
  static const _destination =
      LocationModel(lat: 24.6877, lng: 46.7219, address: 'الرياض - الملز');

  static const _route = RouteInfoModel(
    distanceKm: 7.4,
    durationMin: 15,
    polyline: [LatLng(24.7136, 46.6753), LatLng(24.6877, 46.7219)],
  );

  List<OrderModel> _seed() => [
    OrderModel(
      id: 'o10245',
      orderNumber: 'ST-10245',
      status: OrderStatus.offersReceived,
      service: OrderServiceType.normal,
      vehicle: _vehicle,
      problem: OrderProblemType.battery,
      pickup: _pickup,
      destination: _destination,
      route: _route,
      createdAt: DateTime.now().subtract(const Duration(minutes: 8)),
      offersCount: 3,
    ),
    OrderModel(
      id: 'o10231',
      orderNumber: 'ST-10231',
      status: OrderStatus.completed,
      service: OrderServiceType.hydraulic,
      vehicle: _vehicle,
      problem: OrderProblemType.accident,
      pickup: _pickup,
      destination: _destination,
      route: _route,
      createdAt: DateTime.now().subtract(const Duration(days: 1)),
      acceptedPrice: 180,
      driverName: 'خالد العتيبي',
    ),
    OrderModel(
      id: 'o10210',
      orderNumber: 'ST-10210',
      status: OrderStatus.canceledByCustomer,
      service: OrderServiceType.normal,
      vehicle: _vehicle,
      problem: OrderProblemType.tire,
      pickup: _pickup,
      destination: _destination,
      route: _route,
      createdAt: DateTime.now().subtract(const Duration(days: 3)),
    ),
  ];
}
