import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:satha/core/constants/colors.dart';
import 'package:satha/gen/fonts.gen.dart';
import 'package:satha/generated/locale_keys.g.dart';
import 'package:satha/features/auth/driver_register/logic/driver_register_cubit.dart';

/// الخطوة 4 من تسجيل السائق — مراجعة كل البيانات قبل الإرسال.
class DriverStepReview extends StatelessWidget {
  final DriverRegisterCubit cubit;
  const DriverStepReview({super.key, required this.cubit});

  @override
  Widget build(BuildContext context) {
    final towLabel = cubit.towType == 'hydraulic'
        ? LocaleKeys.hydraulicTow.tr()
        : LocaleKeys.normalTow.tr();
    return Column(
      children: [
        _ReviewSection(
          title: LocaleKeys.driverPersonalInfo.tr(),
          rows: [
            (LocaleKeys.fullName.tr(), cubit.nameController.text),
            (LocaleKeys.phone.tr(), cubit.phoneController.text),
            (LocaleKeys.email.tr(), cubit.emailController.text),
            (LocaleKeys.nationalIdNumber.tr(), cubit.nationalIdController.text),
            (LocaleKeys.city.tr(), cubit.city ?? ''),
          ],
        ),
        _ReviewSection(
          title: LocaleKeys.driverTowInfo.tr(),
          rows: [
            (LocaleKeys.towTruckName.tr(), cubit.towNameController.text),
            (LocaleKeys.towTruckType.tr(), towLabel),
            (LocaleKeys.plateNumber.tr(), cubit.plateController.text),
            (LocaleKeys.vehicleModelField.tr(), cubit.vehicleModelController.text),
            (LocaleKeys.vehicleColor.tr(), cubit.vehicleColorController.text),
          ],
        ),
        _ReviewDocuments(cubit: cubit),
      ],
    );
  }
}

/// قسم بيانات في شاشة المراجعة (عنوان + صفوف مفتاح/قيمة).
class _ReviewSection extends StatelessWidget {
  final String title;
  final List<(String, String)> rows;
  const _ReviewSection({required this.title, required this.rows});

  @override
  Widget build(BuildContext context) {
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
}

/// معاينة مصغّرات المستندات في شاشة المراجعة.
class _ReviewDocuments extends StatelessWidget {
  final DriverRegisterCubit cubit;
  const _ReviewDocuments({required this.cubit});

  @override
  Widget build(BuildContext context) {
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
