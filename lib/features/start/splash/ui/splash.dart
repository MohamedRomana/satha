import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:satha/core/cache/cache_helper.dart';
import 'package:satha/core/constants/colors.dart';
import 'package:satha/core/constants/gradients.dart';
import 'package:satha/core/di/dependancy_injection.dart';
import 'package:satha/core/helper/extentions.dart';
import 'package:satha/core/helper/theme_x.dart';
import 'package:satha/core/routing/routes.dart';
import 'package:satha/core/widgets/app_logo.dart';
import 'package:satha/gen/fonts.gen.dart';
import 'package:satha/generated/locale_keys.g.dart';
import 'package:satha/features/auth/data/auth_session.dart';
import 'package:satha/features/auth/data/models/user_role.dart';
import 'package:satha/features/users/user/create_order/data/services/location_permission_service.dart';

/// شاشة البداية المتحرّكة — تجهّز التطبيق ثم توجّه للوجهة المناسبة.
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 2800),
  );

  // مراحل الأنميشن.
  late final Animation<double> _line = CurvedAnimation(
    parent: _controller,
    curve: const Interval(0.30, 0.62, curve: Curves.easeInOut),
  );
  late final Animation<double> _light = CurvedAnimation(
    parent: _controller,
    curve: const Interval(0.55, 0.95, curve: Curves.easeInOut),
  );
  late final Animation<double> _loader = CurvedAnimation(
    parent: _controller,
    curve: const Interval(0.72, 1.0, curve: Curves.easeIn),
  );

  @override
  void initState() {
    super.initState();
    _controller.forward();
    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        Future.delayed(const Duration(milliseconds: 300), _goNext);
      }
    });
    // طلب إذن الموقع أول ما يفتح التطبيق (بعد أول frame).
    WidgetsBinding.instance.addPostFrameCallback((_) => _requestLocation());
  }

  Future<void> _requestLocation() async {
    try {
      await getIt<LocationPermissionService>().ensurePermission();
    } catch (_) {
      // في بيئة الاختبار لا يتوفّر geolocator — نتجاهل بهدوء.
    }
  }

  void _goNext() {
    if (!mounted) return;
    if (!CacheHelper.getShowIntro()) {
      context.pushReplacementNamed(Routes.onBoarding);
      return;
    }
    if (!AuthSession.isLoggedIn) {
      context.pushReplacementNamed(Routes.roleSelection);
      return;
    }
    switch (AuthSession.role) {
      case UserRole.driver:
        context.pushReplacementNamed(Routes.driverHome);
        break;
      case UserRole.admin:
        context.pushReplacementNamed(Routes.adminHome);
        break;
      case UserRole.customer:
        context.pushReplacementNamed(Routes.customerHome);
        break;
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final lineWidth = 180.w;
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(gradient: context.brandGradient),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(),
              const AnimatedAppLogo(size: 140, glow: true),
              SizedBox(height: 28.h),
              // خط الطريق + النبضة المتحرّكة.
              AnimatedBuilder(
                animation: _controller,
                builder: (context, _) {
                  return SizedBox(
                    width: lineWidth,
                    height: 14.h,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Align(
                          alignment: AlignmentDirectional.centerStart,
                          child: Container(
                            width: lineWidth * _line.value,
                            height: 3.h,
                            decoration: BoxDecoration(
                              gradient: AppGradients.orange,
                              borderRadius: BorderRadius.circular(4.r),
                            ),
                          ),
                        ),
                        if (_light.value > 0)
                          PositionedDirectional(
                            start: (lineWidth - 12.w) * _light.value,
                            child: Container(
                              width: 12.w,
                              height: 12.w,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: AppColors.orange2,
                                boxShadow: [
                                  BoxShadow(
                                    color: AppColors.orange.withValues(
                                      alpha: 0.8,
                                    ),
                                    blurRadius: 14,
                                    spreadRadius: 2,
                                  ),
                                ],
                              ),
                            ),
                          ),
                      ],
                    ),
                  );
                },
              ),
              const Spacer(),
              FadeTransition(
                opacity: _loader,
                child: Column(
                  children: [
                    SizedBox(
                      width: 26.w,
                      height: 26.w,
                      child: const CircularProgressIndicator(
                        strokeWidth: 2.4,
                        color: AppColors.orange,
                      ),
                    ),
                    SizedBox(height: 14.h),
                    Text(
                      LocaleKeys.splashLoading.tr(),
                      style: TextStyle(
                        color: context.onBrandMuted,
                        fontSize: 13.sp,
                        fontFamily: FontFamily.tajawalRegular,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 40.h),
            ],
          ),
        ),
      ),
    );
  }
}
