import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:satha/core/constants/colors.dart';
import 'package:satha/core/widgets/app_svg_icon.dart';
import 'package:satha/gen/fonts.gen.dart';
import 'package:satha/generated/locale_keys.g.dart';
import '../../../create_order/data/models/order_flow_models.dart';
import '../../data/models/offer_model.dart';

/// بطاقة عرض سعر مقدّم من سائق.
class OfferCard extends StatelessWidget {
  final OfferModel offer;
  final int remainingSec;
  final VoidCallback onViewDriver;
  final VoidCallback onAccept;
  final VoidCallback onReject;
  final bool busy;

  const OfferCard({
    super.key,
    required this.offer,
    required this.remainingSec,
    required this.onViewDriver,
    required this.onAccept,
    required this.onReject,
    this.busy = false,
  });

  @override
  Widget build(BuildContext context) {
    final d = offer.driver;
    return Container(
      margin: EdgeInsets.only(bottom: 12.h),
      padding: EdgeInsets.all(14.w),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              _avatar(d.imagePath),
              SizedBox(width: 12.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Flexible(
                          child: Text(
                            d.name,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 14.sp,
                              color: AppColors.mainText,
                              fontFamily: FontFamily.tajawalBold,
                            ),
                          ),
                        ),
                        if (d.verified) ...[
                          SizedBox(width: 4.w),
                          Icon(
                            Icons.verified_rounded,
                            color: AppColors.navy,
                            size: 16.w,
                          ),
                        ],
                      ],
                    ),
                    SizedBox(height: 4.h),
                    Row(
                      children: [
                        Icon(Icons.star_rounded,
                            color: AppColors.warning, size: 15.w),
                        SizedBox(width: 2.w),
                        Text(
                          '${d.rating} (${d.reviewsCount})',
                          style: _sub,
                        ),
                        SizedBox(width: 8.w),
                        Icon(Icons.check_circle_outline,
                            color: AppColors.success, size: 14.w),
                        SizedBox(width: 2.w),
                        Text(
                          '${d.completedTrips} ${LocaleKeys.tripsWord.tr()}',
                          style: _sub,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              _countdown(),
            ],
          ),
          SizedBox(height: 12.h),
          Container(
            padding: EdgeInsets.all(10.w),
            decoration: BoxDecoration(
              color: AppColors.lightBg,
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Row(
              children: [
                AppSvgIcon(
                  assetPath: d.towTruck.type.icon,
                  size: 22.w,
                  color: AppColors.orange,
                ),
                SizedBox(width: 8.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(d.towTruck.name,
                          style: TextStyle(
                            fontSize: 12.sp,
                            color: AppColors.mainText,
                            fontFamily: FontFamily.tajawalBold,
                          )),
                      Text(d.towTruck.type.titleKey.tr(), style: _sub),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 12.h),
          Row(
            children: [
              _metric(Icons.near_me_rounded,
                  '${offer.distanceFromCustomerKm} ${LocaleKeys.kmUnit.tr()}',
                  LocaleKeys.distanceFromYou.tr()),
              _metric(Icons.access_time_rounded,
                  '${offer.arrivalEstimateMin} ${LocaleKeys.minUnit.tr()}',
                  LocaleKeys.arrivalEstimate.tr()),
              _priceMetric(),
            ],
          ),
          if (offer.note != null && offer.note!.isNotEmpty) ...[
            SizedBox(height: 10.h),
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(10.w),
              decoration: BoxDecoration(
                color: AppColors.softOrange,
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Text(
                offer.note!,
                style: TextStyle(
                  fontSize: 12.sp,
                  height: 1.4,
                  color: AppColors.mainText,
                  fontFamily: FontFamily.tajawalRegular,
                ),
              ),
            ),
          ],
          SizedBox(height: 12.h),
          GestureDetector(
            onTap: onViewDriver,
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(vertical: 10.h),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12.r),
                border: Border.all(color: AppColors.navy.withValues(alpha: 0.4)),
              ),
              child: Text(
                LocaleKeys.viewDriverProfile.tr(),
                style: TextStyle(
                  fontSize: 13.sp,
                  color: AppColors.navy,
                  fontFamily: FontFamily.tajawalBold,
                ),
              ),
            ),
          ),
          SizedBox(height: 8.h),
          Row(
            children: [
              Expanded(
                child: _actionBtn(
                  label: LocaleKeys.rejectOfferBtn.tr(),
                  color: AppColors.error,
                  filled: false,
                  onTap: busy ? null : onReject,
                ),
              ),
              SizedBox(width: 10.w),
              Expanded(
                flex: 2,
                child: _actionBtn(
                  label: LocaleKeys.acceptOfferBtn.tr(),
                  color: AppColors.success,
                  filled: true,
                  onTap: busy ? null : onAccept,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _avatar(String? path) => Container(
    width: 52.w,
    height: 52.w,
    decoration: BoxDecoration(
      color: AppColors.softOrange,
      shape: BoxShape.circle,
    ),
    child: Icon(Icons.person_rounded, color: AppColors.orange, size: 28.w),
  );

  Widget _countdown() {
    final m = (remainingSec ~/ 60).toString().padLeft(2, '0');
    final s = (remainingSec % 60).toString().padLeft(2, '0');
    final low = remainingSec <= 20;
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
      decoration: BoxDecoration(
        color: (low ? AppColors.error : AppColors.navy).withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: Text(
        '$m:$s',
        style: TextStyle(
          fontSize: 12.sp,
          color: low ? AppColors.error : AppColors.navy,
          fontFamily: FontFamily.tajawalBold,
        ),
      ),
    );
  }

  Widget _metric(IconData icon, String value, String label) => Expanded(
    child: Column(
      children: [
        Icon(icon, size: 18.w, color: AppColors.secondaryText),
        SizedBox(height: 4.h),
        Text(value,
            style: TextStyle(
              fontSize: 12.sp,
              color: AppColors.mainText,
              fontFamily: FontFamily.tajawalBold,
            )),
        Text(label, style: _sub, textAlign: TextAlign.center),
      ],
    ),
  );

  Widget _priceMetric() => Expanded(
    child: Column(
      children: [
        Icon(Icons.payments_rounded, size: 18.w, color: AppColors.success),
        SizedBox(height: 4.h),
        Text('${offer.price} ${LocaleKeys.sar.tr()}',
            style: TextStyle(
              fontSize: 14.sp,
              color: AppColors.success,
              fontFamily: FontFamily.tajawalBold,
            )),
        Text(LocaleKeys.price.tr(), style: _sub),
      ],
    ),
  );

  Widget _actionBtn({
    required String label,
    required Color color,
    required bool filled,
    required VoidCallback? onTap,
  }) => GestureDetector(
    onTap: onTap,
    child: Container(
      padding: EdgeInsets.symmetric(vertical: 12.h),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: filled ? color : Colors.transparent,
        borderRadius: BorderRadius.circular(14.r),
        border: Border.all(color: color),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 14.sp,
          color: filled ? Colors.white : color,
          fontFamily: FontFamily.tajawalBold,
        ),
      ),
    ),
  );

  TextStyle get _sub => TextStyle(
    fontSize: 11.sp,
    color: AppColors.secondaryText,
    fontFamily: FontFamily.tajawalRegular,
  );
}
