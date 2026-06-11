import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:satha/core/constants/colors.dart';
import 'package:satha/gen/fonts.gen.dart';
import 'package:satha/generated/locale_keys.g.dart';

/// ديالوج تأكيد قبول العرض.
class AcceptOfferDialog {
  static Future<bool?> show(BuildContext context) {
    return showDialog<bool>(
      context: context,
      builder: (_) => Dialog(
        backgroundColor: AppColors.card,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24.r),
        ),
        child: Padding(
          padding: EdgeInsets.all(22.w),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 64.w,
                height: 64.w,
                decoration: BoxDecoration(
                  color: AppColors.softOrange,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.handshake_rounded,
                  color: AppColors.orange,
                  size: 30.w,
                ),
              ),
              SizedBox(height: 16.h),
              Text(
                LocaleKeys.acceptOfferTitle.tr(),
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 17.sp,
                  color: AppColors.mainText,
                  fontFamily: FontFamily.tajawalBold,
                ),
              ),
              SizedBox(height: 8.h),
              Text(
                LocaleKeys.acceptOfferDesc.tr(),
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 13.sp,
                  height: 1.5,
                  color: AppColors.secondaryText,
                  fontFamily: FontFamily.tajawalRegular,
                ),
              ),
              SizedBox(height: 22.h),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () => Navigator.of(context).pop(false),
                      style: OutlinedButton.styleFrom(
                        minimumSize: Size(0, 50.h),
                        side: BorderSide(color: AppColors.border),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14.r),
                        ),
                      ),
                      child: Text(
                        LocaleKeys.cancel.tr(),
                        style: TextStyle(
                          color: AppColors.navy,
                          fontSize: 14.sp,
                          fontFamily: FontFamily.tajawalBold,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () => Navigator.of(context).pop(true),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.success,
                        elevation: 0,
                        minimumSize: Size(0, 50.h),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14.r),
                        ),
                      ),
                      child: Text(
                        LocaleKeys.acceptOfferBtn.tr(),
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14.sp,
                          fontFamily: FontFamily.tajawalBold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
