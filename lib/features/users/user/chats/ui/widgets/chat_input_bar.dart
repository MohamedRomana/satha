import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:satha/core/constants/colors.dart';
import 'package:satha/gen/fonts.gen.dart';
import 'package:satha/generated/locale_keys.g.dart';

/// شريط إدخال المحادثة: إرفاق صورة / إرسال موقع / نص / إرسال.
class ChatInputBar extends StatefulWidget {
  final ValueChanged<String> onSendText;
  final VoidCallback onAttachImage;
  final VoidCallback onSendLocation;

  const ChatInputBar({
    super.key,
    required this.onSendText,
    required this.onAttachImage,
    required this.onSendLocation,
  });

  @override
  State<ChatInputBar> createState() => _ChatInputBarState();
}

class _ChatInputBarState extends State<ChatInputBar> {
  final _controller = TextEditingController();
  bool _hasText = false;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _send() {
    if (_controller.text.trim().isEmpty) return;
    widget.onSendText(_controller.text);
    _controller.clear();
    setState(() => _hasText = false);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(10.w, 8.h, 10.w, 8.h),
      decoration: const BoxDecoration(
        color: AppColors.card,
        border: Border(top: BorderSide(color: AppColors.border)),
      ),
      child: SafeArea(
        top: false,
        child: Row(
          children: [
            _iconBtn(Icons.camera_alt_rounded, widget.onAttachImage),
            _iconBtn(Icons.location_on_rounded, widget.onSendLocation),
            Expanded(
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 6.w),
                padding: EdgeInsets.symmetric(horizontal: 14.w),
                decoration: BoxDecoration(
                  color: AppColors.lightBg,
                  borderRadius: BorderRadius.circular(24.r),
                  border: Border.all(color: AppColors.border),
                ),
                child: TextField(
                  controller: _controller,
                  onChanged: (v) =>
                      setState(() => _hasText = v.trim().isNotEmpty),
                  onSubmitted: (_) => _send(),
                  textInputAction: TextInputAction.send,
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: AppColors.mainText,
                    fontFamily: FontFamily.tajawalRegular,
                  ),
                  decoration: InputDecoration(
                    hintText: LocaleKeys.typeMessage.tr(),
                    hintStyle: TextStyle(
                      fontSize: 13.sp,
                      color: AppColors.secondaryText,
                      fontFamily: FontFamily.tajawalRegular,
                    ),
                    border: InputBorder.none,
                    isCollapsed: true,
                    contentPadding: EdgeInsets.symmetric(vertical: 12.h),
                  ),
                ),
              ),
            ),
            GestureDetector(
              onTap: _send,
              child: Container(
                width: 44.w,
                height: 44.w,
                decoration: BoxDecoration(
                  color: _hasText ? AppColors.orange : AppColors.border,
                  shape: BoxShape.circle,
                ),
                child: Icon(Icons.send_rounded, color: Colors.white, size: 20.w),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _iconBtn(IconData icon, VoidCallback onTap) => GestureDetector(
    onTap: onTap,
    child: Padding(
      padding: EdgeInsets.symmetric(horizontal: 4.w),
      child: Icon(icon, color: AppColors.navy, size: 24.w),
    ),
  );
}
