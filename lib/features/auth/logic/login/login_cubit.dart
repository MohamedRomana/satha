import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/cache/cache_helper.dart';
import '../../../../core/networking/api_result.dart';
import '../../data/auth_session.dart';
import '../../data/models/auth_request_models.dart';
import '../../data/models/user_role.dart';
import '../../data/repos/auth_repo.dart';
import 'login_state.dart';

/// كيوبت تسجيل الدخول — مشترك بين العميل/السائق/المسؤول حسب [role].
class LoginCubit extends Cubit<LoginState> {
  final AuthRepo _repo;
  final UserRole role;

  LoginCubit(this._repo, {required this.role})
    : super(const LoginState.initial()) {
    rememberMe = CacheHelper.getRememberMe();
  }

  final formKey = GlobalKey<FormState>();
  final identifierController = TextEditingController();
  final passwordController = TextEditingController();
  bool rememberMe = false;

  void toggleRemember(bool value) {
    rememberMe = value;
    CacheHelper.setRememberMe(value);
    emit(LoginState.isSecure(value));
  }

  Future<void> login() async {
    emit(const LoginState.loading());
    final result = await _repo.login(
      LoginRequestModel(
        phoneOrEmail: identifierController.text.trim(),
        password: passwordController.text,
        role: role.key,
        lang: CacheHelper.getLang().isEmpty ? 'ar' : CacheHelper.getLang(),
      ),
    );
    if (isClosed) return;
    result.when(
      success: (res) async {
        if (res.status == 1 && res.user != null) {
          final user = res.user!.toEntity();
          await AuthSession.save(user: user, token: res.token ?? '');
          if (isClosed) return;
          emit(LoginState.success(user));
        } else {
          emit(LoginState.failure((res.message ?? '').tr()));
        }
      },
      error: (e) => emit(LoginState.failure(e.message ?? '')),
    );
  }

  @override
  Future<void> close() {
    identifierController.dispose();
    passwordController.dispose();
    return super.close();
  }
}
