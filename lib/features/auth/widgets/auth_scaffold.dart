import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:satha/core/widgets/app_logo.dart';
import 'package:satha/core/widgets/auth_background.dart';
import 'package:satha/core/widgets/fade_slide_in.dart';
import 'package:satha/core/widgets/lang_toggle.dart';
import 'package:satha/gen/fonts.gen.dart';

/// هيكل موحّد لكل شاشات المصادقة:
/// خلفية navy متحرّكة + شعار + عنوان + وصف + بطاقة بيضاء قابلة للتمرير
/// (آمنة للكيبورد). كل العناصر تدخل بأنميشن متدرّج.
class AuthScaffold extends StatelessWidget {
  final String title;
  final String? subtitle;
  final Widget child;
  final VoidCallback? onBack;
  final bool showLangToggle;
  final double logoSize;

  const AuthScaffold({
    super.key,
    required this.title,
    required this.child,
    this.subtitle,
    this.onBack,
    this.showLangToggle = true,
    this.logoSize = 76,
  });

  @override
  Widget build(BuildContext context) {
    final isRtl = Directionality.of(context) == TextDirection.rtl;
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: AnimatedAuthBackground(
        child: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    if (onBack != null)
                      _CircleIconButton(
                        icon: Icons.arrow_back_ios_new_rounded,
                        flip: isRtl,
                        onTap: onBack!,
                      )
                    else
                      const SizedBox(width: 40),
                    if (showLangToggle)
                      const LangToggle()
                    else
                      const SizedBox(width: 40),
                  ],
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  padding: EdgeInsets.fromLTRB(20.w, 8.h, 20.w, 24.h),
                  child: Column(
                    children: [
                      FadeSlideIn(
                        from: SlideFrom.top,
                        child: AnimatedAppLogo(size: logoSize.w, glow: true),
                      ),
                      SizedBox(height: 14.h),
                      FadeSlideIn(
                        delay: const Duration(milliseconds: 120),
                        child: Text(
                          title,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 22.sp,
                            fontFamily: FontFamily.tajawalBold,
                          ),
                        ),
                      ),
                      if (subtitle != null) ...[
                        SizedBox(height: 8.h),
                        FadeSlideIn(
                          delay: const Duration(milliseconds: 200),
                          child: Text(
                            subtitle!,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white.withValues(alpha: 0.75),
                              fontSize: 13.sp,
                              height: 1.5,
                              fontFamily: FontFamily.tajawalRegular,
                            ),
                          ),
                        ),
                      ],
                      SizedBox(height: 24.h),
                      FadeSlideIn(
                        delay: const Duration(milliseconds: 280),
                        from: SlideFrom.bottom,
                        offset: 40,
                        child: Container(
                          width: double.infinity,
                          padding: EdgeInsets.all(20.w),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(28.r),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withValues(alpha: 0.18),
                                blurRadius: 30,
                                offset: const Offset(0, 12),
                              ),
                            ],
                          ),
                          child: child,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _CircleIconButton extends StatelessWidget {
  final IconData icon;
  final bool flip;
  final VoidCallback onTap;
  const _CircleIconButton({
    required this.icon,
    required this.onTap,
    this.flip = false,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(40.r),
      child: Container(
        width: 40.w,
        height: 40.w,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.12),
          shape: BoxShape.circle,
          border: Border.all(color: Colors.white.withValues(alpha: 0.2)),
        ),
        child: Transform.flip(
          flipX: flip,
          child: Icon(icon, color: Colors.white, size: 16.w),
        ),
      ),
    );
  }
}
