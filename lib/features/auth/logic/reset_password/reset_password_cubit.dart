import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/networking/api_result.dart';
import '../../data/models/auth_request_models.dart';
import '../../data/repos/auth_repo.dart';
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

  void onPasswordChanged(String _) => emit(const ResetPasswordState.changed());

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
