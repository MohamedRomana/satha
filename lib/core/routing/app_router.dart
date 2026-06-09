import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../features/auth/data/models/app_user.dart';
import '../../features/auth/data/models/user_role.dart';
import '../../features/auth/logic/customer_register/customer_register_cubit.dart';
import '../../features/auth/logic/driver_register/driver_register_cubit.dart';
import '../../features/auth/logic/forgot_password/forgot_password_cubit.dart';
import '../../features/auth/logic/login/login_cubit.dart';
import '../../features/auth/logic/otp/otp_cubit.dart';
import '../../features/auth/logic/reset_password/reset_password_cubit.dart';
import '../../features/auth/ui/admin_login_screen.dart';
import '../../features/auth/ui/customer_register_screen.dart';
import '../../features/auth/ui/driver_register_pending_screen.dart';
import '../../features/auth/ui/driver_register_screen.dart';
import '../../features/auth/ui/forgot_password_screen.dart';
import '../../features/auth/ui/login_screen.dart';
import '../../features/auth/ui/otp_verification_screen.dart';
import '../../features/auth/ui/reset_password_screen.dart';
import '../../features/onboarding/ui/onboarding_screen.dart';
import '../../features/role_selection/ui/role_selection_screen.dart';
import '../../features/splash/ui/splash_screen.dart';
import '../../features/temporary_home/ui/admin_temporary_home_screen.dart';
import '../../features/temporary_home/ui/customer_temporary_home_screen.dart';
import '../../features/temporary_home/ui/driver_temporary_home_screen.dart';
import '../../generated/locale_keys.g.dart';
import '../di/dependancy_injection.dart';
import 'routes.dart';

/// راوتر مركزي واحد — يحقن الـ Cubit المناسب من [getIt] لكل شاشة.
class AppRouter {
  Route? onGenerateRoute(RouteSettings settings) {
    final args = settings.arguments as Map<String, dynamic>?;

    switch (settings.name) {
      case Routes.splash:
        return _route(settings, const SplashScreen());

      case Routes.onBoarding:
        return _route(settings, const OnboardingScreen());

      case Routes.roleSelection:
        return _route(settings, const RoleSelectionScreen());

      case Routes.customerLogin:
        return _route(
          settings,
          BlocProvider(
            create: (_) => LoginCubit(getIt(), role: UserRole.customer),
            child: const LoginScreen(
              title: LocaleKeys.welcome_back,
              subtitle: LocaleKeys.customerLoginDesc,
              successRoute: Routes.customerHome,
              registerRoute: Routes.customerRegister,
            ),
          ),
        );

      case Routes.customerRegister:
        return _route(
          settings,
          BlocProvider(
            create: (_) => CustomerRegisterCubit(getIt()),
            child: const CustomerRegisterScreen(),
          ),
        );

      case Routes.driverLogin:
        return _route(
          settings,
          BlocProvider(
            create: (_) => LoginCubit(getIt(), role: UserRole.driver),
            child: const LoginScreen(
              title: LocaleKeys.welcome_back,
              subtitle: LocaleKeys.driverLoginDesc,
              successRoute: Routes.driverHome,
              registerRoute: Routes.driverRegister,
            ),
          ),
        );

      case Routes.driverRegister:
        return _route(
          settings,
          BlocProvider(
            create: (_) => DriverRegisterCubit(getIt()),
            child: const DriverRegisterScreen(),
          ),
        );

      case Routes.driverRegisterPending:
        return _route(settings, const DriverRegisterPendingScreen());

      case Routes.adminLogin:
        return _route(
          settings,
          BlocProvider(
            create: (_) => LoginCubit(getIt(), role: UserRole.admin),
            child: const AdminLoginScreen(),
          ),
        );

      case Routes.forgotPassword:
        final role = UserRoleX.fromKey(args?['role'] as String?);
        return _route(
          settings,
          BlocProvider(
            create: (_) => ForgotPasswordCubit(getIt(), role: role),
            child: const ForgotPasswordScreen(),
          ),
        );

      case Routes.otpVerification:
        return _route(
          settings,
          BlocProvider(
            create: (_) => OtpCubit(
              getIt(),
              identifier: args?['identifier'] as String? ?? '',
              purpose: args?['purpose'] as OtpPurpose? ?? OtpPurpose.reset,
              user: args?['user'] as AppUser?,
            ),
            child: OtpVerificationScreen(
              role: args?['role'] as String? ?? 'customer',
            ),
          ),
        );

      case Routes.resetPassword:
        return _route(
          settings,
          BlocProvider(
            create: (_) => ResetPasswordCubit(
              getIt(),
              identifier: args?['identifier'] as String? ?? '',
              code: args?['code'] as String? ?? '',
            ),
            child: ResetPasswordScreen(
              role: args?['role'] as String? ?? 'customer',
            ),
          ),
        );

      case Routes.customerHome:
        return _route(settings, const CustomerTemporaryHomeScreen());

      case Routes.driverHome:
        return _route(settings, const DriverTemporaryHomeScreen());

      case Routes.adminHome:
        return _route(settings, const AdminTemporaryHomeScreen());

      default:
        return _route(settings, const SplashScreen());
    }
  }

  /// انتقال موحّد بـ fade + slide خفيف لكل الشاشات (مع الحفاظ على الـ name).
  PageRouteBuilder _route(RouteSettings settings, Widget child) {
    return PageRouteBuilder(
      settings: settings,
      transitionDuration: const Duration(milliseconds: 420),
      reverseTransitionDuration: const Duration(milliseconds: 320),
      pageBuilder: (context, animation, secondaryAnimation) => child,
      transitionsBuilder: (context, animation, secondaryAnimation, c) {
        final curved = CurvedAnimation(
          parent: animation,
          curve: Curves.easeOutCubic,
          reverseCurve: Curves.easeInCubic,
        );
        return FadeTransition(
          opacity: curved,
          child: SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(0, 0.05),
              end: Offset.zero,
            ).animate(curved),
            child: c,
          ),
        );
      },
    );
  }
}
