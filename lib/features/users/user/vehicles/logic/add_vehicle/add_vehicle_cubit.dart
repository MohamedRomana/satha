import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:satha/generated/locale_keys.g.dart';
import '../../data/models/vehicle_model.dart';
import '../../data/repos/vehicles_repository.dart';
import 'add_vehicle_state.dart';

/// كيوبت إضافة سيارة جديدة.
class AddVehicleCubit extends Cubit<AddVehicleState> {
  final VehiclesRepository _repo;
  AddVehicleCubit(this._repo) : super(const AddVehicleState.changed(0));

  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final modelController = TextEditingController();
  final plateController = TextEditingController();
  final chassisController = TextEditingController();
  final notesController = TextEditingController();

  File? image;
  String? brand;
  int? year;
  String? color;
  VehicleCategory? category;
  bool isDefault = false;

  int _tick = 0;
  void _refresh() => emit(AddVehicleState.changed(++_tick));

  void setImage(File file) {
    image = file;
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
    if (image == null) {
      emit(const AddVehicleState.failure(LocaleKeys.vehImageRequired));
      return;
    }
    if (!formKey.currentState!.validate()) return;
    emit(const AddVehicleState.submitting());
    try {
      final vehicle = await _repo.addVehicle(
        VehicleModel(
          id: '',
          imagePath: image!.path,
          name: nameController.text.trim(),
          brand: brand ?? '',
          model: modelController.text.trim(),
          year: year ?? 0,
          color: color ?? '',
          plateNumber: plateController.text.trim(),
          chassisNumber: chassisController.text.trim(),
          category: category ?? VehicleCategory.other,
          notes: notesController.text.trim().isEmpty
              ? null
              : notesController.text.trim(),
          isDefault: isDefault,
        ),
      );
      if (isClosed) return;
      emit(AddVehicleState.success(vehicle));
    } catch (e) {
      if (isClosed) return;
      emit(AddVehicleState.failure(e.toString()));
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
