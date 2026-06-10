import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:satha/core/constants/colors.dart';
import 'package:satha/gen/fonts.gen.dart';
import 'package:satha/generated/locale_keys.g.dart';

/// الخطوة 4 (مؤقتة): سيتم تنفيذ تحديد الموقع على الخريطة في المرحلة التالية.
class StepLocationPlaceholder extends StatelessWidget {
  const StepLocationPlaceholder({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 32.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 100.w,
              height: 100.w,
              decoration: const BoxDecoration(
                color: AppColors.softOrange,
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.map_outlined,
                size: 48.w,
                color: AppColors.orange,
              ),
            ),
            SizedBox(height: 20.h),
            Text(
              LocaleKeys.stepLocation.tr(),
              style: TextStyle(
                fontSize: 19.sp,
                color: AppColors.mainText,
                fontFamily: FontFamily.tajawalBold,
              ),
            ),
            SizedBox(height: 10.h),
            Text(
              LocaleKeys.locationStepSoon.tr(),
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14.sp,
                height: 1.6,
                color: AppColors.secondaryText,
                fontFamily: FontFamily.tajawalRegular,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
