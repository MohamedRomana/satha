import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:satha/core/constants/colors.dart';

/// خمس نجوم متحرّكة لاختيار التقييم.
class AnimatedStarRating extends StatelessWidget {
  final int value;
  final ValueChanged<int> onChanged;
  const AnimatedStarRating({
    super.key,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        for (var i = 1; i <= 5; i++)
          GestureDetector(
            onTap: () => onChanged(i),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 6.w),
              child: TweenAnimationBuilder<double>(
                tween: Tween(begin: 1, end: i <= value ? 1.18 : 1),
                duration: const Duration(milliseconds: 250),
                curve: Curves.elasticOut,
                builder: (_, scale, child) =>
                    Transform.scale(scale: scale, child: child),
                child: Icon(
                  i <= value ? Icons.star_rounded : Icons.star_outline_rounded,
                  color: i <= value ? AppColors.warning : AppColors.border,
                  size: 44.w,
                ),
              ),
            ),
          ),
      ],
    );
  }
}
