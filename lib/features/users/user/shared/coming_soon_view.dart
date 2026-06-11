import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:satha/core/constants/colors.dart';
import 'package:satha/core/widgets/app_svg_icon.dart';
import 'package:satha/core/widgets/fade_slide_in.dart';
import 'package:satha/gen/fonts.gen.dart';
import 'package:satha/generated/locale_keys.g.dart';

/// واجهة مؤقتة موحّدة لتبويبات العميل التي لم تُنفّذ بعد.
class ComingSoonView extends StatelessWidget {
  final String title;
  final String icon;
  const ComingSoonView({super.key, required this.title, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          title,
          style: TextStyle(
            fontSize: 18.sp,
            color: Theme.of(context).colorScheme.onSurface,
            fontFamily: FontFamily.tajawalBold,
          ),
        ),
      ),
      body: Center(
        child: FadeSlideIn(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 32.w),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 96.w,
                  height: 96.w,
                  decoration: BoxDecoration(
                    color: AppColors.softOrange,
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: AppSvgIcon(
                      assetPath: icon,
                      size: 44.w,
                      color: AppColors.orange,
                    ),
                  ),
                ),
                SizedBox(height: 22.h),
                Text(
                  LocaleKeys.comingSoon.tr(),
                  style: TextStyle(
                    fontSize: 20.sp,
                    color: AppColors.mainText,
                    fontFamily: FontFamily.tajawalBold,
                  ),
                ),
                SizedBox(height: 10.h),
                Text(
                  LocaleKeys.comingSoonDesc.tr(),
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
        ),
      ),
    );
  }
}
