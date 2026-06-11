import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:satha/core/constants/colors.dart';
import 'package:satha/gen/fonts.gen.dart';
import '../../data/models/notification_model.dart';

/// عنصر إشعار في القائمة.
class NotificationTile extends StatelessWidget {
  final NotificationModel notification;
  final VoidCallback onTap;
  const NotificationTile({
    super.key,
    required this.notification,
    required this.onTap,
  });

  ({IconData icon, Color color}) get _style {
    switch (notification.type) {
      case NotificationType.offer:
        return (icon: Icons.local_offer_rounded, color: AppColors.orange);
      case NotificationType.orderStatus:
        return (icon: Icons.local_shipping_rounded, color: AppColors.navy);
      case NotificationType.chat:
        return (icon: Icons.chat_bubble_rounded, color: AppColors.success);
      case NotificationType.promotion:
        return (icon: Icons.campaign_rounded, color: AppColors.warning);
      case NotificationType.system:
        return (icon: Icons.notifications_rounded, color: AppColors.secondaryText);
    }
  }

  @override
  Widget build(BuildContext context) {
    final s = _style;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.only(bottom: 10.h),
        padding: EdgeInsets.all(12.w),
        decoration: BoxDecoration(
          color: notification.read ? AppColors.card : AppColors.softOrange,
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(
            color: notification.read ? AppColors.border : AppColors.orange2,
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 42.w,
              height: 42.w,
              decoration: BoxDecoration(
                color: s.color.withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Icon(s.icon, color: s.color, size: 22.w),
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          notification.title,
                          style: TextStyle(
                            fontSize: 13.sp,
                            color: AppColors.mainText,
                            fontFamily: FontFamily.tajawalBold,
                          ),
                        ),
                      ),
                      if (!notification.read)
                        Container(
                          width: 8.w,
                          height: 8.w,
                          decoration: const BoxDecoration(
                            color: AppColors.orange,
                            shape: BoxShape.circle,
                          ),
                        ),
                    ],
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    notification.body,
                    style: TextStyle(
                      fontSize: 12.sp,
                      height: 1.4,
                      color: AppColors.secondaryText,
                      fontFamily: FontFamily.tajawalRegular,
                    ),
                  ),
                  SizedBox(height: 6.h),
                  Text(
                    DateFormat('yyyy/MM/dd • hh:mm a',
                            context.locale.languageCode)
                        .format(notification.time),
                    style: TextStyle(
                      fontSize: 10.sp,
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
    );
  }
}
