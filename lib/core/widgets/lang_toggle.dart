import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../cache/cache_helper.dart';
import '../constants/colors.dart';

/// زر تبديل اللغة (ع/EN) — العربية تبقى الافتراضية.
class LangToggle extends StatelessWidget {
  /// لو true يستخدم ألوان فاتحة (فوق خلفية داكنة).
  final bool onDark;
  const LangToggle({super.key, this.onDark = true});

  @override
  Widget build(BuildContext context) {
    final isAr = context.locale.languageCode == 'ar';
    final fg = onDark ? Colors.white : AppColors.navy;
    return InkWell(
      borderRadius: BorderRadius.circular(20.r),
      onTap: () async {
        final next = isAr ? const Locale('en') : const Locale('ar');
        await CacheHelper.setLang(next.languageCode);
        if (context.mounted) await context.setLocale(next);
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
        decoration: BoxDecoration(
          color: (onDark ? Colors.white : AppColors.navy).withValues(
            alpha: 0.12,
          ),
          borderRadius: BorderRadius.circular(20.r),
          border: Border.all(color: fg.withValues(alpha: 0.25)),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.language_rounded, color: fg, size: 16.w),
            SizedBox(width: 6.w),
            Text(
              isAr ? 'EN' : 'ع',
              style: TextStyle(
                color: fg,
                fontSize: 13.sp,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
