import 'dart:math' as math;

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/constants/colors.dart';
import '../../../../core/constants/gradients.dart';
import '../../../../gen/fonts.gen.dart';
import '../../../../generated/locale_keys.g.dart';

/// المشهد 1: سطحة تتحرّك على الطريق نحو دبوس الموقع.
class RescueScene extends StatefulWidget {
  const RescueScene({super.key});
  @override
  State<RescueScene> createState() => _RescueSceneState();
}

class _RescueSceneState extends State<RescueScene>
    with SingleTickerProviderStateMixin {
  late final AnimationController _c = AnimationController(
    vsync: this,
    duration: const Duration(seconds: 3),
  )..repeat();

  @override
  void dispose() {
    _c.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _SceneBox(
      child: AnimatedBuilder(
        animation: _c,
        builder: (context, _) {
          final drive = Curves.easeInOut.transform(_c.value);
          final bounce = math.sin(_c.value * 2 * math.pi).abs();
          return Stack(
            alignment: Alignment.center,
            children: [
              // دبوس الموقع.
              PositionedDirectional(
                end: 24.w,
                top: 30.h - (bounce * 8),
                child: Icon(
                  Icons.location_on_rounded,
                  color: AppColors.orange,
                  size: 48.w,
                ),
              ),
              // الطريق.
              PositionedDirectional(
                bottom: 40.h,
                start: 0,
                end: 0,
                child: Container(
                  height: 10.h,
                  decoration: BoxDecoration(
                    color: AppColors.navy2,
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                ),
              ),
              // السطحة المتحرّكة.
              PositionedDirectional(
                bottom: 46.h,
                start: 10.w + (drive * 150.w),
                child: Icon(
                  Icons.local_shipping_rounded,
                  color: Colors.white,
                  size: 46.w,
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

/// المشهد 2: بطاقتا نوع السطحة مع أنميشن اختيار متبادل.
class ChooseServiceScene extends StatefulWidget {
  const ChooseServiceScene({super.key});
  @override
  State<ChooseServiceScene> createState() => _ChooseServiceSceneState();
}

class _ChooseServiceSceneState extends State<ChooseServiceScene>
    with SingleTickerProviderStateMixin {
  late final AnimationController _c = AnimationController(
    vsync: this,
    duration: const Duration(seconds: 3),
  )..repeat();

  @override
  void dispose() {
    _c.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _SceneBox(
      child: AnimatedBuilder(
        animation: _c,
        builder: (context, _) {
          final firstSelected = _c.value < 0.5;
          return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _typeCard(Icons.local_shipping_rounded,
                  LocaleKeys.normalTow.tr(), firstSelected),
              SizedBox(width: 16.w),
              _typeCard(Icons.precision_manufacturing_rounded,
                  LocaleKeys.hydraulicTow.tr(), !firstSelected),
            ],
          );
        },
      ),
    );
  }

  Widget _typeCard(IconData icon, String label, bool selected) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeOut,
      width: 110.w,
      padding: EdgeInsets.symmetric(vertical: 18.h),
      transform: Matrix4.diagonal3Values(
        selected ? 1.05 : 0.95,
        selected ? 1.05 : 0.95,
        1,
      ),
      transformAlignment: Alignment.center,
      decoration: BoxDecoration(
        gradient: selected ? AppGradients.orange : null,
        color: selected ? null : Colors.white.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(
          color: selected
              ? Colors.transparent
              : Colors.white.withValues(alpha: 0.25),
        ),
      ),
      child: Column(
        children: [
          Icon(icon, color: Colors.white, size: 38.w),
          SizedBox(height: 10.h),
          Text(
            label,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontSize: 12.sp,
              fontFamily: FontFamily.tajawalBold,
            ),
          ),
        ],
      ),
    );
  }
}

/// المشهد 3: مسار خريطة + علامة سائق متحرّكة + بطاقة إشعار.
class TrackScene extends StatefulWidget {
  const TrackScene({super.key});
  @override
  State<TrackScene> createState() => _TrackSceneState();
}

class _TrackSceneState extends State<TrackScene>
    with SingleTickerProviderStateMixin {
  late final AnimationController _c = AnimationController(
    vsync: this,
    duration: const Duration(seconds: 3),
  )..repeat();

  @override
  void dispose() {
    _c.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _SceneBox(
      child: AnimatedBuilder(
        animation: _c,
        builder: (context, _) {
          final t = Curves.easeInOut.transform(_c.value);
          return Stack(
            children: [
              Positioned.fill(
                child: CustomPaint(painter: _RoutePainter(t)),
              ),
              if (t > 0.15)
                Opacity(
                  opacity: ((t - 0.15) / 0.4).clamp(0.0, 1.0),
                  child: Align(
                    alignment: AlignmentDirectional.topStart,
                    child: Container(
                      margin: EdgeInsets.all(8.w),
                      padding: EdgeInsets.symmetric(
                        horizontal: 12.w,
                        vertical: 8.h,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(14.r),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.notifications_active_rounded,
                              color: AppColors.orange, size: 18.w),
                          SizedBox(width: 8.w),
                          Text(
                            LocaleKeys.in_way.tr(),
                            style: TextStyle(
                              fontSize: 11.sp,
                              color: AppColors.mainText,
                              fontFamily: FontFamily.tajawalBold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
            ],
          );
        },
      ),
    );
  }
}

class _RoutePainter extends CustomPainter {
  final double progress;
  _RoutePainter(this.progress);

  @override
  void paint(Canvas canvas, Size size) {
    final path = Path()
      ..moveTo(size.width * 0.15, size.height * 0.85)
      ..quadraticBezierTo(
        size.width * 0.5, size.height * 0.95,
        size.width * 0.55, size.height * 0.5,
      )
      ..quadraticBezierTo(
        size.width * 0.6, size.height * 0.1,
        size.width * 0.88, size.height * 0.2,
      );

    final dash = Paint()
      ..color = AppColors.orange.withValues(alpha: 0.6)
      ..strokeWidth = 3.5
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;
    canvas.drawPath(path, dash);

    final metric = path.computeMetrics().first;
    // نقطة البداية.
    final start = metric.getTangentForOffset(0)!.position;
    canvas.drawCircle(
      start,
      6,
      Paint()..color = AppColors.success,
    );
    // علامة السائق المتحرّكة.
    final pos = metric.getTangentForOffset(metric.length * progress)!.position;
    canvas.drawCircle(
      pos,
      9,
      Paint()..color = AppColors.orange,
    );
    canvas.drawCircle(
      pos,
      4,
      Paint()..color = Colors.white,
    );
  }

  @override
  bool shouldRepaint(_RoutePainter oldDelegate) =>
      oldDelegate.progress != progress;
}

/// إطار موحّد للمشاهد فوق دائرة توهّج ناعمة.
class _SceneBox extends StatelessWidget {
  final Widget child;
  const _SceneBox({required this.child});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 240.h,
      width: double.infinity,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            width: 220.w,
            height: 220.w,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: RadialGradient(
                colors: [
                  AppColors.orange.withValues(alpha: 0.16),
                  AppColors.orange.withValues(alpha: 0),
                ],
              ),
            ),
          ),
          Padding(padding: EdgeInsets.all(20.w), child: child),
        ],
      ),
    );
  }
}
