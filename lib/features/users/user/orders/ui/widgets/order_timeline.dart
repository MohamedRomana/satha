import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:satha/core/constants/colors.dart';
import 'package:satha/gen/fonts.gen.dart';
import 'package:satha/generated/locale_keys.g.dart';
import '../../data/models/order_model.dart';

/// خط زمني لمراحل الطلب.
class OrderTimeline extends StatelessWidget {
  final OrderStatus status;
  const OrderTimeline({super.key, required this.status});

  static const _milestones = <_Milestone>[
    _Milestone(OrderStatus.searchingDrivers, LocaleKeys.tlRequested, 0),
    _Milestone(OrderStatus.offerAccepted, LocaleKeys.tlDriverAssigned, 1),
    _Milestone(OrderStatus.driverArrived, LocaleKeys.tlDriverArrived, 2),
    _Milestone(OrderStatus.tripStarted, LocaleKeys.tlTripStarted, 3),
    _Milestone(OrderStatus.completed, LocaleKeys.tlCompleted, 4),
  ];

  int get _currentRank {
    switch (status) {
      case OrderStatus.searchingDrivers:
      case OrderStatus.offersReceived:
        return 0;
      case OrderStatus.offerAccepted:
      case OrderStatus.driverOnWay:
        return 1;
      case OrderStatus.driverArrived:
      case OrderStatus.pickupConfirmed:
        return 2;
      case OrderStatus.tripStarted:
      case OrderStatus.destinationReached:
        return 3;
      case OrderStatus.completed:
        return 4;
      default:
        return -1;
    }
  }

  @override
  Widget build(BuildContext context) {
    if (status.isCanceled) {
      return Container(
        padding: EdgeInsets.all(14.w),
        decoration: BoxDecoration(
          color: AppColors.error.withValues(alpha: 0.08),
          borderRadius: BorderRadius.circular(14.r),
        ),
        child: Row(
          children: [
            Icon(Icons.cancel_rounded, color: AppColors.error, size: 20.w),
            SizedBox(width: 10.w),
            Text(
              LocaleKeys.statusCanceled.tr(),
              style: TextStyle(
                fontSize: 13.sp,
                color: AppColors.error,
                fontFamily: FontFamily.tajawalBold,
              ),
            ),
          ],
        ),
      );
    }
    final rank = _currentRank;
    return Column(
      children: [
        for (var i = 0; i < _milestones.length; i++)
          _row(_milestones[i], i <= rank, i == _milestones.length - 1),
      ],
    );
  }

  Widget _row(_Milestone m, bool done, bool isLast) {
    final color = done ? AppColors.success : AppColors.border;
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            children: [
              Container(
                width: 22.w,
                height: 22.w,
                decoration: BoxDecoration(color: color, shape: BoxShape.circle),
                child: done
                    ? Icon(Icons.check, color: Colors.white, size: 14.w)
                    : null,
              ),
              if (!isLast)
                Expanded(
                  child: Container(width: 2.w, color: color),
                ),
            ],
          ),
          SizedBox(width: 12.w),
          Padding(
            padding: EdgeInsets.only(bottom: isLast ? 0 : 18.h, top: 2.h),
            child: Text(
              m.labelKey.tr(),
              style: TextStyle(
                fontSize: 13.sp,
                color: done ? AppColors.mainText : AppColors.secondaryText,
                fontFamily: done
                    ? FontFamily.tajawalBold
                    : FontFamily.tajawalRegular,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _Milestone {
  final OrderStatus status;
  final String labelKey;
  final int rank;
  const _Milestone(this.status, this.labelKey, this.rank);
}
