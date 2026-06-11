import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:satha/core/constants/colors.dart';
import 'package:satha/gen/fonts.gen.dart';
import 'package:satha/generated/locale_keys.g.dart';
import '../../data/models/chat_model.dart';

/// بطاقة محادثة في القائمة.
class ChatListCard extends StatelessWidget {
  final ChatModel chat;
  final VoidCallback onTap;
  const ChatListCard({super.key, required this.chat, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.only(bottom: 12.h),
        padding: EdgeInsets.all(12.w),
        decoration: BoxDecoration(
          color: AppColors.card,
          borderRadius: BorderRadius.circular(18.r),
          border: Border.all(color: AppColors.border),
        ),
        child: Row(
          children: [
            Stack(
              children: [
                Container(
                  width: 52.w,
                  height: 52.w,
                  decoration: BoxDecoration(
                    color: AppColors.softOrange,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.person_rounded,
                    color: AppColors.orange,
                    size: 28.w,
                  ),
                ),
                if (chat.online)
                  PositionedDirectional(
                    end: 2.w,
                    bottom: 2.h,
                    child: Container(
                      width: 12.w,
                      height: 12.w,
                      decoration: BoxDecoration(
                        color: AppColors.success,
                        shape: BoxShape.circle,
                        border: Border.all(color: AppColors.card, width: 2),
                      ),
                    ),
                  ),
              ],
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
                          chat.driverName,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 14.sp,
                            color: AppColors.mainText,
                            fontFamily: FontFamily.tajawalBold,
                          ),
                        ),
                      ),
                      Text(
                        DateFormat('hh:mm a', context.locale.languageCode)
                            .format(chat.lastTime),
                        style: TextStyle(
                          fontSize: 10.sp,
                          color: AppColors.secondaryText,
                          fontFamily: FontFamily.tajawalRegular,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 2.h),
                  Text(
                    '${LocaleKeys.orderNumberShort.tr()} ${chat.orderNumber}',
                    style: TextStyle(
                      fontSize: 11.sp,
                      color: AppColors.orange,
                      fontFamily: FontFamily.tajawalBold,
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          chat.lastMessage,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 12.sp,
                            color: AppColors.secondaryText,
                            fontFamily: FontFamily.tajawalRegular,
                          ),
                        ),
                      ),
                      if (chat.unreadCount > 0)
                        Container(
                          margin: EdgeInsetsDirectional.only(start: 6.w),
                          padding: EdgeInsets.all(6.w),
                          constraints: BoxConstraints(minWidth: 22.w),
                          decoration: const BoxDecoration(
                            color: AppColors.orange,
                            shape: BoxShape.circle,
                          ),
                          child: Text(
                            '${chat.unreadCount}',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 10.sp,
                              color: Colors.white,
                              fontFamily: FontFamily.tajawalBold,
                            ),
                          ),
                        ),
                    ],
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
