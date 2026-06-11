import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:satha/core/constants/colors.dart';
import 'package:satha/core/widgets/primary_button.dart';
import 'package:satha/gen/fonts.gen.dart';
import 'package:satha/generated/locale_keys.g.dart';

/// واجهة حالات إذن الموقع (مرفوض / معطّل / دائم) مع رسائل وأزرار عربية.
class LocationPermissionView extends StatelessWidget {
  final String message;
  final String primaryLabel;
  final VoidCallback onPrimary;
  final VoidCallback onManual;
  const LocationPermissionView({
    super.key,
    required this.message,
    required this.primaryLabel,
    required this.onPrimary,
    required this.onManual,
  });

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
                Icons.location_on_rounded,
                size: 48.w,
                color: AppColors.orange,
              ),
            ),
            SizedBox(height: 22.h),
            Text(
              message,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 15.sp,
                height: 1.6,
                color: AppColors.mainText,
                fontFamily: FontFamily.tajawalMedium,
              ),
            ),
            SizedBox(height: 26.h),
            PrimaryButton(text: primaryLabel, onPressed: onPrimary),
            SizedBox(height: 12.h),
            TextButton(
              onPressed: onManual,
              child: Text(
                LocaleKeys.selectManuallyBtn.tr(),
                style: TextStyle(
                  fontSize: 14.sp,
                  color: AppColors.navy,
                  fontFamily: FontFamily.tajawalBold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
