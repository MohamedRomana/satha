import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:satha/core/constants/colors.dart';
import 'package:satha/gen/fonts.gen.dart';

/// مؤشّر خطوات تسجيل السائق المتحرّك (4 خطوات).
class DriverStepsProgress extends StatelessWidget {
  final int currentStep; // 0-based
  final List<String> steps;

  const DriverStepsProgress({
    super.key,
    required this.currentStep,
    required this.steps,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        for (var i = 0; i < steps.length; i++) ...[
          _circle(i),
          if (i < steps.length - 1) Expanded(child: _connector(i)),
        ],
      ],
    );
  }

  Widget _circle(int i) {
    final done = i < currentStep;
    final active = i == currentStep;
    final color = (done || active) ? AppColors.orange : AppColors.border;
    return Column(
      children: [
        AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          width: 30.w,
          height: 30.w,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: done ? AppColors.orange : Colors.white,
            border: Border.all(color: color, width: 1.8),
          ),
          alignment: Alignment.center,
          child: done
              ? Icon(Icons.check_rounded, size: 16.w, color: Colors.white)
              : Text(
                  '${i + 1}',
                  style: TextStyle(
                    fontSize: 13.sp,
                    color: active ? AppColors.orange : AppColors.secondaryText,
                    fontFamily: FontFamily.tajawalBold,
                  ),
                ),
        ),
        SizedBox(height: 4.h),
        SizedBox(
          width: 60.w,
          child: Text(
            steps[i],
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: 9.5.sp,
              color: active ? AppColors.orange : AppColors.secondaryText,
              fontFamily: active
                  ? FontFamily.tajawalBold
                  : FontFamily.tajawalRegular,
            ),
          ),
        ),
      ],
    );
  }

  Widget _connector(int i) {
    final filled = i < currentStep;
    return Padding(
      padding: EdgeInsets.only(bottom: 22.h),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        height: 2.5.h,
        margin: EdgeInsets.symmetric(horizontal: 4.w),
        color: filled ? AppColors.orange : AppColors.border,
      ),
    );
  }
}
