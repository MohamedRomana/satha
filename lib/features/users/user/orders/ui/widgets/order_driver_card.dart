import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:satha/core/constants/colors.dart';
import 'package:satha/gen/fonts.gen.dart';
import 'package:satha/generated/locale_keys.g.dart';

/// بطاقة السائق المقبول داخل تفاصيل الطلب.
class OrderDriverCard extends StatelessWidget {
  final String driverName;
  final VoidCallback? onCall;
  final VoidCallback? onChat;
  const OrderDriverCard({
    super.key,
    required this.driverName,
    this.onCall,
    this.onChat,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(14.w),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(18.r),
        border: Border.all(color: AppColors.border),
      ),
      child: Row(
        children: [
          Container(
            width: 48.w,
            height: 48.w,
            decoration: const BoxDecoration(
              color: AppColors.softOrange,
              shape: BoxShape.circle,
            ),
            child: Icon(Icons.person_rounded, color: AppColors.orange, size: 26.w),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  driverName,
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: AppColors.mainText,
                    fontFamily: FontFamily.tajawalBold,
                  ),
                ),
                SizedBox(height: 2.h),
                Text(
                  LocaleKeys.assignedDriver.tr(),
                  style: TextStyle(
                    fontSize: 11.sp,
                    color: AppColors.secondaryText,
                    fontFamily: FontFamily.tajawalRegular,
                  ),
                ),
              ],
            ),
          ),
          if (onChat != null)
            _circleBtn(Icons.chat_bubble_outline_rounded, AppColors.navy, onChat!),
          if (onCall != null) ...[
            SizedBox(width: 8.w),
            _circleBtn(Icons.call_rounded, AppColors.success, onCall!),
          ],
        ],
      ),
    );
  }

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
