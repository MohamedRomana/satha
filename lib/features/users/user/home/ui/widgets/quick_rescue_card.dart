import 'dart:ui' as ui;

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:satha/core/constants/app_icons.dart';
import 'package:satha/core/constants/colors.dart';
import 'package:satha/core/constants/gradients.dart';
import 'package:satha/core/widgets/app_svg_icon.dart';
import 'package:satha/gen/fonts.gen.dart';
import 'package:satha/generated/locale_keys.g.dart';

/// بطاقة الإنقاذ السريع مع نبضة متحرّكة حول الأيقونة.
class QuickRescueCard extends StatefulWidget {
  final VoidCallback onTap;
  const QuickRescueCard({super.key, required this.onTap});

  @override
  State<QuickRescueCard> createState() => _QuickRescueCardState();
}

class _QuickRescueCardState extends State<QuickRescueCard>
    with SingleTickerProviderStateMixin {
  late final AnimationController _pulse = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 1400),
  )..repeat();

  @override
  void dispose() {
    _pulse.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        HapticFeedback.mediumImpact();
        widget.onTap();
      },
      child: Container(
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          gradient: AppGradients.orange,
          borderRadius: BorderRadius.circular(22.r),
          boxShadow: [
            BoxShadow(
              color: AppColors.orange.withValues(alpha: 0.35),
              blurRadius: 18,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Row(
          children: [
            SizedBox(
              width: 56.w,
              height: 56.w,
              child: AnimatedBuilder(
                animation: _pulse,
                builder: (context, child) {
                  return Stack(
                    alignment: Alignment.center,
                    children: [
                      Container(
                        width: 56.w * (0.7 + _pulse.value * 0.5),
                        height: 56.w * (0.7 + _pulse.value * 0.5),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white.withValues(
                            alpha: (1 - _pulse.value) * 0.4,
                          ),
                        ),
                      ),
                      child!,
                    ],
                  );
                },
                child: Container(
                  width: 44.w,
                  height: 44.w,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: AppSvgIcon(
                      assetPath: AppIcons.quickRescue,
                      size: 24.w,
                      color: AppColors.orange,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(width: 14.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    LocaleKeys.quickRescueTitle.tr(),
                    style: TextStyle(
                      fontSize: 16.sp,
                      color: Colors.white,
                      fontFamily: FontFamily.tajawalBold,
                    ),
                  ),
                  SizedBox(height: 5.h),
                  Text(
                    LocaleKeys.quickRescueDesc.tr(),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 12.sp,
                      height: 1.4,
                      color: Colors.white.withValues(alpha: 0.9),
                      fontFamily: FontFamily.tajawalRegular,
                    ),
                  ),
                ],
              ),
            ),
            Icon(
              Directionality.of(context) == ui.TextDirection.rtl
                  ? Icons.chevron_left_rounded
                  : Icons.chevron_right_rounded,
              color: Colors.white,
              size: 26.w,
            ),
          ],
        ),
      ),
    );
  }
}
