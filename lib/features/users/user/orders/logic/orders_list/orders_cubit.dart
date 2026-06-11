import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/models/order_model.dart';
import '../../data/repos/orders_repository.dart';
import 'orders_state.dart';

/// كيوبت قائمة طلبات العميل (الحالية/السابقة/الملغاة).
class OrdersCubit extends Cubit<OrdersState> {
  final OrdersRepository _repo;
  OrdersCubit(this._repo) : super(const OrdersState.initial());

  List<OrderModel> orders = [];

  List<OrderModel> get currentOrders =>
      orders.where((o) => o.status.isActive).toList();
  List<OrderModel> get previousOrders =>
      orders.where((o) => o.status.isCompleted).toList();
  List<OrderModel> get canceledOrders =>
      orders.where((o) => o.status.isCanceled).toList();

  Future<void> getOrders({bool silent = false}) async {
    if (!silent) emit(const OrdersState.loading());
    try {
      orders = await _repo.getOrders();
      if (isClosed) return;
      emit(OrdersState.success(orders));
    } catch (e) {
      if (isClosed) return;
      emit(OrdersState.error(e.toString()));
    }
  }
}
