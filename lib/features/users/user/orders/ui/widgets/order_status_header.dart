import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:satha/core/constants/colors.dart';
import 'package:satha/gen/fonts.gen.dart';
import 'package:satha/generated/locale_keys.g.dart';
import '../../data/models/order_model.dart';

/// رأس متحرّك يعرض حالة الطلب بأيقونة نابضة.
class OrderStatusHeader extends StatefulWidget {
  final OrderModel order;
  const OrderStatusHeader({super.key, required this.order});

  @override
  State<OrderStatusHeader> createState() => _OrderStatusHeaderState();
}

class _OrderStatusHeaderState extends State<OrderStatusHeader>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 1400),
  )..repeat(reverse: true);

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  IconData get _icon {
    final s = widget.order.status;
    if (s.isCompleted) return Icons.check_circle_rounded;
    if (s.isCanceled) return Icons.cancel_rounded;
    switch (s) {
      case OrderStatus.searchingDrivers:
        return Icons.search_rounded;
      case OrderStatus.offersReceived:
        return Icons.local_offer_rounded;
      case OrderStatus.driverArrived:
      case OrderStatus.pickupConfirmed:
        return Icons.location_on_rounded;
      case OrderStatus.tripStarted:
      case OrderStatus.destinationReached:
        return Icons.local_shipping_rounded;
      default:
        return Icons.directions_car_rounded;
    }
  }

  @override
  Widget build(BuildContext context) {
    final color = Color(widget.order.status.colorValue);
    final active = widget.order.status.isActive;
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(vertical: 24.h, horizontal: 16.w),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [color.withValues(alpha: 0.14), AppColors.lightBg],
        ),
      ),
      child: Column(
        children: [
          AnimatedBuilder(
            animation: _controller,
            builder: (_, child) {
              final scale = active ? 1 + _controller.value * 0.12 : 1.0;
              return Transform.scale(scale: scale, child: child);
            },
            child: Container(
              width: 84.w,
              height: 84.w,
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.16),
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Container(
                  width: 60.w,
                  height: 60.w,
                  decoration: BoxDecoration(color: color, shape: BoxShape.circle),
                  child: Icon(_icon, color: Colors.white, size: 30.w),
                ),
              ),
            ),
          ),
          SizedBox(height: 14.h),
          Text(
            widget.order.status.labelKey.tr(),
            style: TextStyle(
              fontSize: 18.sp,
              color: AppColors.mainText,
              fontFamily: FontFamily.tajawalBold,
            ),
          ),
          SizedBox(height: 4.h),
          Text(
            '${LocaleKeys.orderNumberShort.tr()} ${widget.order.orderNumber}',
            style: TextStyle(
              fontSize: 13.sp,
              color: AppColors.secondaryText,
              fontFamily: FontFamily.tajawalRegular,
            ),
          ),
        ],
      ),
    );
  }
}
