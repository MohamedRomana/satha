import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:satha/core/constants/colors.dart';
import 'package:satha/gen/fonts.gen.dart';
import '../../data/models/support_models.dart';

/// بطاقة سؤال شائع قابلة للطي مع أنميشن.
class FaqCard extends StatefulWidget {
  final FaqModel faq;
  const FaqCard({super.key, required this.faq});

  @override
  State<FaqCard> createState() => _FaqCardState();
}

class _FaqCardState extends State<FaqCard> {
  bool _open = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => setState(() => _open = !_open),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        margin: EdgeInsets.only(bottom: 12.h),
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: AppColors.card,
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(
            color: _open ? AppColors.orange : AppColors.border,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    widget.faq.question,
                    style: TextStyle(
                      fontSize: 14.sp,
                      color: AppColors.mainText,
                      fontFamily: FontFamily.tajawalBold,
                    ),
                  ),
                ),
                AnimatedRotation(
                  turns: _open ? 0.5 : 0,
                  duration: const Duration(milliseconds: 250),
                  child: Icon(
                    Icons.keyboard_arrow_down_rounded,
                    color: _open ? AppColors.orange : AppColors.secondaryText,
                    size: 24.w,
                  ),
                ),
              ],
            ),
            AnimatedCrossFade(
              firstChild: const SizedBox(width: double.infinity),
              secondChild: Padding(
                padding: EdgeInsets.only(top: 10.h),
                child: Text(
                  widget.faq.answer,
                  style: TextStyle(
                    fontSize: 13.sp,
                    height: 1.7,
                    color: AppColors.secondaryText,
                    fontFamily: FontFamily.tajawalRegular,
                  ),
                ),
              ),
              crossFadeState: _open
                  ? CrossFadeState.showSecond
                  : CrossFadeState.showFirst,
              duration: const Duration(milliseconds: 250),
            ),
          ],
        ),
      ),
    );
  }
}
