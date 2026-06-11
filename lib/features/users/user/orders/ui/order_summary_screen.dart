import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:satha/core/constants/colors.dart';
import 'package:satha/core/di/dependancy_injection.dart';
import 'package:satha/core/routing/routes.dart';
import 'package:satha/core/widgets/flash_message.dart';
import 'package:satha/core/widgets/primary_button.dart';
import 'package:satha/gen/fonts.gen.dart';
import 'package:satha/generated/locale_keys.g.dart';
import '../data/models/order_model.dart';
import '../data/repos/orders_repository.dart';
import 'widgets/order_summary_content.dart';
import 'widgets/send_order_dialog.dart';

/// شاشة ملخّص الطلب قبل الإرسال.
class OrderSummaryScreen extends StatefulWidget {
  final OrderModel draft;
  const OrderSummaryScreen({super.key, required this.draft});

  @override
  State<OrderSummaryScreen> createState() => _OrderSummaryScreenState();
}

class _OrderSummaryScreenState extends State<OrderSummaryScreen> {
  bool _submitting = false;

  Future<void> _confirmAndSend() async {
    final confirmed = await SendOrderDialog.show(context);
    if (confirmed != true || !mounted) return;

    setState(() => _submitting = true);
    try {
      final order = await getIt<OrdersRepository>().createOrder(widget.draft);
      if (!mounted) return;
      Navigator.of(context).pushNamedAndRemoveUntil(
        Routes.orderCreatedSuccess,
        (r) => r.settings.name == Routes.customerHome,
        arguments: {'order': order},
      );
    } catch (_) {
      if (!mounted) return;
      setState(() => _submitting = false);
      showFlashMessage(
        message: LocaleKeys.something_went_wrong.tr(),
        type: FlashMessageType.error,
        context: context,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightBg,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          LocaleKeys.orderSummaryTitle.tr(),
          style: TextStyle(
            fontSize: 17.sp,
            color: AppColors.mainText,
            fontFamily: FontFamily.tajawalBold,
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.fromLTRB(16.w, 12.h, 16.w, 12.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  OrderSummaryContent(order: widget.draft),
                  SizedBox(height: 12.h),
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(14.w),
                    decoration: BoxDecoration(
                      color: AppColors.softOrange,
                      borderRadius: BorderRadius.circular(16.r),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.info_outline_rounded,
                          color: AppColors.orange,
                          size: 20.w,
                        ),
                        SizedBox(width: 10.w),
                        Expanded(
                          child: Text(
                            LocaleKeys.pricingNote.tr(),
                            style: TextStyle(
                              fontSize: 12.sp,
                              height: 1.5,
                              color: AppColors.mainText,
                              fontFamily: FontFamily.tajawalRegular,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.fromLTRB(16.w, 12.h, 16.w, 16.h),
            decoration: BoxDecoration(
              color: AppColors.card,
              border: Border(top: BorderSide(color: AppColors.border)),
            ),
            child: SafeArea(
              top: false,
              child: PrimaryButton(
                text: LocaleKeys.confirmSendOrder.tr(),
                loading: _submitting,
                icon: Icons.send_rounded,
                onPressed: _confirmAndSend,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
