import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../features/auth/data/models/app_user.dart';
import '../../features/auth/data/models/user_role.dart';
import '../../features/auth/customer_register/logic/customer_register_cubit.dart';
import '../../features/auth/customer_register/ui/customer_register.dart';
import '../../features/auth/driver_register/logic/driver_register_cubit.dart';
import '../../features/auth/driver_register/ui/driver_register.dart';
import '../../features/auth/driver_register_pending/ui/driver_register_pending.dart';
import '../../features/auth/forgot_password/logic/forgot_password_cubit.dart';
import '../../features/auth/forgot_password/ui/forgot_password.dart';
import '../../features/auth/login/logic/login_cubit.dart';
import '../../features/auth/login/ui/login.dart';
import '../../features/auth/otp/logic/otp_cubit.dart';
import '../../features/auth/otp/ui/otp_verification.dart';
import '../../features/auth/reset_password/logic/reset_password_cubit.dart';
import '../../features/auth/reset_password/ui/reset_password.dart';
import '../../features/auth/admin_login/ui/admin_login.dart';
import '../../features/start/on_boarding/ui/on_boarding.dart';
import '../../features/start/role_selection/ui/role_selection.dart';
import '../../features/start/splash/ui/splash.dart';
import '../../features/users/admin/home/ui/admin_temporary_home.dart';
import '../../features/users/provider/home/ui/driver_temporary_home.dart';
import '../../features/users/user/main_layout/ui/customer_main_layout.dart';
import '../../features/users/user/vehicles/data/models/vehicle_model.dart';
import '../../features/users/user/vehicles/ui/add_vehicle_screen.dart';
import '../../features/users/user/vehicles/ui/edit_vehicle_screen.dart';
import '../../features/users/user/vehicles/ui/vehicle_details_screen.dart';
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
        return _route(settings, const CustomerMainLayout());

      case Routes.vehicleDetails:
        return _route(
          settings,
          VehicleDetailsScreen(vehicle: args!['vehicle'] as VehicleModel),
        );

      case Routes.addVehicle:
        return _route(settings, const AddVehicleScreen());

      case Routes.editVehicle:
        return _route(
          settings,
          EditVehicleScreen(vehicle: args!['vehicle'] as VehicleModel),
        );

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
