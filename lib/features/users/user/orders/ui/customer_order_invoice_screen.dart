import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:satha/core/cache/cache_helper.dart';
import 'package:satha/core/constants/colors.dart';
import 'package:satha/gen/fonts.gen.dart';
import 'package:satha/generated/locale_keys.g.dart';
import '../../create_order/data/models/order_flow_models.dart';
import '../data/models/invoice_model.dart';
import '../data/models/order_model.dart';

/// شاشة فاتورة طلب مكتمل.
class CustomerOrderInvoiceScreen extends StatelessWidget {
  final OrderModel order;
  const CustomerOrderInvoiceScreen({super.key, required this.order});

  InvoiceModel _buildInvoice(BuildContext context) {
    final customer = CacheHelper.getUserName();
    return InvoiceModel(
      invoiceNumber: 'INV-${order.orderNumber.replaceAll('ST-', '')}',
      orderNumber: order.orderNumber,
      date: order.createdAt,
      customerName: customer.isEmpty ? LocaleKeys.customer.tr() : customer,
      driverName: order.driverName ?? '-',
      vehicleName: '${order.vehicle.name} • ${order.vehicle.plateNumber}',
      serviceLabel: order.service.titleKey.tr(),
      pickupAddress: order.pickup.address,
      destinationAddress: order.destination.address,
      distanceKm: order.route.distanceKm,
      durationMin: order.route.durationMin,
      price: order.acceptedPrice ?? 0,
      discount: 0,
      paymentMethod: LocaleKeys.payCash.tr(),
      paid: true,
    );
  }

  @override
  Widget build(BuildContext context) {
    final inv = _buildInvoice(context);
    final date = DateFormat('yyyy/MM/dd', context.locale.languageCode)
        .format(inv.date);
    return Scaffold(
      backgroundColor: AppColors.lightBg,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          LocaleKeys.invoice.tr(),
          style: TextStyle(
            fontSize: 17.sp,
            color: AppColors.mainText,
            fontFamily: FontFamily.tajawalBold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 24.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _header(inv),
            SizedBox(height: 16.h),
            _card([
              _row(LocaleKeys.invoiceNumber.tr(), inv.invoiceNumber),
              _row(LocaleKeys.orderNumberShort.tr(), inv.orderNumber),
              _row(LocaleKeys.invoiceDate.tr(), date),
              _row(LocaleKeys.customer.tr(), inv.customerName),
              _row(LocaleKeys.driverWord.tr(), inv.driverName),
            ]),
            SizedBox(height: 12.h),
            _card([
              _row(LocaleKeys.summaryVehicle.tr(), inv.vehicleName),
              _row(LocaleKeys.serviceType.tr(), inv.serviceLabel),
              _row(LocaleKeys.pickupPoint.tr(), inv.pickupAddress),
              _row(LocaleKeys.destinationPoint.tr(), inv.destinationAddress),
              _row(LocaleKeys.distanceLabel.tr(),
                  '${inv.distanceKm} ${LocaleKeys.kmUnit.tr()}'),
              _row(LocaleKeys.durationLabel.tr(),
                  '${inv.durationMin} ${LocaleKeys.minUnit.tr()}'),
            ]),
            SizedBox(height: 12.h),
            _card([
              _row(LocaleKeys.price.tr(),
                  '${inv.price} ${LocaleKeys.sar.tr()}'),
              _row(LocaleKeys.discount.tr(),
                  '${inv.discount} ${LocaleKeys.sar.tr()}'),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 6.h),
                child: Divider(color: AppColors.border, height: 1),
              ),
              _row(
                LocaleKeys.total.tr(),
                '${inv.total} ${LocaleKeys.sar.tr()}',
                highlight: true,
              ),
            ]),
            SizedBox(height: 12.h),
            _card([
              _row(LocaleKeys.paymentMethod.tr(), inv.paymentMethod),
              _row(
                LocaleKeys.paymentStatus.tr(),
                inv.paid
                    ? LocaleKeys.paid.tr()
                    : LocaleKeys.unpaid.tr(),
                valueColor: inv.paid ? AppColors.success : AppColors.warning,
              ),
            ]),
          ],
        ),
      ),
    );
  }

  Widget _header(InvoiceModel inv) => Container(
    width: double.infinity,
    padding: EdgeInsets.all(18.w),
    decoration: BoxDecoration(
      gradient: const LinearGradient(
        colors: [AppColors.navy, AppColors.navy2],
      ),
      borderRadius: BorderRadius.circular(20.r),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.receipt_long_rounded, color: Colors.white, size: 26.w),
            SizedBox(width: 10.w),
            Text(
              LocaleKeys.appName.tr(),
              style: TextStyle(
                fontSize: 18.sp,
                color: Colors.white,
                fontFamily: FontFamily.tajawalBold,
              ),
            ),
            const Spacer(),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.16),
                borderRadius: BorderRadius.circular(20.r),
              ),
              child: Text(
                inv.paid ? LocaleKeys.paid.tr() : LocaleKeys.unpaid.tr(),
                style: TextStyle(
                  fontSize: 11.sp,
                  color: Colors.white,
                  fontFamily: FontFamily.tajawalBold,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 14.h),
        Text(
          '${inv.total} ${LocaleKeys.sar.tr()}',
          style: TextStyle(
            fontSize: 28.sp,
            color: Colors.white,
            fontFamily: FontFamily.tajawalBold,
          ),
        ),
        Text(
          inv.invoiceNumber,
          style: TextStyle(
            fontSize: 12.sp,
            color: Colors.white.withValues(alpha: 0.8),
            fontFamily: FontFamily.tajawalRegular,
          ),
        ),
      ],
    ),
  );

  Widget _card(List<Widget> children) => Container(
    width: double.infinity,
    padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 6.h),
    decoration: BoxDecoration(
      color: AppColors.card,
      borderRadius: BorderRadius.circular(18.r),
      border: Border.all(color: AppColors.border),
    ),
    child: Column(children: children),
  );

  Widget _row(
    String label,
    String value, {
    bool highlight = false,
    Color? valueColor,
  }) => Padding(
    padding: EdgeInsets.symmetric(vertical: 8.h),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: highlight ? 15.sp : 13.sp,
            color: AppColors.secondaryText,
            fontFamily: highlight
                ? FontFamily.tajawalBold
                : FontFamily.tajawalRegular,
          ),
        ),
        SizedBox(width: 12.w),
        Expanded(
          child: Text(
            value,
            textAlign: TextAlign.end,
            style: TextStyle(
              fontSize: highlight ? 16.sp : 13.sp,
              color: valueColor ??
                  (highlight ? AppColors.success : AppColors.mainText),
              fontFamily: FontFamily.tajawalBold,
            ),
          ),
        ),
      ],
    ),
  );
}
