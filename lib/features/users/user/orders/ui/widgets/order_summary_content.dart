import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:satha/core/constants/colors.dart';
import 'package:satha/core/widgets/app_svg_icon.dart';
import 'package:satha/gen/fonts.gen.dart';
import 'package:satha/generated/locale_keys.g.dart';
import '../../../create_order/data/models/order_flow_models.dart';
import '../../../vehicles/ui/widgets/vehicle_image.dart';
import '../../data/models/order_model.dart';

/// محتوى ملخّص الطلب — يُعاد استخدامه في الملخّص وتفاصيل الطلب.
class OrderSummaryContent extends StatelessWidget {
  final OrderModel order;
  const OrderSummaryContent({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _card(
          child: Row(
            children: [
              _iconBox(order.service.icon),
              SizedBox(width: 12.w),
              Text(
                order.service.titleKey.tr(),
                style: _titleStyle,
              ),
            ],
          ),
        ),
        SizedBox(height: 12.h),
        _card(
          child: Row(
            children: [
              VehicleImage(
                imagePath: order.vehicle.imagePath,
                heroTag: 'summary_${order.vehicle.id}',
                size: 52,
                radius: 12,
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(order.vehicle.name, style: _titleStyle),
                    SizedBox(height: 4.h),
                    Text(
                      '${order.vehicle.brand} ${order.vehicle.model} • ${order.vehicle.plateNumber}',
                      style: _subStyle,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 12.h),
        _card(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  _iconBox(order.problem.icon, small: true),
                  SizedBox(width: 12.w),
                  Text(order.problem.titleKey.tr(), style: _titleStyle),
                ],
              ),
              if (order.description != null && order.description!.isNotEmpty) ...[
                SizedBox(height: 10.h),
                Text(order.description!, style: _subStyle),
              ],
              if (order.problemImages.isNotEmpty) ...[
                SizedBox(height: 12.h),
                Wrap(
                  spacing: 8.w,
                  runSpacing: 8.h,
                  children: [
                    for (final path in order.problemImages)
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10.r),
                        child: Image.file(
                          File(path),
                          width: 56.w,
                          height: 56.w,
                          fit: BoxFit.cover,
                          errorBuilder: (_, __, ___) => Container(
                            width: 56.w,
                            height: 56.w,
                            color: AppColors.softOrange,
                          ),
                        ),
                      ),
                  ],
                ),
              ],
            ],
          ),
        ),
        SizedBox(height: 12.h),
        _card(
          child: Column(
            children: [
              _locationRow(
                AppColors.orange,
                LocaleKeys.pickupPoint.tr(),
                order.pickup.address,
              ),
              Padding(
                padding: EdgeInsetsDirectional.only(start: 4.w),
                child: SizedBox(
                  height: 18.h,
                  child: VerticalDivider(
                    color: AppColors.border,
                    thickness: 1.5,
                    width: 8.w,
                  ),
                ),
              ),
              _locationRow(
                AppColors.navy,
                LocaleKeys.destinationPoint.tr(),
                order.destination.address,
              ),
              SizedBox(height: 12.h),
              Row(
                children: [
                  _metric(
                    LocaleKeys.distanceLabel.tr(),
                    '${order.route.distanceKm} ${LocaleKeys.kmUnit.tr()}',
                  ),
                  Container(width: 1, height: 30.h, color: AppColors.border),
                  _metric(
                    LocaleKeys.durationLabel.tr(),
                    '${order.route.durationMin} ${LocaleKeys.minUnit.tr()}',
                  ),
                ],
              ),
            ],
          ),
        ),
        SizedBox(height: 12.h),
        _card(
          child: Row(
            children: [
              Icon(Icons.payments_outlined, color: AppColors.success, size: 22.w),
              SizedBox(width: 12.w),
              Text(LocaleKeys.payCash.tr(), style: _titleStyle),
            ],
          ),
        ),
      ],
    );
  }

  Widget _card({required Widget child}) => Container(
    width: double.infinity,
    padding: EdgeInsets.all(14.w),
    decoration: BoxDecoration(
      color: AppColors.card,
      borderRadius: BorderRadius.circular(18.r),
      border: Border.all(color: AppColors.border),
    ),
    child: child,
  );

  Widget _iconBox(String icon, {bool small = false}) => Container(
    width: small ? 40.w : 48.w,
    height: small ? 40.w : 48.w,
    decoration: BoxDecoration(
      color: AppColors.softOrange,
      borderRadius: BorderRadius.circular(14.r),
    ),
    child: Center(
      child: AppSvgIcon(assetPath: icon, size: 24.w, color: AppColors.orange),
    ),
  );

  Widget _locationRow(Color color, String label, String address) => Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Padding(
        padding: EdgeInsets.only(top: 4.h),
        child: Container(
          width: 10.w,
          height: 10.w,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
      ),
      SizedBox(width: 12.w),
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(label, style: _subStyle),
            Text(address, style: _titleStyle, maxLines: 2),
          ],
        ),
      ),
    ],
  );

  Widget _metric(String label, String value) => Expanded(
    child: Column(
      children: [
        Text(value, style: _titleStyle),
        SizedBox(height: 2.h),
        Text(label, style: _subStyle),
      ],
    ),
  );

  TextStyle get _titleStyle => TextStyle(
    fontSize: 14.sp,
    color: AppColors.mainText,
    fontFamily: FontFamily.tajawalBold,
  );

  TextStyle get _subStyle => TextStyle(
    fontSize: 12.sp,
    color: AppColors.secondaryText,
    fontFamily: FontFamily.tajawalRegular,
  );
}
