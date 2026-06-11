import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:satha/core/constants/colors.dart';
import 'package:satha/core/widgets/primary_button.dart';
import 'package:satha/gen/fonts.gen.dart';
import 'package:satha/generated/locale_keys.g.dart';
import '../../data/models/order_model.dart';

/// شريط إجراءات تفاصيل الطلب (يتغيّر حسب الحالة).
class OrderDetailsActions extends StatelessWidget {
  final OrderModel order;
  final bool canCancel;
  final bool cancelling;
  final VoidCallback onViewOffers;
  final VoidCallback onTrack;
  final VoidCallback onInvoice;
  final VoidCallback onRate;
  final VoidCallback onCancel;
  final VoidCallback onReport;

  const OrderDetailsActions({
    super.key,
    required this.order,
    required this.canCancel,
    required this.cancelling,
    required this.onViewOffers,
    required this.onTrack,
    required this.onInvoice,
    required this.onRate,
    required this.onCancel,
    required this.onReport,
  });

  @override
  Widget build(BuildContext context) {
    final s = order.status;
    final showOffers =
        s == OrderStatus.searchingDrivers || s == OrderStatus.offersReceived;
    final showTrack = const [
      OrderStatus.offerAccepted,
      OrderStatus.driverOnWay,
      OrderStatus.driverArrived,
      OrderStatus.pickupConfirmed,
      OrderStatus.tripStarted,
      OrderStatus.destinationReached,
    ].contains(s);

    return Container(
      padding: EdgeInsets.fromLTRB(16.w, 12.h, 16.w, 16.h),
      decoration: BoxDecoration(
        color: AppColors.card,
        border: Border(top: BorderSide(color: AppColors.border)),
      ),
      child: SafeArea(
        top: false,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (showOffers)
              PrimaryButton(
                text: order.offersCount > 0
                    ? '${LocaleKeys.viewOffers.tr()} (${order.offersCount})'
                    : LocaleKeys.viewOffers.tr(),
                icon: Icons.local_offer_rounded,
                onPressed: onViewOffers,
              ),
            if (showTrack)
              PrimaryButton(
                text: LocaleKeys.trackOrderBtn.tr(),
                icon: Icons.location_on_rounded,
                onPressed: onTrack,
              ),
            if (s.isCompleted) ...[
              PrimaryButton(
                text: LocaleKeys.viewInvoice.tr(),
                icon: Icons.receipt_long_rounded,
                onPressed: onInvoice,
              ),
              SizedBox(height: 10.h),
              OutlinedButton(
                onPressed: onRate,
                style: OutlinedButton.styleFrom(
                  minimumSize: Size(double.infinity, 52.h),
                  side: const BorderSide(color: AppColors.orange),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16.r),
                  ),
                ),
                child: Text(
                  LocaleKeys.rateDriver.tr(),
                  style: TextStyle(
                    color: AppColors.orange,
                    fontSize: 15.sp,
                    fontFamily: FontFamily.tajawalBold,
                  ),
                ),
              ),
            ],
            if (canCancel) ...[
              SizedBox(height: 10.h),
              OutlinedButton(
                onPressed: cancelling ? null : onCancel,
                style: OutlinedButton.styleFrom(
                  minimumSize: Size(double.infinity, 52.h),
                  side: const BorderSide(color: AppColors.error),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16.r),
                  ),
                ),
                child: cancelling
                    ? SizedBox(
                        width: 22.w,
                        height: 22.w,
                        child: const CircularProgressIndicator(
                          strokeWidth: 2.4,
                          color: AppColors.error,
                        ),
                      )
                    : Text(
                        LocaleKeys.cancelOrderBtn.tr(),
                        style: TextStyle(
                          color: AppColors.error,
                          fontSize: 15.sp,
                          fontFamily: FontFamily.tajawalBold,
                        ),
                      ),
              ),
            ],
            SizedBox(height: 6.h),
            TextButton.icon(
              onPressed: onReport,
              icon: Icon(
                Icons.flag_outlined,
                size: 18.w,
                color: AppColors.secondaryText,
              ),
              label: Text(
                LocaleKeys.reportIssue.tr(),
                style: TextStyle(
                  color: AppColors.secondaryText,
                  fontSize: 13.sp,
                  fontFamily: FontFamily.tajawalRegular,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
