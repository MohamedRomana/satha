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
import '../../features/users/user/create_order/data/models/order_flow_models.dart';
import '../../features/users/user/create_order/ui/create_order_flow.dart';
import '../../features/users/user/create_order/ui/select_order_locations_screen.dart';
import '../../features/users/user/orders/data/models/driver_public_profile_model.dart';
import '../../features/users/user/orders/data/models/order_model.dart';
import '../../features/users/user/orders/ui/customer_live_tracking_screen.dart';
import '../../features/users/user/orders/ui/customer_order_details_screen.dart';
import '../../features/users/user/orders/ui/customer_order_invoice_screen.dart';
import '../../features/users/user/orders/ui/customer_order_offers_screen.dart';
import '../../features/users/user/orders/ui/driver_public_profile_screen.dart';
import '../../features/users/user/orders/ui/order_created_success_screen.dart';
import '../../features/users/user/orders/ui/order_summary_screen.dart';
import '../../features/users/user/orders/ui/rate_driver_screen.dart';
import '../../features/users/user/chats/data/models/chat_model.dart';
import '../../features/users/user/chats/ui/customer_chat_details_screen.dart';
import '../../features/users/user/notifications/ui/customer_notifications_screen.dart';
import '../../features/users/user/profile/ui/change_password_screen.dart';
import '../../features/users/user/profile/ui/customer_settings_screen.dart';
import '../../features/users/user/profile/ui/edit_customer_profile_screen.dart';
import '../../features/users/user/profile/ui/language_screen.dart';
import '../../features/users/user/support/ui/about_us_screen.dart';
import '../../features/users/user/support/ui/contact_us_screen.dart';
import '../../features/users/user/support/ui/faq_screen.dart';
import '../../features/users/user/support/ui/privacy_policy_screen.dart';
import '../../features/users/user/support/ui/report_issue_screen.dart';
import '../../features/users/user/support/ui/support_screen.dart';
import '../../features/users/user/support/ui/terms_conditions_screen.dart';
import '../../generated/locale_keys.g.dart';
import '../di/dependancy_injection.dart';
import '../theme/theme_cubit.dart';
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

      case Routes.createOrderFlow:
        return _route(
          settings,
          CreateOrderFlowScreen(
            initialService: args?['service'] as OrderServiceType?,
          ),
        );

      case Routes.selectOrderLocations:
        return _route(settings, const SelectOrderLocationsScreen());

      case Routes.orderSummary:
        return _route(
          settings,
          OrderSummaryScreen(draft: args!['draft'] as OrderModel),
        );

      case Routes.orderCreatedSuccess:
        return _route(
          settings,
          OrderCreatedSuccessScreen(order: args!['order'] as OrderModel),
        );

      case Routes.orderDetails:
        return _route(
          settings,
          CustomerOrderDetailsScreen(orderId: args!['orderId'] as String),
        );

      case Routes.orderOffers:
        return _route(
          settings,
          CustomerOrderOffersScreen(orderId: args!['orderId'] as String),
        );

      case Routes.driverProfile:
        return _route(
          settings,
          DriverPublicProfileScreen(
            driver: args!['driver'] as DriverPublicProfileModel,
          ),
        );

      case Routes.liveTracking:
        return _route(
          settings,
          CustomerLiveTrackingScreen(order: args!['order'] as OrderModel),
        );

      case Routes.rateDriver:
        return _route(
          settings,
          RateDriverScreen(order: args!['order'] as OrderModel),
        );

      case Routes.orderInvoice:
        return _route(
          settings,
          CustomerOrderInvoiceScreen(order: args!['order'] as OrderModel),
        );

      case Routes.chatDetails:
        return _route(
          settings,
          CustomerChatDetailsScreen(chat: args!['chat'] as ChatModel),
        );

      case Routes.notifications:
        return _route(settings, const CustomerNotificationsScreen());

      case Routes.editProfile:
        return _route(settings, const EditCustomerProfileScreen());

      case Routes.customerSettings:
        return _route(settings, const CustomerSettingsScreen());

      case Routes.changePassword:
        return _route(settings, const ChangePasswordScreen());

      case Routes.language:
        return _route(settings, const LanguageScreen());

      case Routes.aboutUs:
        return _route(settings, const AboutUsScreen());

      case Routes.privacyPolicy:
        return _route(settings, const PrivacyPolicyScreen());

      case Routes.termsConditions:
        return _route(settings, const TermsAndConditionsScreen());

      case Routes.qa:
        return _route(settings, const FaqScreen());

      case Routes.contactUs:
        return _route(settings, const ContactUsScreen());

      case Routes.support:
        return _route(settings, const SupportScreen());

      case Routes.reportIssue:
        return _route(
          settings,
          ReportIssueScreen(orderId: args?['orderId'] as String?),
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
  ///
  /// كل شاشة ملفوفة بـ [BlocBuilder] على [ThemeCubit] مع [KeyedSubtree] مفتاحه
  /// وضع الثيم — فبمجرد تبديل الثيم تُعاد بناء أي شاشة مفتوحة فورًا بألوان الثيم
  /// الجديد (دون فقدان مكدّس التنقّل).
  PageRouteBuilder _route(RouteSettings settings, Widget child) {
    return PageRouteBuilder(
      settings: settings,
      transitionDuration: const Duration(milliseconds: 420),
      reverseTransitionDuration: const Duration(milliseconds: 320),
      pageBuilder: (context, animation, secondaryAnimation) =>
          BlocBuilder<ThemeCubit, ThemeMode>(
            builder: (context, mode) =>
                KeyedSubtree(key: ValueKey(mode), child: child),
          ),
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
