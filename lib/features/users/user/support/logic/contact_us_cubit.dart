import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:satha/core/logic/action_state.dart';
import '../data/repos/support_repository.dart';

/// كيوبت نموذج تواصل معنا.
class ContactUsCubit extends Cubit<ActionState> {
  final SupportRepository _repo;
  ContactUsCubit(this._repo) : super(const ActionState.idle());

  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final messageController = TextEditingController();

  Future<void> submit() async {
    if (!formKey.currentState!.validate()) return;
    emit(const ActionState.loading());
    try {
      await _repo.submitContactMessage(
        nameController.text.trim(),
        emailController.text.trim(),
        messageController.text.trim(),
      );
      if (isClosed) return;
      emit(const ActionState.success());
    } catch (e) {
      if (isClosed) return;
      emit(ActionState.error(e.toString()));
    }
  }

  @override
  Future<void> close() {
    nameController.dispose();
    emailController.dispose();
    messageController.dispose();
    return super.close();
  }
}
