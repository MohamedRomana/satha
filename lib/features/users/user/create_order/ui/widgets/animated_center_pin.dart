import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:satha/core/constants/colors.dart';

/// دبوس مركز الخريطة المتحرّك (يرتفع قليلاً مع ظل أسفله).
class AnimatedCenterPin extends StatefulWidget {
  final Color color;
  const AnimatedCenterPin({super.key, this.color = AppColors.orange});

  @override
  State<AnimatedCenterPin> createState() => _AnimatedCenterPinState();
}

class _AnimatedCenterPinState extends State<AnimatedCenterPin>
    with SingleTickerProviderStateMixin {
  late final AnimationController _c = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 1100),
  )..repeat(reverse: true);

  @override
  void dispose() {
    _c.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // إزاحة عمودية لرفع رأس الدبوس فوق المركز الفعلي.
    return IgnorePointer(
      child: Padding(
        padding: EdgeInsets.only(bottom: 44.h),
        child: AnimatedBuilder(
          animation: _c,
          builder: (context, child) {
            final lift = _c.value * 6.h;
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Transform.translate(
                  offset: Offset(0, -lift),
                  child: Icon(
                    Icons.location_on,
                    color: widget.color,
                    size: 44.w,
                  ),
                ),
                Container(
                  width: 8.w,
                  height: 4.h,
                  decoration: BoxDecoration(
                    color: Colors.black.withValues(alpha: 0.25 - _c.value * 0.1),
                    borderRadius: BorderRadius.circular(4.r),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
