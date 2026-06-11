import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:satha/core/constants/colors.dart';
import 'package:satha/core/widgets/app_svg_icon.dart';
import 'package:satha/gen/fonts.gen.dart';
import 'package:satha/generated/locale_keys.g.dart';
import '../../create_order/data/models/order_flow_models.dart';
import '../data/models/driver_public_profile_model.dart';
import '../data/models/review_model.dart';
import 'widgets/section_card.dart';

/// شاشة الملف العام للسائق.
class DriverPublicProfileScreen extends StatelessWidget {
  final DriverPublicProfileModel driver;
  const DriverPublicProfileScreen({super.key, required this.driver});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightBg,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          LocaleKeys.Drivers_Profile.tr(),
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
            _header(),
            SizedBox(height: 16.h),
            _stats(),
            SizedBox(height: 16.h),
            SectionCard(
              title: LocaleKeys.towTruckInfo.tr(),
              child: Row(
                children: [
                  Container(
                    width: 48.w,
                    height: 48.w,
                    decoration: BoxDecoration(
                      color: AppColors.softOrange,
                      borderRadius: BorderRadius.circular(14.r),
                    ),
                    child: Center(
                      child: AppSvgIcon(
                        assetPath: driver.towTruck.type.icon,
                        size: 26.w,
                        color: AppColors.orange,
                      ),
                    ),
                  ),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          driver.towTruck.name,
                          style: TextStyle(
                            fontSize: 14.sp,
                            color: AppColors.mainText,
                            fontFamily: FontFamily.tajawalBold,
                          ),
                        ),
                        SizedBox(height: 2.h),
                        Text(
                          '${driver.towTruck.type.titleKey.tr()}'
                          '${driver.towTruck.plateNumber != null ? ' • ${driver.towTruck.plateNumber}' : ''}',
                          style: TextStyle(
                            fontSize: 12.sp,
                            color: AppColors.secondaryText,
                            fontFamily: FontFamily.tajawalRegular,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            if (driver.bio != null) ...[
              SizedBox(height: 16.h),
              SectionCard(
                title: LocaleKeys.aboutDriver.tr(),
                child: Text(
                  driver.bio!,
                  style: TextStyle(
                    fontSize: 13.sp,
                    height: 1.6,
                    color: AppColors.secondaryText,
                    fontFamily: FontFamily.tajawalRegular,
                  ),
                ),
              ),
            ],
            SizedBox(height: 16.h),
            Text(
              LocaleKeys.reviews.tr(),
              style: TextStyle(
                fontSize: 14.sp,
                color: AppColors.mainText,
                fontFamily: FontFamily.tajawalBold,
              ),
            ),
            SizedBox(height: 10.h),
            if (driver.reviews.isEmpty)
              Padding(
                padding: EdgeInsets.symmetric(vertical: 20.h),
                child: Center(
                  child: Text(
                    LocaleKeys.reviews_empty.tr(),
                    style: TextStyle(
                      fontSize: 13.sp,
                      color: AppColors.secondaryText,
                      fontFamily: FontFamily.tajawalRegular,
                    ),
                  ),
                ),
              )
            else
              for (final r in driver.reviews) _reviewTile(r),
          ],
        ),
      ),
    );
  }

  Widget _header() => Container(
    width: double.infinity,
    padding: EdgeInsets.all(18.w),
    decoration: BoxDecoration(
      color: AppColors.card,
      borderRadius: BorderRadius.circular(20.r),
      border: Border.all(color: AppColors.border),
    ),
    child: Column(
      children: [
        Container(
          width: 88.w,
          height: 88.w,
          decoration: const BoxDecoration(
            color: AppColors.softOrange,
            shape: BoxShape.circle,
          ),
          child: Icon(Icons.person_rounded, color: AppColors.orange, size: 46.w),
        ),
        SizedBox(height: 12.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              driver.name,
              style: TextStyle(
                fontSize: 18.sp,
                color: AppColors.mainText,
                fontFamily: FontFamily.tajawalBold,
              ),
            ),
            if (driver.verified) ...[
              SizedBox(width: 6.w),
              Icon(Icons.verified_rounded, color: AppColors.navy, size: 20.w),
            ],
          ],
        ),
        SizedBox(height: 6.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.star_rounded, color: AppColors.warning, size: 18.w),
            SizedBox(width: 4.w),
            Text(
              '${driver.rating} (${driver.reviewsCount} ${LocaleKeys.reviews.tr()})',
              style: TextStyle(
                fontSize: 13.sp,
                color: AppColors.secondaryText,
                fontFamily: FontFamily.tajawalRegular,
              ),
            ),
          ],
        ),
      ],
    ),
  );

  Widget _stats() => Row(
    children: [
      _statBox(
        Icons.check_circle_rounded,
        '${driver.completedTrips}',
        LocaleKeys.completedTrips.tr(),
      ),
      SizedBox(width: 10.w),
      _statBox(
        Icons.calendar_month_rounded,
        '${driver.platformMonths} ${LocaleKeys.monthsWord.tr()}',
        LocaleKeys.platformTime.tr(),
      ),
      SizedBox(width: 10.w),
      _statBox(
        Icons.star_rounded,
        '${driver.rating}',
        LocaleKeys.ratingWord.tr(),
      ),
    ],
  );

  Widget _statBox(IconData icon, String value, String label) => Expanded(
    child: Container(
      padding: EdgeInsets.symmetric(vertical: 14.h, horizontal: 6.w),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        children: [
          Icon(icon, color: AppColors.orange, size: 22.w),
          SizedBox(height: 6.h),
          Text(
            value,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 14.sp,
              color: AppColors.mainText,
              fontFamily: FontFamily.tajawalBold,
            ),
          ),
          SizedBox(height: 2.h),
          Text(
            label,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 10.sp,
              color: AppColors.secondaryText,
              fontFamily: FontFamily.tajawalRegular,
            ),
          ),
        ],
      ),
    ),
  );

  Widget _reviewTile(ReviewModel r) => Container(
    margin: EdgeInsets.only(bottom: 10.h),
    padding: EdgeInsets.all(14.w),
    decoration: BoxDecoration(
      color: AppColors.card,
      borderRadius: BorderRadius.circular(16.r),
      border: Border.all(color: AppColors.border),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              r.customerName,
              style: TextStyle(
                fontSize: 13.sp,
                color: AppColors.mainText,
                fontFamily: FontFamily.tajawalBold,
              ),
            ),
            const Spacer(),
            Icon(Icons.star_rounded, color: AppColors.warning, size: 15.w),
            SizedBox(width: 2.w),
            Text(
              '${r.rating}',
              style: TextStyle(
                fontSize: 12.sp,
                color: AppColors.secondaryText,
                fontFamily: FontFamily.tajawalBold,
              ),
            ),
          ],
        ),
        if (r.comment != null && r.comment!.isNotEmpty) ...[
          SizedBox(height: 6.h),
          Text(
            r.comment!,
            style: TextStyle(
              fontSize: 12.sp,
              height: 1.5,
              color: AppColors.secondaryText,
              fontFamily: FontFamily.tajawalRegular,
            ),
          ),
        ],
      ],
    ),
  );
}
