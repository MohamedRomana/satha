import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:satha/core/constants/app_icons.dart';
import 'package:satha/core/constants/colors.dart';
import 'package:satha/core/widgets/app_svg_icon.dart';
import 'package:satha/gen/fonts.gen.dart';
import '../../data/models/order_flow_models.dart';

/// بطاقة اختيار خدمة (حدود برتقالية وخلفية ناعمة عند الاختيار).
class SelectableServiceCard extends StatelessWidget {
  final ServiceTypeModel service;
  final bool selected;
  final VoidCallback onTap;
  const SelectableServiceCard({
    super.key,
    required this.service,
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
        duration: const Duration(milliseconds: 220),
        curve: Curves.easeOut,
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: selected ? AppColors.softOrange.withValues(alpha: 0.6) : AppColors.card,
          borderRadius: BorderRadius.circular(20.r),
          border: Border.all(
            color: selected ? AppColors.orange : AppColors.border,
            width: selected ? 1.8 : 1,
          ),
        ),
        child: Row(
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 220),
              width: 56.w,
              height: 56.w,
              decoration: BoxDecoration(
                color: selected ? AppColors.orange : AppColors.softOrange,
                borderRadius: BorderRadius.circular(16.r),
              ),
              child: Center(
                child: AppSvgIcon(
                  assetPath: service.icon,
                  size: 30.w,
                  color: selected ? Colors.white : AppColors.orange,
                ),
              ),
            ),
            SizedBox(width: 14.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    service.titleKey.tr(),
                    style: TextStyle(
                      fontSize: 15.sp,
                      color: AppColors.mainText,
                      fontFamily: FontFamily.tajawalBold,
                    ),
                  ),
                  SizedBox(height: 5.h),
                  Text(
                    service.descKey.tr(),
                    style: TextStyle(
                      fontSize: 12.sp,
                      height: 1.5,
                      color: AppColors.secondaryText,
                      fontFamily: FontFamily.tajawalRegular,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(width: 8.w),
            AnimatedScale(
              scale: selected ? 1 : 0,
              duration: const Duration(milliseconds: 220),
              child: AppSvgIcon(
                assetPath: AppIcons.checkCircle,
                size: 22.w,
                color: AppColors.orange,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
