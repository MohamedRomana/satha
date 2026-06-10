import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/models/vehicle_model.dart';
import '../../data/repos/vehicles_repository.dart';
import 'edit_vehicle_state.dart';

/// كيوبت تعديل سيارة (يملأ الحقول من السيارة الأصلية).
class EditVehicleCubit extends Cubit<EditVehicleState> {
  final VehiclesRepository _repo;
  final VehicleModel original;

  EditVehicleCubit(this._repo, this.original)
    : super(const EditVehicleState.changed(0)) {
    nameController.text = original.name;
    modelController.text = original.model;
    plateController.text = original.plateNumber;
    chassisController.text = original.chassisNumber;
    notesController.text = original.notes ?? '';
    brand = original.brand;
    year = original.year;
    color = original.color;
    category = original.category;
    isDefault = original.isDefault;
    existingImagePath = original.imagePath;
  }

  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final modelController = TextEditingController();
  final plateController = TextEditingController();
  final chassisController = TextEditingController();
  final notesController = TextEditingController();

  File? newImage;
  String? existingImagePath;
  String? brand;
  int? year;
  String? color;
  VehicleCategory? category;
  bool isDefault = false;

  String? get imagePath => newImage?.path ?? existingImagePath;

  int _tick = 0;
  void _refresh() => emit(EditVehicleState.changed(++_tick));

  void setImage(File file) {
    newImage = file;
    _refresh();
  }

  void setBrand(String? v) {
    brand = v;
    _refresh();
  }

  void setYear(int? v) {
    year = v;
    _refresh();
  }

  void setColor(String? v) {
    color = v;
    _refresh();
  }

  void setCategory(VehicleCategory? v) {
    category = v;
    _refresh();
  }

  void toggleDefault(bool v) {
    isDefault = v;
    _refresh();
  }

  Future<void> submit() async {
    if (!formKey.currentState!.validate()) return;
    emit(const EditVehicleState.submitting());
    try {
      final updated = await _repo.updateVehicle(
        original.copyWith(
          imagePath: imagePath,
          name: nameController.text.trim(),
          brand: brand,
          model: modelController.text.trim(),
          year: year,
          color: color,
          plateNumber: plateController.text.trim(),
          chassisNumber: chassisController.text.trim(),
          category: category,
          notes: notesController.text.trim().isEmpty
              ? null
              : notesController.text.trim(),
          isDefault: isDefault,
        ),
      );
      if (isClosed) return;
      emit(EditVehicleState.success(updated));
    } catch (e) {
      if (isClosed) return;
      emit(EditVehicleState.failure(e.toString()));
    }
  }

  @override
  Future<void> close() {
    nameController.dispose();
    modelController.dispose();
    plateController.dispose();
    chassisController.dispose();
    notesController.dispose();
    return super.close();
  }
}
