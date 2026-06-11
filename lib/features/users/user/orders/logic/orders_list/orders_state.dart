import 'package:freezed_annotation/freezed_annotation.dart';

import '../../data/models/order_model.dart';

part 'orders_state.freezed.dart';

@freezed
class OrdersState with _$OrdersState {
  const factory OrdersState.initial() = _Initial;
  const factory OrdersState.loading() = OrdersLoading;
  const factory OrdersState.success(List<OrderModel> orders) = OrdersSuccess;
  const factory OrdersState.error(String message) = OrdersError;
}
