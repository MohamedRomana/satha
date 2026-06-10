import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';

import 'package:satha/core/constants/colors.dart';
import 'package:satha/core/di/dependancy_injection.dart';
import 'package:satha/core/helper/extentions.dart';
import 'package:satha/core/widgets/flash_message.dart';
import 'package:satha/core/widgets/image_source_sheet.dart';
import 'package:satha/core/widgets/primary_button.dart';
import 'package:satha/gen/fonts.gen.dart';
import 'package:satha/generated/locale_keys.g.dart';
import '../data/models/vehicle_model.dart';
import '../logic/edit_vehicle/edit_vehicle_cubit.dart';
import '../logic/edit_vehicle/edit_vehicle_state.dart';
import 'widgets/vehicle_form_fields.dart';

/// شاشة تعديل سيارة.
class EditVehicleScreen extends StatelessWidget {
  final VehicleModel vehicle;
  const EditVehicleScreen({super.key, required this.vehicle});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => EditVehicleCubit(getIt(), vehicle),
      child: const _EditVehicleView(),
    );
  }
}

class _EditVehicleView extends StatelessWidget {
  const _EditVehicleView();

  Future<void> _pickImage(BuildContext context) async {
    final cubit = context.read<EditVehicleCubit>();
    final source = await ImageSourceSheet.show(context);
    if (source == null) return;
    final picked =
        await ImagePicker().pickImage(source: source, imageQuality: 70);
    if (picked != null) cubit.setImage(File(picked.path));
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<EditVehicleCubit>();
    return Scaffold(
      backgroundColor: AppColors.lightBg,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          LocaleKeys.editVehicleTitle.tr(),
          style: TextStyle(
            fontSize: 18.sp,
            color: AppColors.mainText,
            fontFamily: FontFamily.tajawalBold,
          ),
        ),
      ),
      body: BlocConsumer<EditVehicleCubit, EditVehicleState>(
        listener: (context, state) {
          state.whenOrNull(
            success: (_) {
              showFlashMessage(
                message: LocaleKeys.vehicleUpdatedMsg.tr(),
                type: FlashMessageType.success,
                context: context,
              );
              context.pop(true);
            },
            failure: (msg) => showFlashMessage(
              message: msg.tr(),
              type: FlashMessageType.error,
              context: context,
            ),
          );
        },
        builder: (context, state) {
          final submitting =
              state.maybeWhen(submitting: () => true, orElse: () => false);
          return Form(
            key: cubit.formKey,
            child: ListView(
              physics: const BouncingScrollPhysics(),
              padding: EdgeInsets.fromLTRB(20.w, 14.h, 20.w, 24.h),
              children: [
                VehicleFormFields(
                  imageFile: cubit.newImage,
                  existingImagePath: cubit.existingImagePath,
                  onPickImage: () => _pickImage(context),
                  nameController: cubit.nameController,
                  modelController: cubit.modelController,
                  plateController: cubit.plateController,
                  chassisController: cubit.chassisController,
                  notesController: cubit.notesController,
                  brand: cubit.brand,
                  onBrand: cubit.setBrand,
                  year: cubit.year,
                  onYear: cubit.setYear,
                  color: cubit.color,
                  onColor: cubit.setColor,
                  category: cubit.category,
                  onCategory: cubit.setCategory,
                  isDefault: cubit.isDefault,
                  onDefault: cubit.toggleDefault,
                ),
                SizedBox(height: 24.h),
                PrimaryButton(
                  text: LocaleKeys.save_changes.tr(),
                  loading: submitting,
                  onPressed: cubit.submit,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
