import 'package:freezed_annotation/freezed_annotation.dart';

import '../../data/models/order_model.dart';

part 'order_details_state.freezed.dart';

@freezed
class OrderDetailsState with _$OrderDetailsState {
  const factory OrderDetailsState.initial() = _Initial;
  const factory OrderDetailsState.loading() = OrderDetailsLoading;
  const factory OrderDetailsState.loaded(OrderModel order) = OrderDetailsLoaded;
  const factory OrderDetailsState.error(String message) = OrderDetailsError;
  const factory OrderDetailsState.actionLoading() = OrderDetailsActionLoading;
  const factory OrderDetailsState.actionSuccess(String message) =
      OrderDetailsActionSuccess;
  const factory OrderDetailsState.actionError(String message) =
      OrderDetailsActionError;
}
