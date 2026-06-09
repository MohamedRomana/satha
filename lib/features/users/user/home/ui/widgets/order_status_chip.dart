import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:satha/core/constants/colors.dart';
import 'package:satha/gen/fonts.gen.dart';
import 'package:satha/generated/locale_keys.g.dart';
import 'package:satha/features/users/user/home/data/models/home_models.dart';

/// شارة حالة الطلب بلون مناسب لكل حالة.
class OrderStatusChip extends StatelessWidget {
  final OrderPreviewStatus status;
  const OrderStatusChip({super.key, required this.status});

  ({String label, Color color}) _config() {
    switch (status) {
      case OrderPreviewStatus.searchingDrivers:
        return (label: LocaleKeys.statusSearchingDrivers.tr(), color: AppColors.warning);
      case OrderPreviewStatus.offersReceived:
        return (label: LocaleKeys.statusOffersReceived.tr(), color: AppColors.orange);
      case OrderPreviewStatus.driverOnWay:
        return (label: LocaleKeys.statusDriverOnWay.tr(), color: AppColors.navy);
      case OrderPreviewStatus.driverArrived:
        return (label: LocaleKeys.statusDriverArrived.tr(), color: AppColors.navy2);
      case OrderPreviewStatus.completed:
        return (label: LocaleKeys.statusCompleted.tr(), color: AppColors.success);
      case OrderPreviewStatus.canceled:
        return (label: LocaleKeys.statusCanceled.tr(), color: AppColors.error);
    }
  }

  @override
  Widget build(BuildContext context) {
    final c = _config();
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
      decoration: BoxDecoration(
        color: c.color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 7.w,
            height: 7.w,
            decoration: BoxDecoration(color: c.color, shape: BoxShape.circle),
          ),
          SizedBox(width: 6.w),
          Text(
            c.label,
            style: TextStyle(
              fontSize: 11.sp,
              color: c.color,
              fontFamily: FontFamily.tajawalBold,
            ),
          ),
        ],
      ),
    );
  }
}
