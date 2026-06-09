import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../core/networking/api_result.dart';
import '../../data/models/auth_request_models.dart';
import '../../data/repos/auth_repo.dart';
import 'customer_register_state.dart';

/// كيوبت تسجيل حساب عميل جديد.
class CustomerRegisterCubit extends Cubit<CustomerRegisterState> {
  final AuthRepo _repo;
  CustomerRegisterCubit(this._repo)
    : super(const CustomerRegisterState.initial());

  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmController = TextEditingController();

  File? profileImage;
  bool agreeTerms = false;

  void toggleTerms(bool value) {
    agreeTerms = value;
    emit(const CustomerRegisterState.changed());
  }

  void onPasswordChanged(String _) => emit(const CustomerRegisterState.changed());

  Future<void> pickProfileImage() async {
    final picked = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      imageQuality: 70,
    );
    if (picked != null) {
      profileImage = File(picked.path);
      emit(const CustomerRegisterState.changed());
    }
  }

  Future<void> register() async {
    emit(const CustomerRegisterState.loading());
    final result = await _repo.registerCustomer(
      RegisterCustomerRequestModel(
        name: nameController.text.trim(),
        phone: phoneController.text.trim(),
        email: emailController.text.trim(),
        password: passwordController.text,
        image: profileImage?.path,
      ),
    );
    if (isClosed) return;
    result.when(
      success: (res) {
        if (res.status == 1 && res.user != null) {
          emit(CustomerRegisterState.success(res.user!.toEntity()));
        } else {
          emit(CustomerRegisterState.failure((res.message ?? '').tr()));
        }
      },
      error: (e) => emit(CustomerRegisterState.failure(e.message ?? '')),
    );
  }

  @override
  Future<void> close() {
    nameController.dispose();
    phoneController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmController.dispose();
    return super.close();
  }
}
