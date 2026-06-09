import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:satha/core/networking/api_result.dart';
import 'package:satha/features/auth/data/models/auth_request_models.dart';
import 'package:satha/features/auth/data/models/user_role.dart';
import 'package:satha/features/auth/data/repos/auth_repo.dart';
import 'forgot_password_state.dart';

/// كيوبت استعادة كلمة المرور — يرسل رمز التحقق.
class ForgotPasswordCubit extends Cubit<ForgotPasswordState> {
  final AuthRepo _repo;
  final UserRole role;
  ForgotPasswordCubit(this._repo, {required this.role})
    : super(const ForgotPasswordState.initial());

  final formKey = GlobalKey<FormState>();
  final identifierController = TextEditingController();

  Future<void> sendCode() async {
    emit(const ForgotPasswordState.loading());
    final identifier = identifierController.text.trim();
    final result = await _repo.forgotPassword(
      ForgotPasswordRequestModel(identifier: identifier),
    );
    if (isClosed) return;
    result.when(
      success: (res) {
        if (res.status == 1) {
          emit(ForgotPasswordState.success(identifier));
        } else {
          emit(ForgotPasswordState.failure((res.message ?? '').tr()));
        }
      },
      error: (e) => emit(ForgotPasswordState.failure(e.message ?? '')),
    );
  }

  @override
  Future<void> close() {
    identifierController.dispose();
    return super.close();
  }
}
