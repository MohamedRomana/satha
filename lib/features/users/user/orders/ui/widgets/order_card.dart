import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:satha/core/constants/colors.dart';
import 'package:satha/core/widgets/app_svg_icon.dart';
import 'package:satha/gen/fonts.gen.dart';
import 'package:satha/generated/locale_keys.g.dart';
import '../../../create_order/data/models/order_flow_models.dart';
import '../../data/models/order_model.dart';
import 'order_status_chip.dart';

/// بطاقة طلب في القائمة.
class OrderCard extends StatelessWidget {
  final OrderModel order;
  final VoidCallback onTap;
  const OrderCard({super.key, required this.order, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.only(bottom: 12.h),
        padding: EdgeInsets.all(14.w),
        decoration: BoxDecoration(
          color: AppColors.card,
          borderRadius: BorderRadius.circular(18.r),
          border: Border.all(color: AppColors.border),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  '${LocaleKeys.orderNumberShort.tr()} ${order.orderNumber}',
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: AppColors.mainText,
                    fontFamily: FontFamily.tajawalBold,
                  ),
                ),
                const Spacer(),
                OrderStatusChip(status: order.status),
              ],
            ),
            SizedBox(height: 12.h),
            Row(
              children: [
                Container(
                  width: 40.w,
                  height: 40.w,
                  decoration: BoxDecoration(
                    color: AppColors.softOrange,
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: Center(
                    child: AppSvgIcon(
                      assetPath: order.service.icon,
                      size: 22.w,
                      color: AppColors.orange,
                    ),
                  ),
                ),
                SizedBox(width: 10.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        order.service.titleKey.tr(),
                        style: TextStyle(
                          fontSize: 13.sp,
                          color: AppColors.mainText,
                          fontFamily: FontFamily.tajawalBold,
                        ),
                      ),
                      SizedBox(height: 2.h),
                      Text(
                        '${order.vehicle.name} • ${order.vehicle.plateNumber}',
                        style: TextStyle(
                          fontSize: 11.sp,
                          color: AppColors.secondaryText,
                          fontFamily: FontFamily.tajawalRegular,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 12.h),
            _locationLine(AppColors.orange, order.pickup.address),
            SizedBox(height: 4.h),
            _locationLine(AppColors.navy, order.destination.address),
            SizedBox(height: 12.h),
            const Divider(color: AppColors.border, height: 1),
            SizedBox(height: 10.h),
            Row(
              children: [
                Icon(
                  Icons.access_time_rounded,
                  size: 14.w,
                  color: AppColors.secondaryText,
                ),
                SizedBox(width: 4.w),
                Text(
                  _formatDate(context, order.createdAt),
                  style: TextStyle(
                    fontSize: 11.sp,
                    color: AppColors.secondaryText,
                    fontFamily: FontFamily.tajawalRegular,
                  ),
                ),
                const Spacer(),
                if (order.acceptedPrice != null)
                  Text(
                    '${order.acceptedPrice} ${LocaleKeys.sar.tr()}',
                    style: TextStyle(
                      fontSize: 14.sp,
                      color: AppColors.success,
                      fontFamily: FontFamily.tajawalBold,
                    ),
                  )
                else if (order.offersCount > 0)
                  Text(
                    '${order.offersCount} ${LocaleKeys.offersWord.tr()}',
                    style: TextStyle(
                      fontSize: 12.sp,
                      color: AppColors.orange,
                      fontFamily: FontFamily.tajawalBold,
                    ),
                  ),
              ],
            ),
            if (order.driverName != null) ...[
              SizedBox(height: 8.h),
              Row(
                children: [
                  Icon(
                    Icons.person_rounded,
                    size: 14.w,
                    color: AppColors.navy,
                  ),
                  SizedBox(width: 4.w),
                  Text(
                    order.driverName!,
                    style: TextStyle(
                      fontSize: 12.sp,
                      color: AppColors.navy,
                      fontFamily: FontFamily.tajawalBold,
                    ),
                  ),
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _locationLine(Color color, String text) => Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Padding(
        padding: EdgeInsets.only(top: 3.h),
        child: Container(
          width: 8.w,
          height: 8.w,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
      ),
      SizedBox(width: 8.w),
      Expanded(
        child: Text(
          text,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            fontSize: 12.sp,
            color: AppColors.mainText,
            fontFamily: FontFamily.tajawalRegular,
          ),
        ),
      ),
    ],
  );

  String _formatDate(BuildContext context, DateTime date) {
    final locale = context.locale.languageCode;
    final d = DateFormat('yyyy/MM/dd', locale).format(date);
    final t = DateFormat('hh:mm a', locale).format(date);
    return '$d • $t';
  }
}
