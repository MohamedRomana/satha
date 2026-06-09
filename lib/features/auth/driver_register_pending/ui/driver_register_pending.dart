import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:satha/core/constants/colors.dart';
import 'package:satha/core/helper/extentions.dart';
import 'package:satha/core/routing/routes.dart';
import 'package:satha/core/widgets/auth_background.dart';
import 'package:satha/core/widgets/fade_slide_in.dart';
import 'package:satha/core/widgets/primary_button.dart';
import 'package:satha/gen/fonts.gen.dart';
import 'package:satha/generated/locale_keys.g.dart';

/// شاشة "طلبك قيد المراجعة" بعد إرسال تسجيل السائق.
class DriverRegisterPendingScreen extends StatelessWidget {
  const DriverRegisterPendingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedAuthBackground(
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 28.w),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TweenAnimationBuilder<double>(
                  duration: const Duration(milliseconds: 900),
                  curve: Curves.elasticOut,
                  tween: Tween(begin: 0, end: 1),
                  builder: (context, value, child) => Transform.scale(
                    scale: value,
                    child: child,
                  ),
                  child: Container(
                    width: 120.w,
                    height: 120.w,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColors.orange.withValues(alpha: 0.15),
                      border: Border.all(color: AppColors.orange, width: 2),
                    ),
                    child: Icon(
                      Icons.hourglass_top_rounded,
                      size: 56.w,
                      color: AppColors.orange,
                    ),
                  ),
                ),
                SizedBox(height: 32.h),
                FadeSlideIn(
                  delay: const Duration(milliseconds: 300),
                  child: Text(
                    LocaleKeys.requestUnderReview.tr(),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 23.sp,
                      fontFamily: FontFamily.tajawalBold,
                    ),
                  ),
                ),
                SizedBox(height: 14.h),
                FadeSlideIn(
                  delay: const Duration(milliseconds: 400),
                  child: Text(
                    LocaleKeys.requestUnderReviewDesc.tr(),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white.withValues(alpha: 0.78),
                      fontSize: 14.sp,
                      height: 1.7,
                      fontFamily: FontFamily.tajawalRegular,
                    ),
                  ),
                ),
                SizedBox(height: 40.h),
                FadeSlideIn(
                  delay: const Duration(milliseconds: 500),
                  child: PrimaryButton(
                    text: LocaleKeys.backToLoginScreen.tr(),
                    onPressed: () => context.pushNamedAndRemoveUntil(
                      Routes.driverLogin,
                      predicate: (route) =>
                          route.settings.name == Routes.roleSelection,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
