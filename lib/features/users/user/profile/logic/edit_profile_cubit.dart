import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:satha/core/cache/cache_helper.dart';
import 'package:satha/core/logic/action_state.dart';

/// كيوبت تعديل الملف الشخصي (mock).
class EditProfileCubit extends Cubit<ActionState> {
  EditProfileCubit() : super(const ActionState.idle()) {
    nameController.text = CacheHelper.getUserName();
  }

  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  File? avatar;

  void setAvatar(File file) {
    avatar = file;
    emit(const ActionState.idle());
  }

  Future<void> submit() async {
    if (!formKey.currentState!.validate()) return;
    emit(const ActionState.loading());
    await Future.delayed(const Duration(milliseconds: 700));
    await CacheHelper.setUserName(nameController.text.trim());
    if (isClosed) return;
    emit(const ActionState.success());
  }

  @override
  Future<void> close() {
    nameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    return super.close();
  }
}
