import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:satha/features/auth/data/models/app_user.dart';

part 'login_state.freezed.dart';

@freezed
class LoginState with _$LoginState {
  const factory LoginState.initial() = _Initial;
  const factory LoginState.isSecure(bool isSecure) = _IsSecure;
  const factory LoginState.loading() = _Loading;
  const factory LoginState.success(AppUser user) = _Success;
  const factory LoginState.failure(String message) = _Failure;
}
