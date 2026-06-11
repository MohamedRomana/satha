import 'package:flutter_bloc/flutter_bloc.dart';

import 'otp_confirm_state.dart';

/// كيوبت تأكيد رمز التحقق (وصول السائق / إتمام الرحلة).
/// الرمز الوهمي: 123456.
class OtpConfirmCubit extends Cubit<OtpConfirmState> {
  OtpConfirmCubit() : super(const OtpConfirmState.idle());

  static const String mockOtp = '123456';

  Future<void> verify(String code) async {
    emit(const OtpConfirmState.verifying());
    await Future.delayed(const Duration(milliseconds: 600));
    if (isClosed) return;
    if (code == mockOtp) {
      emit(const OtpConfirmState.success());
    } else {
      emit(const OtpConfirmState.error('invalid'));
    }
  }

  void reset() => emit(const OtpConfirmState.idle());
}
