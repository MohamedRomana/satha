import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:satha/core/constants/app_icons.dart';
import 'package:satha/core/constants/colors.dart';
import 'package:satha/core/widgets/app_svg_icon.dart';
import 'package:satha/core/widgets/fade_slide_in.dart';
import 'package:satha/core/widgets/primary_button.dart';
import 'package:satha/gen/fonts.gen.dart';
import 'package:satha/generated/locale_keys.g.dart';

/// حالة عدم وجود سيارات.
class VehiclesEmptyState extends StatelessWidget {
  final VoidCallback onAdd;
  const VehiclesEmptyState({super.key, required this.onAdd});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: FadeSlideIn(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 32.w),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 110.w,
                height: 110.w,
                decoration: BoxDecoration(
                  color: AppColors.softOrange,
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: AppSvgIcon(
                    assetPath: AppIcons.car,
                    size: 52.w,
                    color: AppColors.orange,
                  ),
                ),
              ),
              SizedBox(height: 22.h),
              Text(
                LocaleKeys.noVehiclesTitle.tr(),
                style: TextStyle(
                  fontSize: 19.sp,
                  color: AppColors.mainText,
                  fontFamily: FontFamily.tajawalBold,
                ),
              ),
              SizedBox(height: 10.h),
              Text(
                LocaleKeys.noVehiclesDesc.tr(),
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14.sp,
                  height: 1.6,
                  color: AppColors.secondaryText,
                  fontFamily: FontFamily.tajawalRegular,
                ),
              ),
              SizedBox(height: 26.h),
              PrimaryButton(
                text: LocaleKeys.addNewVehicle.tr(),
                icon: Icons.add_rounded,
                onPressed: onAdd,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
