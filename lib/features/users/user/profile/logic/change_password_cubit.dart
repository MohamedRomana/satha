import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:satha/core/logic/action_state.dart';

/// كيوبت تغيير كلمة المرور (mock).
class ChangePasswordCubit extends Cubit<ActionState> {
  ChangePasswordCubit() : super(const ActionState.idle());

  final formKey = GlobalKey<FormState>();
  final currentController = TextEditingController();
  final newController = TextEditingController();
  final confirmController = TextEditingController();

  Future<void> submit() async {
    if (!formKey.currentState!.validate()) return;
    emit(const ActionState.loading());
    await Future.delayed(const Duration(milliseconds: 700));
    if (isClosed) return;
    emit(const ActionState.success());
  }

  @override
  Future<void> close() {
    currentController.dispose();
    newController.dispose();
    confirmController.dispose();
    return super.close();
  }
}
