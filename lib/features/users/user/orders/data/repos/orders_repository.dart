import '../models/order_model.dart';

/// واجهة مستودع الطلبات.
abstract class OrdersRepository {
  Future<List<OrderModel>> getOrders();
  Future<OrderModel?> getById(String id);
  Future<OrderModel> createOrder(OrderModel draft);
  Future<void> updateOrder(OrderModel order);
}
