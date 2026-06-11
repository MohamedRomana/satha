import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:satha/core/logic/action_state.dart';
import '../data/models/support_models.dart';
import '../data/repos/support_repository.dart';

/// كيوبت الإبلاغ عن مشكلة.
class ReportIssueCubit extends Cubit<ActionState> {
  final SupportRepository _repo;
  ReportIssueCubit(this._repo) : super(const ActionState.idle());

  String? orderId;
  ComplaintCategory? category;
  String description = '';
  final List<File> screenshots = [];

  void selectCategory(ComplaintCategory c) {
    category = c;
    emit(const ActionState.idle());
  }

  void addScreenshot(File file) {
    if (screenshots.length >= 3) return;
    screenshots.add(file);
    emit(const ActionState.idle());
  }

  void removeScreenshot(int index) {
    if (index >= 0 && index < screenshots.length) {
      screenshots.removeAt(index);
      emit(const ActionState.idle());
    }
  }

  Future<void> submit() async {
    if (category == null) {
      emit(const ActionState.error('category'));
      return;
    }
    if (description.trim().isEmpty) {
      emit(const ActionState.error('description'));
      return;
    }
    emit(const ActionState.loading());
    try {
      await _repo.submitComplaint(
        ComplaintModel(
          orderId: orderId,
          category: category!,
          description: description.trim(),
          screenshots: screenshots.map((f) => f.path).toList(),
        ),
      );
      if (isClosed) return;
      emit(const ActionState.success());
    } catch (e) {
      if (isClosed) return;
      emit(ActionState.error(e.toString()));
    }
  }
}
