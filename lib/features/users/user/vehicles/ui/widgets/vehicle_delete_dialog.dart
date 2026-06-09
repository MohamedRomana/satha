import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:satha/core/constants/app_icons.dart';
import 'package:satha/core/constants/colors.dart';
import 'package:satha/core/widgets/app_svg_icon.dart';
import 'package:satha/gen/fonts.gen.dart';
import 'package:satha/generated/locale_keys.g.dart';

/// ديالوج تأكيد حذف السيارة (يرجّع true عند التأكيد).
class VehicleDeleteDialog extends StatelessWidget {
  const VehicleDeleteDialog({super.key});

  static Future<bool> show(BuildContext context) async {
    final result = await showDialog<bool>(
      context: context,
      builder: (_) => const VehicleDeleteDialog(),
    );
    return result ?? false;
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.white,
      insetPadding: EdgeInsets.symmetric(horizontal: 32.w),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(26.r)),
      child: Padding(
        padding: EdgeInsets.fromLTRB(22.w, 26.h, 22.w, 20.h),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TweenAnimationBuilder<double>(
              duration: const Duration(milliseconds: 500),
              curve: Curves.elasticOut,
              tween: Tween(begin: 0, end: 1),
              builder: (context, v, child) =>
                  Transform.scale(scale: v, child: child),
              child: Container(
                width: 70.w,
                height: 70.w,
                decoration: BoxDecoration(
                  color: AppColors.error.withValues(alpha: 0.1),
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: AppSvgIcon(
                    assetPath: AppIcons.delete,
                    size: 32.w,
                    color: AppColors.error,
                  ),
                ),
              ),
            ),
            SizedBox(height: 18.h),
            Text(
              LocaleKeys.deleteVehicleTitle.tr(),
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 17.sp,
                color: AppColors.mainText,
                fontFamily: FontFamily.tajawalBold,
              ),
            ),
            SizedBox(height: 10.h),
            Text(
              LocaleKeys.deleteVehicleDesc.tr(),
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 13.sp,
                height: 1.6,
                color: AppColors.secondaryText,
                fontFamily: FontFamily.tajawalRegular,
              ),
            ),
            SizedBox(height: 24.h),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => Navigator.of(context).pop(false),
                    style: OutlinedButton.styleFrom(
                      minimumSize: Size(0, 50.h),
                      side: const BorderSide(color: AppColors.border),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14.r),
                      ),
                    ),
                    child: Text(
                      LocaleKeys.cancelBtn.tr(),
                      style: TextStyle(
                        color: AppColors.navy,
                        fontSize: 14.sp,
                        fontFamily: FontFamily.tajawalBold,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () => Navigator.of(context).pop(true),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.error,
                      minimumSize: Size(0, 50.h),
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14.r),
                      ),
                    ),
                    child: Text(
                      LocaleKeys.deleteVehicleConfirm.tr(),
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14.sp,
                        fontFamily: FontFamily.tajawalBold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
