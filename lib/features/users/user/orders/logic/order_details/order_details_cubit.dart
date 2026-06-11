import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/models/order_model.dart';
import '../../data/repos/orders_repository.dart';
import 'order_details_state.dart';

/// كيوبت تفاصيل الطلب — تحميل + إلغاء عند السماح.
class OrderDetailsCubit extends Cubit<OrderDetailsState> {
  final OrdersRepository _repo;
  final String orderId;
  OrderDetailsCubit(this._repo, this.orderId)
    : super(const OrderDetailsState.initial());

  OrderModel? order;

  /// هل يُسمح بإلغاء الطلب في حالته الحالية؟
  bool get canCancel => const [
    OrderStatus.searchingDrivers,
    OrderStatus.offersReceived,
    OrderStatus.offerAccepted,
    OrderStatus.driverOnWay,
  ].contains(order?.status);

  Future<void> load({bool silent = false}) async {
    if (!silent) emit(const OrderDetailsState.loading());
    try {
      order = await _repo.getById(orderId);
      if (isClosed) return;
      if (order == null) {
        emit(const OrderDetailsState.error('not found'));
      } else {
        emit(OrderDetailsState.loaded(order!));
      }
    } catch (e) {
      if (isClosed) return;
      emit(OrderDetailsState.error(e.toString()));
    }
  }

  Future<void> cancelOrder() async {
    final current = order;
    if (current == null) return;
    emit(const OrderDetailsState.actionLoading());
    try {
      final updated = current.copyWith(status: OrderStatus.canceledByCustomer);
      await _repo.updateOrder(updated);
      order = updated;
      if (isClosed) return;
      emit(const OrderDetailsState.actionSuccess('canceled'));
      emit(OrderDetailsState.loaded(updated));
    } catch (e) {
      if (isClosed) return;
      emit(OrderDetailsState.actionError(e.toString()));
    }
  }
}
