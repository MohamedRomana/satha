import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:satha/core/constants/app_constants.dart';
import 'package:satha/core/networking/api_result.dart';
import 'package:satha/features/auth/data/auth_session.dart';
import 'package:satha/features/auth/data/models/app_user.dart';
import 'package:satha/features/auth/data/models/user_role.dart';
import 'package:satha/features/auth/data/models/auth_request_models.dart';
import 'package:satha/features/auth/data/repos/auth_repo.dart';
import 'otp_state.dart';

/// الغرض من شاشة الـ OTP.
enum OtpPurpose { register, reset }

/// كيوبت التحقق برمز OTP — يتعامل مع تسجيل العميل واستعادة كلمة المرور.
class OtpCubit extends Cubit<OtpState> {
  final AuthRepo _repo;
  final String identifier;
  final OtpPurpose purpose;

  /// المستخدم الناتج عن التسجيل (في حالة [OtpPurpose.register]).
  final AppUser? user;

  OtpCubit(
    this._repo, {
    required this.identifier,
    required this.purpose,
    this.user,
  }) : super(const OtpState.initial()) {
    _startTimer();
  }

  final codeController = TextEditingController();
  Timer? _timer;
  int remainingSeconds = AppConstants.otpResendSeconds;
  bool get canResend => remainingSeconds <= 0;

  void _startTimer() {
    remainingSeconds = AppConstants.otpResendSeconds;
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (isClosed) {
        timer.cancel();
        return;
      }
      remainingSeconds--;
      if (remainingSeconds <= 0) {
        remainingSeconds = 0;
        timer.cancel();
      }
      emit(OtpState.tick(remainingSeconds));
    });
  }

  Future<void> resend() async {
    if (!canResend) return;
    await _repo.forgotPassword(ForgotPasswordRequestModel(identifier: identifier));
    if (isClosed) return;
    codeController.clear();
    _startTimer();
  }

  Future<void> verify() async {
    emit(const OtpState.loading());
    final result = await _repo.verifyOtp(
      OtpRequestModel(identifier: identifier, code: codeController.text.trim()),
    );
    if (isClosed) return;
    result.when(
      success: (res) async {
        if (res.status == 1) {
          if (purpose == OtpPurpose.register && user != null) {
            await AuthSession.save(
              user: user!,
              token: 'mock_token_${user!.role.key}',
            );
          }
          if (isClosed) return;
          emit(const OtpState.verified());
        } else {
          emit(OtpState.failure((res.message ?? '').tr()));
        }
      },
      error: (e) => emit(OtpState.failure(e.message ?? '')),
    );
  }

  @override
  Future<void> close() {
    _timer?.cancel();
    codeController.dispose();
    return super.close();
  }
}
