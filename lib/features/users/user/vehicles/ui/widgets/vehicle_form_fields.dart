import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:satha/core/constants/colors.dart';
import 'package:satha/core/helper/validators.dart';
import 'package:satha/core/widgets/satha_dropdown.dart';
import 'package:satha/core/widgets/satha_field.dart';
import 'package:satha/gen/fonts.gen.dart';
import 'package:satha/generated/locale_keys.g.dart';
import '../../data/models/vehicle_model.dart';
import '../../data/models/vehicle_options.dart';
import 'vehicle_image_picker_field.dart';

/// حقول فورم السيارة (مشتركة بين الإضافة والتعديل).
class VehicleFormFields extends StatelessWidget {
  final File? imageFile;
  final String? existingImagePath;
  final VoidCallback onPickImage;
  final TextEditingController nameController;
  final TextEditingController modelController;
  final TextEditingController plateController;
  final TextEditingController chassisController;
  final TextEditingController notesController;
  final String? brand;
  final ValueChanged<String?> onBrand;
  final int? year;
  final ValueChanged<int?> onYear;
  final String? color;
  final ValueChanged<String?> onColor;
  final VehicleCategory? category;
  final ValueChanged<VehicleCategory?> onCategory;
  final bool isDefault;
  final ValueChanged<bool> onDefault;

  const VehicleFormFields({
    super.key,
    required this.imageFile,
    required this.existingImagePath,
    required this.onPickImage,
    required this.nameController,
    required this.modelController,
    required this.plateController,
    required this.chassisController,
    required this.notesController,
    required this.brand,
    required this.onBrand,
    required this.year,
    required this.onYear,
    required this.color,
    required this.onColor,
    required this.category,
    required this.onCategory,
    required this.isDefault,
    required this.onDefault,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        VehicleImagePickerField(
          file: imageFile,
          existingPath: existingImagePath,
          onTap: onPickImage,
        ),
        SizedBox(height: 18.h),
        SathaField(
          controller: nameController,
          label: LocaleKeys.vehName.tr(),
          validator: (v) =>
              Validators.required(v, message: LocaleKeys.vehNameRequired.tr()),
        ),
        SizedBox(height: 14.h),
        SathaDropdown<String>(
          label: LocaleKeys.vehBrand.tr(),
          hint: LocaleKeys.selectBrand.tr(),
          value: brand,
          items: [
            for (final b in VehicleOptions.brands)
              DropdownMenuItem(value: b, child: Text(b)),
          ],
          onChanged: onBrand,
          validator: (v) => v == null ? LocaleKeys.vehBrandRequired.tr() : null,
        ),
        SizedBox(height: 14.h),
        SathaField(
          controller: modelController,
          label: LocaleKeys.vehModel.tr(),
          validator: (v) =>
              Validators.required(v, message: LocaleKeys.vehModelRequired.tr()),
        ),
        SizedBox(height: 14.h),
        SathaDropdown<int>(
          label: LocaleKeys.vehYear.tr(),
          hint: LocaleKeys.selectVehicleYear.tr(),
          value: year,
          items: [
            for (final y in VehicleOptions.years)
              DropdownMenuItem(value: y, child: Text('$y')),
          ],
          onChanged: onYear,
          validator: (v) => v == null ? LocaleKeys.vehYearRequired.tr() : null,
        ),
        SizedBox(height: 14.h),
        SathaDropdown<String>(
          label: LocaleKeys.vehColor.tr(),
          hint: LocaleKeys.selectColor.tr(),
          value: color,
          items: [
            for (final c in VehicleOptions.colors)
              DropdownMenuItem(value: c, child: Text(c)),
          ],
          onChanged: onColor,
          validator: (v) => v == null ? LocaleKeys.vehColorRequired.tr() : null,
        ),
        SizedBox(height: 14.h),
        SathaField(
          controller: plateController,
          label: LocaleKeys.vehPlate.tr(),
          validator: (v) =>
              Validators.required(v, message: LocaleKeys.vehPlateRequired.tr()),
        ),
        SizedBox(height: 14.h),
        SathaField(
          controller: chassisController,
          label: LocaleKeys.vehChassis.tr(),
          validator: (v) => Validators.required(
            v,
            message: LocaleKeys.vehChassisRequired.tr(),
          ),
        ),
        SizedBox(height: 14.h),
        SathaDropdown<VehicleCategory>(
          label: LocaleKeys.vehCategory.tr(),
          hint: LocaleKeys.selectVehicleCategory.tr(),
          value: category,
          items: [
            for (final c in VehicleCategory.values)
              DropdownMenuItem(value: c, child: Text(c.labelKey.tr())),
          ],
          onChanged: onCategory,
        ),
        SizedBox(height: 14.h),
        SathaField(
          controller: notesController,
          label: LocaleKeys.vehNotes.tr(),
          hint: LocaleKeys.vehNotesHint.tr(),
          maxLines: 3,
          textInputAction: TextInputAction.done,
        ),
        SizedBox(height: 14.h),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 6.h),
          decoration: BoxDecoration(
            color: AppColors.lightBg,
            borderRadius: BorderRadius.circular(16.r),
            border: Border.all(color: AppColors.border),
          ),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  LocaleKeys.makeDefaultVehicle.tr(),
                  style: TextStyle(
                    fontSize: 13.5.sp,
                    color: AppColors.mainText,
                    fontFamily: FontFamily.tajawalMedium,
                  ),
                ),
              ),
              Switch(
                value: isDefault,
                activeThumbColor: Colors.white,
                activeTrackColor: AppColors.orange,
                onChanged: onDefault,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
