import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:satha/core/constants/colors.dart';
import 'package:satha/core/widgets/primary_button.dart';
import 'package:satha/gen/fonts.gen.dart';

/// Bottom sheet نجاح أنيق مع علامة صح متحرّكة (scale + رسم).
class AnimatedSuccessSheet extends StatefulWidget {
  final String message;
  final String buttonText;
  final VoidCallback onButtonPressed;

  const AnimatedSuccessSheet({
    super.key,
    required this.message,
    required this.buttonText,
    required this.onButtonPressed,
  });

  /// عرض الـ sheet بشكل غير قابل للإلغاء بالسحب.
  static Future<void> show(
    BuildContext context, {
    required String message,
    required String buttonText,
    required VoidCallback onButtonPressed,
  }) {
    return showModalBottomSheet(
      context: context,
      isDismissible: false,
      enableDrag: false,
      backgroundColor: Colors.transparent,
      builder: (_) => AnimatedSuccessSheet(
        message: message,
        buttonText: buttonText,
        onButtonPressed: onButtonPressed,
      ),
    );
  }

  @override
  State<AnimatedSuccessSheet> createState() => _AnimatedSuccessSheetState();
}

class _AnimatedSuccessSheetState extends State<AnimatedSuccessSheet>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 900),
  )..forward();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.fromLTRB(24.w, 28.h, 24.w, 32.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(32.r)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          AnimatedBuilder(
            animation: _controller,
            builder: (context, _) {
              final scale = Curves.elasticOut.transform(
                _controller.value.clamp(0, 1),
              );
              return Transform.scale(
                scale: scale,
                child: Container(
                  width: 92.w,
                  height: 92.w,
                  decoration: BoxDecoration(
                    color: AppColors.success.withValues(alpha: 0.12),
                    shape: BoxShape.circle,
                  ),
                  child: CustomPaint(
                    painter: _CheckPainter(_controller.value),
                  ),
                ),
              );
            },
          ),
          SizedBox(height: 20.h),
          Text(
            widget.message,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 17.sp,
              color: AppColors.mainText,
              fontFamily: FontFamily.tajawalBold,
            ),
          ),
          SizedBox(height: 24.h),
          PrimaryButton(
            text: widget.buttonText,
            onPressed: widget.onButtonPressed,
          ),
        ],
      ),
    );
  }
}

/// يرسم علامة الصح تدريجيًا.
class _CheckPainter extends CustomPainter {
  final double progress;
  _CheckPainter(this.progress);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = AppColors.success
      ..strokeWidth = 5
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round
      ..style = PaintingStyle.stroke;

    final w = size.width, h = size.height;
    final p1 = Offset(w * 0.28, h * 0.52);
    final p2 = Offset(w * 0.44, h * 0.66);
    final p3 = Offset(w * 0.72, h * 0.36);

    final t = ((progress - 0.3) / 0.7).clamp(0.0, 1.0);
    final path = Path()..moveTo(p1.dx, p1.dy);
    if (t <= 0.5) {
      final f = t / 0.5;
      path.lineTo(p1.dx + (p2.dx - p1.dx) * f, p1.dy + (p2.dy - p1.dy) * f);
    } else {
      path.lineTo(p2.dx, p2.dy);
      final f = (t - 0.5) / 0.5;
      path.lineTo(p2.dx + (p3.dx - p2.dx) * f, p2.dy + (p3.dy - p2.dy) * f);
    }
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(_CheckPainter oldDelegate) =>
      oldDelegate.progress != progress;
}
