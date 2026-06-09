import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/constants/colors.dart';
import '../../../../core/constants/gradients.dart';
import '../../../../core/di/dependancy_injection.dart';
import '../../../../core/helper/extentions.dart';
import '../../../../core/routing/routes.dart';
import '../../../../core/widgets/app_logo.dart';
import '../../../../core/widgets/fade_slide_in.dart';
import '../../../../core/widgets/primary_button.dart';
import '../../../../gen/fonts.gen.dart';
import '../../../../generated/locale_keys.g.dart';
import '../../../auth/data/auth_session.dart';
import '../../../auth/data/models/user_role.dart';
import '../../../auth/data/repos/auth_repo.dart';

/// واجهة مؤقتة موحّدة بعد تسجيل الدخول — تُنفّذ الوحدات الفعلية لاحقًا.
/// تتضمّن حارس دور: لو الدور المخزّن لا يطابق [role] تُعيد للاختيار.
class TemporaryHomeView extends StatelessWidget {
  final UserRole role;
  final String title;
  final String message;
  final String subMessage;
  final IconData icon;

  const TemporaryHomeView({
    super.key,
    required this.role,
    required this.title,
    required this.message,
    required this.subMessage,
    required this.icon,
  });

  Future<void> _logout(BuildContext context) async {
    await getIt<AuthRepo>().logout();
    await AuthSession.clear();
    if (context.mounted) {
      context.pushNamedAndRemoveUntil(
        Routes.roleSelection,
        predicate: (_) => false,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    // حارس الدور: امنع وصول دور لشاشة دور آخر.
    if (!AuthSession.isLoggedIn || AuthSession.role != role) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (context.mounted) {
          context.pushNamedAndRemoveUntil(
            Routes.roleSelection,
            predicate: (_) => false,
          );
        }
      });
      return const Scaffold(
        body: Center(child: CircularProgressIndicator(color: AppColors.orange)),
      );
    }

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(gradient: AppGradients.deep),
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w),
            child: Column(
              children: [
                SizedBox(height: 16.h),
                const AnimatedAppLogo(size: 90, glow: true),
                const Spacer(),
                FadeSlideIn(
                  child: Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(26.w),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(28.r),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.2),
                          blurRadius: 30,
                          offset: const Offset(0, 12),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        Container(
                          width: 76.w,
                          height: 76.w,
                          decoration: const BoxDecoration(
                            gradient: AppGradients.orange,
                            shape: BoxShape.circle,
                          ),
                          child: Icon(icon, color: Colors.white, size: 38.w),
                        ),
                        SizedBox(height: 18.h),
                        Text(
                          title,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 20.sp,
                            color: AppColors.mainText,
                            fontFamily: FontFamily.tajawalBold,
                          ),
                        ),
                        SizedBox(height: 10.h),
                        Text(
                          message,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 14.sp,
                            color: AppColors.success,
                            fontFamily: FontFamily.tajawalBold,
                          ),
                        ),
                        SizedBox(height: 8.h),
                        Text(
                          subMessage,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 13.sp,
                            color: AppColors.secondaryText,
                            height: 1.6,
                            fontFamily: FontFamily.tajawalRegular,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const Spacer(),
                PrimaryButton(
                  text: LocaleKeys.logout.tr(),
                  icon: Icons.logout_rounded,
                  gradient: AppGradients.primary,
                  onPressed: () => _logout(context),
                ),
                SizedBox(height: 24.h),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
