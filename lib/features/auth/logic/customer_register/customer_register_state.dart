import 'package:freezed_annotation/freezed_annotation.dart';

import '../../data/models/app_user.dart';

part 'customer_register_state.freezed.dart';

@freezed
class CustomerRegisterState with _$CustomerRegisterState {
  const factory CustomerRegisterState.initial() = _Initial;
  const factory CustomerRegisterState.changed() = _Changed;
  const factory CustomerRegisterState.loading() = _Loading;
  const factory CustomerRegisterState.success(AppUser user) = _Success;
  const factory CustomerRegisterState.failure(String message) = _Failure;
}
