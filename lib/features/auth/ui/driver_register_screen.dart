import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/constants/app_constants.dart';
import '../../../core/constants/colors.dart';
import '../../../core/helper/extentions.dart';
import '../../../core/helper/validators.dart';
import '../../../core/routing/routes.dart';
import '../../../core/widgets/app_logo.dart';
import '../../../core/widgets/auth_background.dart';
import '../../../core/widgets/flash_message.dart';
import '../../../core/widgets/lang_toggle.dart';
import '../../../core/widgets/password_field.dart';
import '../../../core/widgets/password_strength_bar.dart';
import '../../../core/widgets/primary_button.dart';
import '../../../core/widgets/satha_dropdown.dart';
import '../../../core/widgets/satha_field.dart';
import '../../../gen/fonts.gen.dart';
import '../../../generated/locale_keys.g.dart';
import '../logic/driver_register/driver_register_cubit.dart';
import '../logic/driver_register/driver_register_state.dart';
import 'widgets/document_upload_card.dart';
import 'widgets/driver_steps_progress.dart';
import 'widgets/profile_image_picker.dart';

/// شاشة تسجيل السائق متعدّدة الخطوات (4 خطوات + مؤشّر تقدّم متحرّك).
class DriverRegisterScreen extends StatelessWidget {
  const DriverRegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<DriverRegisterCubit>();
    final stepTitles = [
      LocaleKeys.driverPersonalInfo.tr(),
      LocaleKeys.driverTowInfo.tr(),
      LocaleKeys.driverDocuments.tr(),
      LocaleKeys.driverReview.tr(),
    ];

    return Scaffold(
      body: AnimatedAuthBackground(
        child: SafeArea(
          child: BlocConsumer<DriverRegisterCubit, DriverRegisterState>(
            listener: (context, state) {
              state.whenOrNull(
                failure: (msg) => showFlashMessage(
                  message: msg,
                  type: FlashMessageType.error,
                  context: context,
                ),
                success: () => context.pushReplacementNamed(
                  Routes.driverRegisterPending,
                ),
              );
            },
            builder: (context, state) {
              final loading =
                  state.maybeWhen(loading: () => true, orElse: () => false);
              final step = cubit.currentStep;
              return Column(
                children: [
                  _topBar(context),
                  SizedBox(height: 6.h),
                  Text(
                    stepTitles[step],
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18.sp,
                      fontFamily: FontFamily.tajawalBold,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 12.h),
                    child: DriverStepsProgress(
                      currentStep: step,
                      steps: stepTitles,
                    ),
                  ),
                  Expanded(
                    child: Container(
                      width: double.infinity,
                      margin: EdgeInsets.symmetric(horizontal: 16.w),
                      padding: EdgeInsets.all(18.w),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(28.r),
                        ),
                      ),
                      child: AnimatedSwitcher(
                        duration: const Duration(milliseconds: 300),
                        transitionBuilder: (child, anim) => FadeTransition(
                          opacity: anim,
                          child: SlideTransition(
                            position: Tween(
                              begin: const Offset(0.15, 0),
                              end: Offset.zero,
                            ).animate(anim),
                            child: child,
                          ),
                        ),
                        child: SingleChildScrollView(
                          key: ValueKey(step),
                          physics: const BouncingScrollPhysics(),
                          child: _stepBody(context, cubit, step),
                        ),
                      ),
                    ),
                  ),
                  _navBar(context, cubit, loading),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _topBar(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          AppLogo(size: 44, hero: false),
          LangToggle(),
        ],
      ),
    );
  }

  Widget _stepBody(BuildContext context, DriverRegisterCubit cubit, int step) {
    switch (step) {
      case 0:
        return _StepPersonal(cubit: cubit);
      case 1:
        return _StepTow(cubit: cubit);
      case 2:
        return _StepDocuments(cubit: cubit);
      default:
        return _StepReview(cubit: cubit);
    }
  }

  Widget _navBar(
    BuildContext context,
    DriverRegisterCubit cubit,
    bool loading,
  ) {
    final isFirst = cubit.currentStep == 0;
    final isLast = cubit.currentStep == DriverRegisterCubit.totalSteps - 1;
    return Container(
      padding: EdgeInsets.fromLTRB(16.w, 12.h, 16.w, 16.h),
      color: Colors.white,
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: OutlinedButton(
              onPressed: () {
                if (isFirst) {
                  context.pop();
                } else {
                  cubit.prevStep();
                }
              },
              style: OutlinedButton.styleFrom(
                minimumSize: Size(0, 54.h),
                side: const BorderSide(color: AppColors.border),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16.r),
                ),
              ),
              child: Text(
                LocaleKeys.previous.tr(),
                style: TextStyle(
                  color: AppColors.navy,
                  fontFamily: FontFamily.tajawalBold,
                  fontSize: 15.sp,
                ),
              ),
            ),
          ),
          SizedBox(width: 12.w),
          Expanded(
            flex: 3,
            child: PrimaryButton(
              text: isLast
                  ? LocaleKeys.confirmAndSubmit.tr()
                  : LocaleKeys.next.tr(),
              loading: loading,
              onPressed: () => _onNext(context, cubit),
            ),
          ),
        ],
      ),
    );
  }

  void _onNext(BuildContext context, DriverRegisterCubit cubit) {
    switch (cubit.currentStep) {
      case 0:
        if (!cubit.step1FormKey.currentState!.validate()) return;
        if (cubit.city == null) {
          _warn(context, LocaleKeys.selectCityRequired.tr());
          return;
        }
        cubit.nextStep();
        break;
      case 1:
        if (!cubit.step2FormKey.currentState!.validate()) return;
        if (cubit.towType == null) {
          _warn(context, LocaleKeys.selectTowTypeRequired.tr());
          return;
        }
        cubit.nextStep();
        break;
      case 2:
        if (!cubit.requiredDocsComplete) {
          _warn(context, LocaleKeys.attachRequiredImages.tr());
          return;
        }
        cubit.nextStep();
        break;
      default:
        cubit.submit();
    }
  }

  void _warn(BuildContext context, String message) => showFlashMessage(
        message: message,
        type: FlashMessageType.warning,
        context: context,
      );
}

// ============ الخطوة 1: البيانات الشخصية ============
class _StepPersonal extends StatelessWidget {
  final DriverRegisterCubit cubit;
  const _StepPersonal({required this.cubit});

  @override
  Widget build(BuildContext context) {
    return Form(
      key: cubit.step1FormKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: ProfileImagePicker(
              image: cubit.profileImage,
              onTap: cubit.pickProfileImage,
              label: LocaleKeys.profile_image.tr(),
            ),
          ),
          SizedBox(height: 18.h),
          SathaField(
            controller: cubit.nameController,
            label: LocaleKeys.fullName.tr(),
            prefixIcon: Icons.person_outline_rounded,
            validator: Validators.fullName,
          ),
          SizedBox(height: 14.h),
          SathaPhoneField(
            controller: cubit.phoneController,
            label: LocaleKeys.phone.tr(),
            validator: Validators.phone,
          ),
          SizedBox(height: 14.h),
          SathaField(
            controller: cubit.emailController,
            label: LocaleKeys.email.tr(),
            prefixIcon: Icons.email_outlined,
            keyboardType: TextInputType.emailAddress,
            validator: Validators.email,
          ),
          SizedBox(height: 14.h),
          SathaPasswordField(
            controller: cubit.passwordController,
            label: LocaleKeys.password.tr(),
            validator: Validators.password,
            onChanged: cubit.onPasswordChanged,
          ),
          PasswordStrengthBar(password: cubit.passwordController.text),
          SizedBox(height: 14.h),
          SathaPasswordField(
            controller: cubit.confirmController,
            label: LocaleKeys.confirmPassword.tr(),
            validator: (v) =>
                Validators.confirmPassword(v, cubit.passwordController.text),
          ),
          SizedBox(height: 14.h),
          SathaField(
            controller: cubit.nationalIdController,
            label: LocaleKeys.nationalIdNumber.tr(),
            prefixIcon: Icons.badge_outlined,
            keyboardType: TextInputType.number,
            validator: (v) => Validators.required(
              v,
              message: LocaleKeys.nationalIdRequired.tr(),
            ),
          ),
          SizedBox(height: 14.h),
          SathaDropdown<String>(
            label: LocaleKeys.city.tr(),
            hint: LocaleKeys.selectCity.tr(),
            value: cubit.city,
            prefixIcon: Icons.location_city_rounded,
            items: [
              for (final c in AppConstants.cities)
                DropdownMenuItem(value: c, child: Text(c)),
            ],
            onChanged: cubit.selectCity,
          ),
        ],
      ),
    );
  }
}

// ============ الخطوة 2: بيانات السطحة ============
class _StepTow extends StatelessWidget {
  final DriverRegisterCubit cubit;
  const _StepTow({required this.cubit});

  @override
  Widget build(BuildContext context) {
    return Form(
      key: cubit.step2FormKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: ProfileImagePicker(
              image: cubit.vehicleImage,
              onTap: cubit.pickVehicleImage,
              label: LocaleKeys.vehicleImage.tr(),
            ),
          ),
          SizedBox(height: 18.h),
          SathaField(
            controller: cubit.towNameController,
            label: LocaleKeys.towTruckName.tr(),
            prefixIcon: Icons.local_shipping_outlined,
            validator: (v) => Validators.required(
              v,
              message: LocaleKeys.towTruckNameRequired.tr(),
            ),
          ),
          SizedBox(height: 14.h),
          SathaDropdown<String>(
            label: LocaleKeys.towTruckType.tr(),
            hint: LocaleKeys.towTruckType.tr(),
            value: cubit.towType,
            prefixIcon: Icons.category_outlined,
            items: [
              DropdownMenuItem(
                value: 'normal',
                child: Text(LocaleKeys.normalTow.tr()),
              ),
              DropdownMenuItem(
                value: 'hydraulic',
                child: Text(LocaleKeys.hydraulicTow.tr()),
              ),
            ],
            onChanged: cubit.selectTowType,
          ),
          SizedBox(height: 14.h),
          SathaField(
            controller: cubit.plateController,
            label: LocaleKeys.plateNumber.tr(),
            prefixIcon: Icons.confirmation_number_outlined,
            validator: (v) => Validators.required(
              v,
              message: LocaleKeys.plateNumberRequired.tr(),
            ),
          ),
          SizedBox(height: 14.h),
          SathaField(
            controller: cubit.vehicleModelController,
            label: LocaleKeys.vehicleModelField.tr(),
            prefixIcon: Icons.directions_car_outlined,
            validator: (v) => Validators.required(
              v,
              message: LocaleKeys.vehicleModelRequired.tr(),
            ),
          ),
          SizedBox(height: 14.h),
          SathaField(
            controller: cubit.vehicleColorController,
            label: LocaleKeys.vehicleColor.tr(),
            prefixIcon: Icons.palette_outlined,
            validator: (v) => Validators.required(
              v,
              message: LocaleKeys.vehicleColorRequired.tr(),
            ),
          ),
          SizedBox(height: 14.h),
          SathaField(
            controller: cubit.maxWeightController,
            label: LocaleKeys.maxWeight.tr(),
            prefixIcon: Icons.scale_outlined,
            keyboardType: TextInputType.number,
            textInputAction: TextInputAction.done,
          ),
        ],
      ),
    );
  }
}

// ============ الخطوة 3: المستندات ============
class _StepDocuments extends StatelessWidget {
  final DriverRegisterCubit cubit;
  const _StepDocuments({required this.cubit});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        DocumentUploadCard(
          title: LocaleKeys.nationalIdFront.tr(),
          file: cubit.documents[DriverDocType.idFront],
          onPick: () => cubit.pickDocument(DriverDocType.idFront),
          onRemove: () => cubit.removeDocument(DriverDocType.idFront),
        ),
        DocumentUploadCard(
          title: LocaleKeys.nationalIdBack.tr(),
          file: cubit.documents[DriverDocType.idBack],
          onPick: () => cubit.pickDocument(DriverDocType.idBack),
          onRemove: () => cubit.removeDocument(DriverDocType.idBack),
        ),
        DocumentUploadCard(
          title: LocaleKeys.drivingLicenseImage.tr(),
          file: cubit.documents[DriverDocType.license],
          onPick: () => cubit.pickDocument(DriverDocType.license),
          onRemove: () => cubit.removeDocument(DriverDocType.license),
        ),
        DocumentUploadCard(
          title: LocaleKeys.vehicleLicenseImage.tr(),
          file: cubit.documents[DriverDocType.vehicleLicense],
          onPick: () => cubit.pickDocument(DriverDocType.vehicleLicense),
          onRemove: () => cubit.removeDocument(DriverDocType.vehicleLicense),
        ),
        DocumentUploadCard(
          title: LocaleKeys.additionalPermit.tr(),
          isRequired: false,
          file: cubit.documents[DriverDocType.permit],
          onPick: () => cubit.pickDocument(DriverDocType.permit),
          onRemove: () => cubit.removeDocument(DriverDocType.permit),
        ),
      ],
    );
  }
}

// ============ الخطوة 4: مراجعة البيانات ============
class _StepReview extends StatelessWidget {
  final DriverRegisterCubit cubit;
  const _StepReview({required this.cubit});

  @override
  Widget build(BuildContext context) {
    final towLabel = cubit.towType == 'hydraulic'
        ? LocaleKeys.hydraulicTow.tr()
        : LocaleKeys.normalTow.tr();
    return Column(
      children: [
        _section(LocaleKeys.driverPersonalInfo.tr(), [
          (LocaleKeys.fullName.tr(), cubit.nameController.text),
          (LocaleKeys.phone.tr(), cubit.phoneController.text),
          (LocaleKeys.email.tr(), cubit.emailController.text),
          (LocaleKeys.nationalIdNumber.tr(), cubit.nationalIdController.text),
          (LocaleKeys.city.tr(), cubit.city ?? ''),
        ]),
        _section(LocaleKeys.driverTowInfo.tr(), [
          (LocaleKeys.towTruckName.tr(), cubit.towNameController.text),
          (LocaleKeys.towTruckType.tr(), towLabel),
          (LocaleKeys.plateNumber.tr(), cubit.plateController.text),
          (LocaleKeys.vehicleModelField.tr(), cubit.vehicleModelController.text),
          (LocaleKeys.vehicleColor.tr(), cubit.vehicleColorController.text),
        ]),
        _documents(),
      ],
    );
  }

  Widget _section(String title, List<(String, String)> rows) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(bottom: 14.h),
      padding: EdgeInsets.all(14.w),
      decoration: BoxDecoration(
        color: AppColors.lightBg,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 14.sp,
              color: AppColors.orange,
              fontFamily: FontFamily.tajawalBold,
            ),
          ),
          SizedBox(height: 10.h),
          for (final row in rows)
            Padding(
              padding: EdgeInsets.symmetric(vertical: 4.h),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 110.w,
                    child: Text(
                      row.$1,
                      style: TextStyle(
                        fontSize: 12.sp,
                        color: AppColors.secondaryText,
                        fontFamily: FontFamily.tajawalRegular,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Text(
                      row.$2.isEmpty ? '—' : row.$2,
                      style: TextStyle(
                        fontSize: 12.5.sp,
                        color: AppColors.mainText,
                        fontFamily: FontFamily.tajawalMedium,
                      ),
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }

  Widget _documents() {
    final docs = <(String, File?)>[
      (LocaleKeys.nationalIdFront.tr(), cubit.documents[DriverDocType.idFront]),
      (LocaleKeys.nationalIdBack.tr(), cubit.documents[DriverDocType.idBack]),
      (LocaleKeys.drivingLicenseImage.tr(), cubit.documents[DriverDocType.license]),
      (
        LocaleKeys.vehicleLicenseImage.tr(),
        cubit.documents[DriverDocType.vehicleLicense],
      ),
    ];
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(14.w),
      decoration: BoxDecoration(
        color: AppColors.lightBg,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            LocaleKeys.driverDocuments.tr(),
            style: TextStyle(
              fontSize: 14.sp,
              color: AppColors.orange,
              fontFamily: FontFamily.tajawalBold,
            ),
          ),
          SizedBox(height: 10.h),
          Wrap(
            spacing: 10.w,
            runSpacing: 10.h,
            children: [
              for (final d in docs)
                Column(
                  children: [
                    Container(
                      width: 60.w,
                      height: 60.w,
                      clipBehavior: Clip.antiAlias,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12.r),
                        border: Border.all(color: AppColors.border),
                      ),
                      child: d.$2 != null
                          ? Image.file(d.$2!, fit: BoxFit.cover)
                          : Icon(Icons.image_outlined,
                              color: AppColors.secondaryText, size: 22.w),
                    ),
                    SizedBox(height: 4.h),
                    SizedBox(
                      width: 64.w,
                      child: Text(
                        d.$1,
                        textAlign: TextAlign.center,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 8.5.sp,
                          color: AppColors.secondaryText,
                        ),
                      ),
                    ),
                  ],
                ),
            ],
          ),
        ],
      ),
    );
  }
}
