import 'package:freezed_annotation/freezed_annotation.dart';

part 'otp_confirm_state.freezed.dart';

@freezed
class OtpConfirmState with _$OtpConfirmState {
  const factory OtpConfirmState.idle() = OtpConfirmIdle;
  const factory OtpConfirmState.verifying() = OtpConfirmVerifying;
  const factory OtpConfirmState.success() = OtpConfirmSuccess;
  const factory OtpConfirmState.error(String message) = OtpConfirmError;
}
