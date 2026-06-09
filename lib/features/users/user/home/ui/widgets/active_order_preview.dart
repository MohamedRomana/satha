import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:satha/core/constants/colors.dart';
import 'package:satha/gen/fonts.gen.dart';
import 'package:satha/generated/locale_keys.g.dart';
import 'package:satha/features/users/user/home/data/models/home_models.dart';
import 'order_status_chip.dart';

/// معاينة الطلب النشط الحالي.
class ActiveOrderPreview extends StatelessWidget {
  final HomeOrderPreview order;
  final VoidCallback onTap;
  const ActiveOrderPreview({super.key, required this.order, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: AppColors.card,
          borderRadius: BorderRadius.circular(20.r),
          border: Border.all(color: AppColors.orange.withValues(alpha: 0.4)),
          boxShadow: [
            BoxShadow(
              color: AppColors.orange.withValues(alpha: 0.08),
              blurRadius: 16,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  '${LocaleKeys.orderNumberShort.tr()} ${order.orderNumber}',
                  style: TextStyle(
                    fontSize: 13.sp,
                    color: AppColors.secondaryText,
                    fontFamily: FontFamily.tajawalMedium,
                  ),
                ),
                const Spacer(),
                OrderStatusChip(status: order.status),
              ],
            ),
            SizedBox(height: 12.h),
            Row(
              children: [
                Text(
                  order.serviceTitleKey.tr(),
                  style: TextStyle(
                    fontSize: 15.sp,
                    color: AppColors.mainText,
                    fontFamily: FontFamily.tajawalBold,
                  ),
                ),
                Text(
                  '  •  ${order.vehicleName}',
                  style: TextStyle(
                    fontSize: 13.sp,
                    color: AppColors.secondaryText,
                    fontFamily: FontFamily.tajawalRegular,
                  ),
                ),
              ],
            ),
            SizedBox(height: 14.h),
            Row(
              children: [
                if (order.offersCount > 0)
                  Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
                    decoration: BoxDecoration(
                      color: AppColors.softOrange,
                      borderRadius: BorderRadius.circular(20.r),
                    ),
                    child: Text(
                      '${order.offersCount} ${LocaleKeys.offersWord.tr()}',
                      style: TextStyle(
                        fontSize: 11.sp,
                        color: AppColors.orange,
                        fontFamily: FontFamily.tajawalBold,
                      ),
                    ),
                  ),
                const Spacer(),
                Text(
                  LocaleKeys.view_more.tr(),
                  style: TextStyle(
                    fontSize: 13.sp,
                    color: AppColors.orange,
                    fontFamily: FontFamily.tajawalBold,
                  ),
                ),
                Icon(
                  Icons.chevron_left_rounded,
                  color: AppColors.orange,
                  size: 20.w,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
