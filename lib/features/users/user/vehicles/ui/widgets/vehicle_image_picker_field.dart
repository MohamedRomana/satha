import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:satha/core/constants/app_icons.dart';
import 'package:satha/core/constants/colors.dart';
import 'package:satha/core/widgets/app_svg_icon.dart';
import 'package:satha/gen/fonts.gen.dart';
import 'package:satha/generated/locale_keys.g.dart';

/// حقل اختيار صورة السيارة (معاينة + زر كاميرا).
class VehicleImagePickerField extends StatelessWidget {
  final File? file;
  final String? existingPath;
  final VoidCallback onTap;

  const VehicleImagePickerField({
    super.key,
    required this.file,
    required this.existingPath,
    required this.onTap,
  });

  bool get _hasImage =>
      file != null || (existingPath != null && existingPath!.isNotEmpty);

  ImageProvider? get _provider {
    if (file != null) return FileImage(file!);
    if (existingPath != null && existingPath!.isNotEmpty) {
      return FileImage(File(existingPath!));
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        height: 170.h,
        width: double.infinity,
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          color: AppColors.softOrange.withValues(alpha: 0.5),
          borderRadius: BorderRadius.circular(20.r),
          border: Border.all(
            color: _hasImage ? AppColors.orange : AppColors.border,
            width: _hasImage ? 1.4 : 1,
          ),
          image: _provider == null
              ? null
              : DecorationImage(image: _provider!, fit: BoxFit.cover),
        ),
        child: _hasImage
            ? Align(
                alignment: AlignmentDirectional.bottomEnd,
                child: Container(
                  margin: EdgeInsets.all(10.w),
                  padding: EdgeInsets.all(8.w),
                  decoration: const BoxDecoration(
                    color: AppColors.orange,
                    shape: BoxShape.circle,
                  ),
                  child: AppSvgIcon(
                    assetPath: AppIcons.camera,
                    size: 18.w,
                    color: Colors.white,
                  ),
                ),
              )
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 56.w,
                    height: 56.w,
                    decoration: const BoxDecoration(
                      color: AppColors.orange,
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: AppSvgIcon(
                        assetPath: AppIcons.camera,
                        size: 26.w,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  SizedBox(height: 10.h),
                  Text(
                    LocaleKeys.vehImage.tr(),
                    style: TextStyle(
                      fontSize: 13.sp,
                      color: AppColors.mainText,
                      fontFamily: FontFamily.tajawalBold,
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
