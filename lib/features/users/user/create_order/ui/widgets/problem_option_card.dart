import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:satha/core/constants/colors.dart';
import 'package:satha/core/widgets/app_svg_icon.dart';
import 'package:satha/gen/fonts.gen.dart';
import '../../data/models/order_flow_models.dart';

/// بطاقة اختيار نوع المشكلة (داخل grid).
class ProblemOptionCard extends StatelessWidget {
  final ProblemTypeModel problem;
  final bool selected;
  final VoidCallback onTap;
  const ProblemOptionCard({
    super.key,
    required this.problem,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        HapticFeedback.selectionClick();
        onTap();
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 14.h),
        decoration: BoxDecoration(
          color: selected
              ? AppColors.softOrange.withValues(alpha: 0.6)
              : AppColors.card,
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(
            color: selected ? AppColors.orange : AppColors.border,
            width: selected ? 1.8 : 1,
          ),
        ),
        child: Row(
          children: [
            AppSvgIcon(
              assetPath: problem.icon,
              size: 24.w,
              color: selected ? AppColors.orange : AppColors.navy,
            ),
            SizedBox(width: 10.w),
            Expanded(
              child: Text(
                problem.titleKey.tr(),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 12.5.sp,
                  color: AppColors.mainText,
                  fontFamily: selected
                      ? FontFamily.tajawalBold
                      : FontFamily.tajawalMedium,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
