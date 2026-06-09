import 'package:freezed_annotation/freezed_annotation.dart';

part 'otp_state.freezed.dart';

@freezed
class OtpState with _$OtpState {
  const factory OtpState.initial() = _Initial;
  const factory OtpState.tick(int seconds) = _Tick;
  const factory OtpState.loading() = _Loading;
  const factory OtpState.verified() = _Verified;
  const factory OtpState.failure(String message) = _Failure;
}
