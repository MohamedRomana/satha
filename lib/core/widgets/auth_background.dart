import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../constants/colors.dart';
import '../helper/theme_x.dart';

/// خلفية متحرّكة بهوية سطحة: تدرّج navy + توهّجات برتقالية ناعمة تتحرّك ببطء
/// + خطوط طريق متقطّعة — حركة خفيفة لا تشتّت المحتوى.
class AnimatedAuthBackground extends StatefulWidget {
  final Widget child;
  const AnimatedAuthBackground({super.key, required this.child});

  @override
  State<AnimatedAuthBackground> createState() => _AnimatedAuthBackgroundState();
}

class _AnimatedAuthBackgroundState extends State<AnimatedAuthBackground>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: const Duration(seconds: 8),
  )..repeat();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final dark = context.isDark;
    return DecoratedBox(
      decoration: BoxDecoration(gradient: context.brandGradient),
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          final t = _controller.value;
          return Stack(
            children: [
              Positioned(
                top: -60 + (20 * math.sin(t * 2 * math.pi)),
                right: -40,
                child: _glow(220, AppColors.orange.withValues(alpha: 0.18)),
              ),
              Positioned(
                bottom: -80 - (20 * math.sin(t * 2 * math.pi)),
                left: -50,
                child: _glow(
                  260,
                  dark
                      ? AppColors.navy2.withValues(alpha: 0.55)
                      : AppColors.orange2.withValues(alpha: 0.18),
                ),
              ),
              Positioned.fill(
                child: CustomPaint(painter: _RoadDashesPainter(t)),
              ),
              child!,
            ],
          );
        },
        child: widget.child,
      ),
    );
  }

  Widget _glow(double size, Color color) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: RadialGradient(colors: [color, color.withValues(alpha: 0)]),
      ),
    );
  }
}

/// خطوط طريق متقطّعة تتحرّك أفقيًا — لمسة automotive خفيفة.
class _RoadDashesPainter extends CustomPainter {
  final double progress;
  _RoadDashesPainter(this.progress);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = AppColors.orange.withValues(alpha: 0.06)
      ..strokeWidth = 3
      ..strokeCap = StrokeCap.round;

    const dashWidth = 26.0;
    const gap = 22.0;
    const period = dashWidth + gap;
    final y = size.height * 0.42;
    final shift = progress * period;

    for (double x = -period + shift; x < size.width; x += period) {
      canvas.drawLine(Offset(x, y), Offset(x + dashWidth, y), paint);
    }
  }

  @override
  bool shouldRepaint(_RoadDashesPainter oldDelegate) =>
      oldDelegate.progress != progress;
}
