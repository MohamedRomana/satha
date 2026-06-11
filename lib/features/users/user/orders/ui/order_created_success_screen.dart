import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:satha/core/constants/colors.dart';
import 'package:satha/core/routing/routes.dart';
import 'package:satha/core/widgets/primary_button.dart';
import 'package:satha/gen/fonts.gen.dart';
import 'package:satha/generated/locale_keys.g.dart';
import '../data/models/order_model.dart';

/// شاشة نجاح إرسال الطلب.
class OrderCreatedSuccessScreen extends StatefulWidget {
  final OrderModel order;
  const OrderCreatedSuccessScreen({super.key, required this.order});

  @override
  State<OrderCreatedSuccessScreen> createState() =>
      _OrderCreatedSuccessScreenState();
}

class _OrderCreatedSuccessScreenState extends State<OrderCreatedSuccessScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _scale;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 700),
    );
    _scale = CurvedAnimation(parent: _controller, curve: Curves.elasticOut);
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _trackOrder() {
    Navigator.of(context).pushReplacementNamed(
      Routes.orderDetails,
      arguments: {'orderId': widget.order.id},
    );
  }

  void _goHome() {
    Navigator.of(
      context,
    ).popUntil((r) => r.settings.name == Routes.customerHome);
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, _) {
        if (!didPop) _goHome();
      },
      child: Scaffold(
        backgroundColor: AppColors.lightBg,
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w),
            child: Column(
              children: [
                const Spacer(),
                ScaleTransition(
                  scale: _scale,
                  child: Container(
                    width: 120.w,
                    height: 120.w,
                    decoration: BoxDecoration(
                      color: AppColors.success.withValues(alpha: 0.12),
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: Container(
                        width: 80.w,
                        height: 80.w,
                        decoration: const BoxDecoration(
                          color: AppColors.success,
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.check_rounded,
                          color: Colors.white,
                          size: 46.w,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 28.h),
                Text(
                  LocaleKeys.orderSentTitle.tr(),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 22.sp,
                    color: AppColors.mainText,
                    fontFamily: FontFamily.tajawalBold,
                  ),
                ),
                SizedBox(height: 12.h),
                Text(
                  LocaleKeys.orderSentDesc.tr(),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14.sp,
                    height: 1.6,
                    color: AppColors.secondaryText,
                    fontFamily: FontFamily.tajawalRegular,
                  ),
                ),
                SizedBox(height: 20.h),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 10.h),
                  decoration: BoxDecoration(
                    color: AppColors.softOrange,
                    borderRadius: BorderRadius.circular(14.r),
                  ),
                  child: Text(
                    '${LocaleKeys.orderNumberShort.tr()}: ${widget.order.orderNumber}',
                    style: TextStyle(
                      fontSize: 14.sp,
                      color: AppColors.orange,
                      fontFamily: FontFamily.tajawalBold,
                    ),
                  ),
                ),
                const Spacer(),
                PrimaryButton(
                  text: LocaleKeys.trackOrderBtn.tr(),
                  icon: Icons.location_on_rounded,
                  onPressed: _trackOrder,
                ),
                SizedBox(height: 12.h),
                TextButton(
                  onPressed: _goHome,
                  child: Text(
                    LocaleKeys.backToHomeBtn.tr(),
                    style: TextStyle(
                      fontSize: 15.sp,
                      color: AppColors.navy,
                      fontFamily: FontFamily.tajawalBold,
                    ),
                  ),
                ),
                SizedBox(height: 16.h),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
