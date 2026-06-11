import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:satha/core/constants/colors.dart';
import 'package:satha/core/widgets/fade_slide_in.dart';
import 'package:satha/gen/fonts.gen.dart';
import 'package:satha/generated/locale_keys.g.dart';
import '../../data/models/message_model.dart';

/// فقاعة رسالة في المحادثة (مع أنميشن دخول).
class MessageBubble extends StatelessWidget {
  final MessageModel message;
  const MessageBubble({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    if (message.type == MessageType.system) {
      return Center(
        child: Container(
          margin: EdgeInsets.symmetric(vertical: 8.h),
          padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
          decoration: BoxDecoration(
            color: AppColors.border.withValues(alpha: 0.5),
            borderRadius: BorderRadius.circular(12.r),
          ),
          child: Text(
            message.text ?? '',
            style: TextStyle(
              fontSize: 11.sp,
              color: AppColors.secondaryText,
              fontFamily: FontFamily.tajawalRegular,
            ),
          ),
        ),
      );
    }

    final me = message.fromMe;
    return FadeSlideIn(
      from: me ? SlideFrom.end : SlideFrom.start,
      duration: const Duration(milliseconds: 300),
      offset: 20,
      child: Align(
        alignment: me ? Alignment.centerLeft : Alignment.centerRight,
        child: Container(
          margin: EdgeInsets.only(bottom: 10.h),
          padding: EdgeInsets.all(10.w),
          constraints: BoxConstraints(maxWidth: 260.w),
          decoration: BoxDecoration(
            color: me ? AppColors.orange : AppColors.card,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(16.r),
              topRight: Radius.circular(16.r),
              bottomLeft: Radius.circular(me ? 4.r : 16.r),
              bottomRight: Radius.circular(me ? 16.r : 4.r),
            ),
            border: me ? null : Border.all(color: AppColors.border),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _content(me),
              SizedBox(height: 4.h),
              Text(
                DateFormat('hh:mm a', context.locale.languageCode)
                    .format(message.timestamp),
                style: TextStyle(
                  fontSize: 9.sp,
                  color: me ? Colors.white70 : AppColors.secondaryText,
                  fontFamily: FontFamily.tajawalRegular,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _content(bool me) {
    switch (message.type) {
      case MessageType.image:
        return ClipRRect(
          borderRadius: BorderRadius.circular(10.r),
          child: message.imagePath != null
              ? Image.file(
                  File(message.imagePath!),
                  width: 180.w,
                  height: 180.w,
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) => Container(
                    width: 180.w,
                    height: 120.w,
                    color: AppColors.softOrange,
                  ),
                )
              : const SizedBox.shrink(),
        );
      case MessageType.location:
        return Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.location_on_rounded,
              size: 18.w,
              color: me ? Colors.white : AppColors.orange,
            ),
            SizedBox(width: 6.w),
            Text(
              LocaleKeys.sharedLocation.tr(),
              style: TextStyle(
                fontSize: 13.sp,
                color: me ? Colors.white : AppColors.mainText,
                fontFamily: FontFamily.tajawalBold,
              ),
            ),
          ],
        );
      default:
        return Text(
          message.text ?? '',
          style: TextStyle(
            fontSize: 13.sp,
            height: 1.4,
            color: me ? Colors.white : AppColors.mainText,
            fontFamily: FontFamily.tajawalRegular,
          ),
        );
    }
  }
}
