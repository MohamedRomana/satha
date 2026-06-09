import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:satha/core/networking/api_result.dart';
import 'package:satha/features/auth/data/models/auth_request_models.dart';
import 'package:satha/features/auth/data/repos/auth_repo.dart';
import 'reset_password_state.dart';

/// كيوبت إنشاء كلمة مرور جديدة بعد التحقق.
class ResetPasswordCubit extends Cubit<ResetPasswordState> {
  final AuthRepo _repo;
  final String identifier;
  final String code;

  ResetPasswordCubit(
    this._repo, {
    required this.identifier,
    required this.code,
  }) : super(const ResetPasswordState.initial());

  final formKey = GlobalKey<FormState>();
  final passwordController = TextEditingController();
  final confirmController = TextEditingController();

  int _tick = 0;
  void onPasswordChanged(String _) =>
      emit(ResetPasswordState.changed(_tick++));

  Future<void> submit() async {
    emit(const ResetPasswordState.loading());
    final result = await _repo.resetPassword(
      ResetPasswordRequestModel(
        identifier: identifier,
        code: code,
        newPassword: passwordController.text,
      ),
    );
    if (isClosed) return;
    result.when(
      success: (res) {
        if (res.status == 1) {
          emit(const ResetPasswordState.success());
        } else {
          emit(ResetPasswordState.failure((res.message ?? '').tr()));
        }
      },
      error: (e) => emit(ResetPasswordState.failure(e.message ?? '')),
    );
  }

  @override
  Future<void> close() {
    passwordController.dispose();
    confirmController.dispose();
    return super.close();
  }
}
