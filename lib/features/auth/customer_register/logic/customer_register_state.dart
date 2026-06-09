import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:satha/features/auth/data/models/app_user.dart';

part 'customer_register_state.freezed.dart';

@freezed
class CustomerRegisterState with _$CustomerRegisterState {
  const factory CustomerRegisterState.initial() = _Initial;
  const factory CustomerRegisterState.changed(int tick) = _Changed;
  const factory CustomerRegisterState.loading() = _Loading;
  const factory CustomerRegisterState.success(AppUser user) = _Success;
  const factory CustomerRegisterState.failure(String message) = _Failure;
}
