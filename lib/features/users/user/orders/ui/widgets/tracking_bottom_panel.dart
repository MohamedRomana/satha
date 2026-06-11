import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:satha/core/constants/colors.dart';
import 'package:satha/gen/fonts.gen.dart';
import 'package:satha/generated/locale_keys.g.dart';
import '../../../create_order/data/models/order_flow_models.dart';
import '../../data/models/order_model.dart';

/// لوحة سفلية أثناء التتبّع: ETA/المسافة + بيانات السائق + إجراءات.
class TrackingBottomPanel extends StatelessWidget {
  final OrderModel order;
  final int etaMin;
  final double distanceRemainingKm;
  final OrderStatus status;
  final VoidCallback onCall;
  final VoidCallback onChat;
  final VoidCallback onReport;

  const TrackingBottomPanel({
    super.key,
    required this.order,
    required this.etaMin,
    required this.distanceRemainingKm,
    required this.status,
    required this.onCall,
    required this.onChat,
    required this.onReport,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.lightBg,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 16,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: Padding(
          padding: EdgeInsets.fromLTRB(16.w, 12.h, 16.w, 12.h),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 44.w,
                height: 5.h,
                decoration: BoxDecoration(
                  color: AppColors.border,
                  borderRadius: BorderRadius.circular(3.r),
                ),
              ),
              SizedBox(height: 14.h),
              Container(
                padding: EdgeInsets.all(12.w),
                decoration: BoxDecoration(
                  color: AppColors.card,
                  borderRadius: BorderRadius.circular(16.r),
                  border: Border.all(color: AppColors.border),
                ),
                child: Row(
                  children: [
                    _metric(
                      Icons.access_time_rounded,
                      etaMin > 0
                          ? '$etaMin ${LocaleKeys.minUnit.tr()}'
                          : '—',
                      LocaleKeys.eta.tr(),
                    ),
                    Container(width: 1, height: 36.h, color: AppColors.border),
                    _metric(
                      Icons.near_me_rounded,
                      '${distanceRemainingKm.toStringAsFixed(1)} ${LocaleKeys.kmUnit.tr()}',
                      LocaleKeys.distanceRemaining.tr(),
                    ),
                    Container(width: 1, height: 36.h, color: AppColors.border),
                    Expanded(
                      child: Text(
                        status.labelKey.tr(),
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 12.sp,
                          color: Color(status.colorValue),
                          fontFamily: FontFamily.tajawalBold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 12.h),
              Row(
                children: [
                  Container(
                    width: 48.w,
                    height: 48.w,
                    decoration: const BoxDecoration(
                      color: AppColors.softOrange,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(Icons.person_rounded,
                        color: AppColors.orange, size: 26.w),
                  ),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          order.driverName ?? LocaleKeys.assignedDriver.tr(),
                          style: TextStyle(
                            fontSize: 14.sp,
                            color: AppColors.mainText,
                            fontFamily: FontFamily.tajawalBold,
                          ),
                        ),
                        SizedBox(height: 2.h),
                        Text(
                          order.service.titleKey.tr(),
                          style: TextStyle(
                            fontSize: 11.sp,
                            color: AppColors.secondaryText,
                            fontFamily: FontFamily.tajawalRegular,
                          ),
                        ),
                      ],
                    ),
                  ),
                  _circleBtn(Icons.flag_outlined, AppColors.warning, onReport),
                  SizedBox(width: 8.w),
                  _circleBtn(
                      Icons.chat_bubble_outline_rounded, AppColors.navy, onChat),
                  SizedBox(width: 8.w),
                  _circleBtn(Icons.call_rounded, AppColors.success, onCall),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _metric(IconData icon, String value, String label) => Expanded(
    child: Column(
      children: [
        Icon(icon, size: 18.w, color: AppColors.orange),
        SizedBox(height: 4.h),
        Text(value,
            style: TextStyle(
              fontSize: 13.sp,
              color: AppColors.mainText,
              fontFamily: FontFamily.tajawalBold,
            )),
        Text(label,
            style: TextStyle(
              fontSize: 10.sp,
              color: AppColors.secondaryText,
              fontFamily: FontFamily.tajawalRegular,
            )),
      ],
    ),
  );

  Widget _circleBtn(IconData icon, Color color, VoidCallback onTap) =>
      GestureDetector(
        onTap: onTap,
        child: Container(
          width: 40.w,
          height: 40.w,
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.12),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: color, size: 20.w),
        ),
      );
}
