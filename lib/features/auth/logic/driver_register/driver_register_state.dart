import 'package:freezed_annotation/freezed_annotation.dart';

part 'driver_register_state.freezed.dart';

@freezed
class DriverRegisterState with _$DriverRegisterState {
  const factory DriverRegisterState.initial() = _Initial;
  const factory DriverRegisterState.changed() = _Changed;
  const factory DriverRegisterState.loading() = _Loading;
  const factory DriverRegisterState.success() = _Success;
  const factory DriverRegisterState.failure(String message) = _Failure;
}
