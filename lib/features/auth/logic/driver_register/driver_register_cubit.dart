import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../core/networking/api_result.dart';
import '../../data/models/auth_request_models.dart';
import '../../data/repos/auth_repo.dart';
import 'driver_register_state.dart';

/// نوع المستند المطلوب رفعه للسائق.
enum DriverDocType { idFront, idBack, license, vehicleLicense, permit }

/// كيوبت تسجيل السائق متعدّد الخطوات (4 خطوات).
class DriverRegisterCubit extends Cubit<DriverRegisterState> {
  final AuthRepo _repo;
  DriverRegisterCubit(this._repo) : super(const DriverRegisterState.initial());

  /// الخطوة الحالية (0..3).
  int currentStep = 0;
  static const int totalSteps = 4;

  // مفاتيح الفورم لكل خطوة.
  final step1FormKey = GlobalKey<FormState>();
  final step2FormKey = GlobalKey<FormState>();

  // ---- الخطوة 1: البيانات الشخصية ----
  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmController = TextEditingController();
  final nationalIdController = TextEditingController();
  String? city;
  File? profileImage;

  // ---- الخطوة 2: بيانات السطحة ----
  final towNameController = TextEditingController();
  final plateController = TextEditingController();
  final vehicleModelController = TextEditingController();
  final vehicleColorController = TextEditingController();
  final maxWeightController = TextEditingController();
  String? towType; // 'normal' / 'hydraulic'
  File? vehicleImage;

  // ---- الخطوة 3: المستندات ----
  final Map<DriverDocType, File?> documents = {};

  void onPasswordChanged(String _) => emit(const DriverRegisterState.changed());

  void selectCity(String? value) {
    city = value;
    emit(const DriverRegisterState.changed());
  }

  void selectTowType(String? value) {
    towType = value;
    emit(const DriverRegisterState.changed());
  }

  Future<void> _pick(void Function(File) onPicked) async {
    final picked = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      imageQuality: 70,
    );
    if (picked != null) {
      onPicked(File(picked.path));
      emit(const DriverRegisterState.changed());
    }
  }

  Future<void> pickProfileImage() => _pick((f) => profileImage = f);
  Future<void> pickVehicleImage() => _pick((f) => vehicleImage = f);
  Future<void> pickDocument(DriverDocType type) =>
      _pick((f) => documents[type] = f);

  void removeDocument(DriverDocType type) {
    documents.remove(type);
    emit(const DriverRegisterState.changed());
  }

  void removeProfileImage() {
    profileImage = null;
    emit(const DriverRegisterState.changed());
  }

  void removeVehicleImage() {
    vehicleImage = null;
    emit(const DriverRegisterState.changed());
  }

  /// المستندات الإلزامية مكتملة؟ (التصريح الإضافي اختياري)
  bool get requiredDocsComplete =>
      documents[DriverDocType.idFront] != null &&
      documents[DriverDocType.idBack] != null &&
      documents[DriverDocType.license] != null &&
      documents[DriverDocType.vehicleLicense] != null;

  void goToStep(int step) {
    currentStep = step.clamp(0, totalSteps - 1);
    emit(const DriverRegisterState.changed());
  }

  void nextStep() => goToStep(currentStep + 1);
  void prevStep() => goToStep(currentStep - 1);

  Future<void> submit() async {
    emit(const DriverRegisterState.loading());
    final result = await _repo.registerDriver(
      RegisterDriverRequestModel(
        personalInfo: DriverPersonalInfoModel(
          name: nameController.text.trim(),
          phone: phoneController.text.trim(),
          email: emailController.text.trim(),
          password: passwordController.text,
          nationalId: nationalIdController.text.trim(),
          city: city ?? '',
          image: profileImage?.path,
        ),
        towTruck: TowTruckModel(
          name: towNameController.text.trim(),
          type: towType ?? 'normal',
          plateNumber: plateController.text.trim(),
          vehicleModel: vehicleModelController.text.trim(),
          vehicleColor: vehicleColorController.text.trim(),
          maxWeight: maxWeightController.text.trim().isEmpty
              ? null
              : maxWeightController.text.trim(),
          image: vehicleImage?.path,
        ),
        documents: DriverDocumentsModel(
          nationalIdFront: documents[DriverDocType.idFront]?.path,
          nationalIdBack: documents[DriverDocType.idBack]?.path,
          drivingLicense: documents[DriverDocType.license]?.path,
          vehicleLicense: documents[DriverDocType.vehicleLicense]?.path,
          additionalPermit: documents[DriverDocType.permit]?.path,
        ),
      ),
    );
    if (isClosed) return;
    result.when(
      success: (res) {
        if (res.status == 1) {
          emit(const DriverRegisterState.success());
        } else {
          emit(DriverRegisterState.failure((res.message ?? '').tr()));
        }
      },
      error: (e) => emit(DriverRegisterState.failure(e.message ?? '')),
    );
  }

  @override
  Future<void> close() {
    nameController.dispose();
    phoneController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmController.dispose();
    nationalIdController.dispose();
    towNameController.dispose();
    plateController.dispose();
    vehicleModelController.dispose();
    vehicleColorController.dispose();
    maxWeightController.dispose();
    return super.close();
  }
}
