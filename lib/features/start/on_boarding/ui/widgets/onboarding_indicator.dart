import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:satha/core/constants/colors.dart';

/// مؤشّر صفحات متحرّك — النقطة النشطة تتمدّد بلون برتقالي.
class OnboardingIndicator extends StatelessWidget {
  final int count;
  final int current;
  const OnboardingIndicator({
    super.key,
    required this.count,
    required this.current,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        for (var i = 0; i < count; i++)
          AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeOut,
            width: i == current ? 26.w : 8.w,
            height: 8.w,
            margin: EdgeInsets.symmetric(horizontal: 4.w),
            decoration: BoxDecoration(
              color: i == current
                  ? AppColors.orange
                  : Colors.white.withValues(alpha: 0.3),
              borderRadius: BorderRadius.circular(8.r),
            ),
          ),
      ],
    );
  }
}
