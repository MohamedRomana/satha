import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:satha/core/constants/app_icons.dart';
import 'package:satha/core/constants/colors.dart';
import 'package:satha/core/widgets/app_svg_icon.dart';
import 'package:satha/gen/fonts.gen.dart';
import 'package:satha/generated/locale_keys.g.dart';

/// رأس الهوم: تحية + اسم العميل + زر إشعارات مع عدّاد غير مقروء.
class HomeHeader extends StatelessWidget {
  final String customerName;
  final int unreadCount;
  final VoidCallback onNotifications;

  const HomeHeader({
    super.key,
    required this.customerName,
    required this.unreadCount,
    required this.onNotifications,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${LocaleKeys.greetingHello.tr()} $customerName',
                style: TextStyle(
                  fontSize: 20.sp,
                  color: AppColors.mainText,
                  fontFamily: FontFamily.tajawalBold,
                ),
              ),
              SizedBox(height: 4.h),
              Text(
                LocaleKeys.needHelpOnRoad.tr(),
                style: TextStyle(
                  fontSize: 13.sp,
                  color: AppColors.secondaryText,
                  fontFamily: FontFamily.tajawalRegular,
                ),
              ),
            ],
          ),
        ),
        _NotificationButton(count: unreadCount, onTap: onNotifications),
      ],
    );
  }
}

class _NotificationButton extends StatelessWidget {
  final int count;
  final VoidCallback onTap;
  const _NotificationButton({required this.count, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16.r),
      child: Container(
        width: 46.w,
        height: 46.w,
        decoration: BoxDecoration(
          color: AppColors.card,
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(color: AppColors.border),
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            AppSvgIcon(
              assetPath: AppIcons.notification,
              size: 22.w,
              color: AppColors.navy,
            ),
            if (count > 0)
              PositionedDirectional(
                top: 8.h,
                end: 9.w,
                child: Container(
                  padding: EdgeInsets.all(count > 9 ? 2.w : 0),
                  constraints: BoxConstraints(minWidth: 16.w, minHeight: 16.w),
                  decoration: BoxDecoration(
                    color: AppColors.error,
                    shape: BoxShape.circle,
                    border: Border.all(color: AppColors.card, width: 1.5),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    count > 9 ? '9+' : '$count',
                    style: TextStyle(
                      fontSize: 8.sp,
                      color: Colors.white,
                      fontFamily: FontFamily.tajawalBold,
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
