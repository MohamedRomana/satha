import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:satha/core/constants/colors.dart';
import 'package:satha/core/widgets/app_logo.dart';
import 'package:satha/core/widgets/fade_slide_in.dart';
import 'package:satha/gen/fonts.gen.dart';
import 'package:satha/generated/locale_keys.g.dart';

/// Bottom sheet الشروط والأحكام — لوجو سطحة بنفس توهّج اختيار الدور + النص،
/// كله بأنميشن دخول متدرّج.
class TermsSheet extends StatelessWidget {
  const TermsSheet({super.key});

  static Future<void> show(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => const TermsSheet(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.82,
      minChildSize: 0.5,
      maxChildSize: 0.95,
      expand: false,
      builder: (context, scrollController) {
        return Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(32.r)),
          ),
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Column(
            children: [
              SizedBox(height: 10.h),
              Container(
                width: 44.w,
                height: 5.h,
                decoration: BoxDecoration(
                  color: AppColors.border,
                  borderRadius: BorderRadius.circular(4.r),
                ),
              ),
              SizedBox(height: 14.h),
              const FadeSlideIn(
                from: SlideFrom.top,
                child: AnimatedAppLogo(size: 92, glow: true, hero: false),
              ),
              SizedBox(height: 8.h),
              FadeSlideIn(
                delay: const Duration(milliseconds: 120),
                child: Text(
                  LocaleKeys.termsAndConditions.tr(),
                  style: TextStyle(
                    fontSize: 19.sp,
                    color: AppColors.mainText,
                    fontFamily: FontFamily.tajawalBold,
                  ),
                ),
              ),
              SizedBox(height: 12.h),
              Expanded(
                child: FadeSlideIn(
                  delay: const Duration(milliseconds: 220),
                  child: SingleChildScrollView(
                    controller: scrollController,
                    physics: const BouncingScrollPhysics(),
                    child: Padding(
                      padding: EdgeInsets.only(bottom: 24.h),
                      child: Text(
                        LocaleKeys.termsContent.tr(),
                        style: TextStyle(
                          fontSize: 14.sp,
                          height: 1.9,
                          color: AppColors.secondaryText,
                          fontFamily: FontFamily.tajawalRegular,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
