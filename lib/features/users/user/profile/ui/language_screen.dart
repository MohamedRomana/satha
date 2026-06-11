import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:satha/core/cache/cache_helper.dart';
import 'package:satha/core/constants/colors.dart';
import 'package:satha/gen/fonts.gen.dart';
import 'package:satha/generated/locale_keys.g.dart';

/// شاشة اختيار اللغة.
class LanguageScreen extends StatelessWidget {
  const LanguageScreen({super.key});

  Future<void> _select(BuildContext context, Locale locale) async {
    await CacheHelper.setLang(locale.languageCode);
    if (context.mounted) await context.setLocale(locale);
  }

  @override
  Widget build(BuildContext context) {
    final current = context.locale.languageCode;
    return Scaffold(
      backgroundColor: AppColors.lightBg,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          LocaleKeys.language.tr(),
          style: TextStyle(
            fontSize: 17.sp,
            color: AppColors.mainText,
            fontFamily: FontFamily.tajawalBold,
          ),
        ),
      ),
      body: ListView(
        padding: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 24.h),
        children: [
          _tile(context, 'العربية', 'ar', current == 'ar'),
          SizedBox(height: 12.h),
          _tile(context, 'English', 'en', current == 'en'),
        ],
      ),
    );
  }

  Widget _tile(BuildContext context, String label, String code, bool selected) {
    return GestureDetector(
      onTap: () => _select(context, Locale(code)),
      child: Container(
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: selected ? AppColors.softOrange : AppColors.card,
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(
            color: selected ? AppColors.orange : AppColors.border,
          ),
        ),
        child: Row(
          children: [
            Icon(
              Icons.translate_rounded,
              color: selected ? AppColors.orange : AppColors.secondaryText,
              size: 22.w,
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: Text(
                label,
                style: TextStyle(
                  fontSize: 15.sp,
                  color: AppColors.mainText,
                  fontFamily: FontFamily.tajawalBold,
                ),
              ),
            ),
            if (selected)
              const Icon(Icons.check_circle_rounded, color: AppColors.orange),
          ],
        ),
      ),
    );
  }
}
