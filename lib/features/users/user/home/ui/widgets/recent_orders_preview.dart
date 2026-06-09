import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:satha/core/constants/colors.dart';
import 'package:satha/gen/fonts.gen.dart';
import 'package:satha/generated/locale_keys.g.dart';
import 'package:satha/features/users/user/home/data/models/home_models.dart';
import 'order_status_chip.dart';

/// معاينة آخر الطلبات (مع عرض الكل).
class RecentOrdersPreview extends StatelessWidget {
  final List<HomeOrderPreview> orders;
  final VoidCallback onViewAll;
  final void Function(HomeOrderPreview order) onOrderTap;

  const RecentOrdersPreview({
    super.key,
    required this.orders,
    required this.onViewAll,
    required this.onOrderTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              LocaleKeys.recentOrdersTitle.tr(),
              style: TextStyle(
                fontSize: 16.sp,
                color: AppColors.mainText,
                fontFamily: FontFamily.tajawalBold,
              ),
            ),
            const Spacer(),
            GestureDetector(
              onTap: onViewAll,
              child: Text(
                LocaleKeys.viewAllLabel.tr(),
                style: TextStyle(
                  fontSize: 13.sp,
                  color: AppColors.orange,
                  fontFamily: FontFamily.tajawalBold,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 12.h),
        for (final order in orders) ...[
          _RecentOrderCard(order: order, onTap: () => onOrderTap(order)),
          SizedBox(height: 10.h),
        ],
      ],
    );
  }
}

class _RecentOrderCard extends StatelessWidget {
  final HomeOrderPreview order;
  final VoidCallback onTap;
  const _RecentOrderCard({required this.order, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(14.w),
        decoration: BoxDecoration(
          color: AppColors.card,
          borderRadius: BorderRadius.circular(18.r),
          border: Border.all(color: AppColors.border),
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        order.serviceTitleKey.tr(),
                        style: TextStyle(
                          fontSize: 14.sp,
                          color: AppColors.mainText,
                          fontFamily: FontFamily.tajawalBold,
                        ),
                      ),
                      SizedBox(width: 8.w),
                      OrderStatusChip(status: order.status),
                    ],
                  ),
                  SizedBox(height: 6.h),
                  Text(
                    '${order.vehicleName}  •  ${order.dateText}',
                    style: TextStyle(
                      fontSize: 11.5.sp,
                      color: AppColors.secondaryText,
                      fontFamily: FontFamily.tajawalRegular,
                    ),
                  ),
                ],
              ),
            ),
            if (order.price != null)
              Text(
                '${order.price!.toStringAsFixed(0)} ${LocaleKeys.sar.tr()}',
                style: TextStyle(
                  fontSize: 14.sp,
                  color: AppColors.success,
                  fontFamily: FontFamily.tajawalBold,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
