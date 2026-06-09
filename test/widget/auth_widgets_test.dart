import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:satha/core/cache/cache_helper.dart';
import 'package:satha/core/routing/routes.dart';
import 'package:satha/core/widgets/app_logo.dart';
import 'package:satha/features/auth/data/apis/auth_api_service.dart';
import 'package:satha/features/auth/data/datasources/mock_auth_data_source.dart';
import 'package:satha/features/auth/data/models/user_role.dart';
import 'package:satha/features/auth/data/repos/auth_repo.dart';
import 'package:satha/features/auth/logic/login/login_cubit.dart';
import 'package:satha/features/auth/ui/admin_login_screen.dart';
import 'package:satha/features/auth/ui/login_screen.dart';
import 'package:satha/features/auth/ui/widgets/otp_input.dart';
import 'package:satha/features/onboarding/ui/onboarding_screen.dart';
import 'package:satha/features/role_selection/ui/role_selection_screen.dart';
import 'package:satha/features/role_selection/ui/widgets/role_selection_card.dart';
import 'package:satha/features/splash/ui/splash_screen.dart';
import 'package:satha/generated/locale_keys.g.dart';

import '../helpers/test_helpers.dart';

AuthRepo _repo() => AuthRepo(AuthApiService(Dio()), MockAuthDataSource());

void main() {
  setUpAll(() async {
    TestWidgetsFlutterBinding.ensureInitialized();
    SharedPreferences.setMockInitialValues({});
    await EasyLocalization.ensureInitialized();
    await CacheHelper.init();
  });

  testWidgets('Splash يعرض الشعار', (tester) async {
    await pumpApp(tester, const SplashScreen());
    expect(find.byType(AppLogo), findsOneWidget);
  });

  testWidgets('شاشة اختيار الدور تعرض بطاقتين', (tester) async {
    await pumpApp(tester, const RoleSelectionScreen());
    expect(find.byType(RoleSelectionCard), findsNWidgets(2));
  });

  testWidgets('دخول العميل: التحقق يعمل عند الحقول الفارغة', (tester) async {
    await pumpApp(
      tester,
      BlocProvider(
        create: (_) => LoginCubit(_repo(), role: UserRole.customer),
        child: const LoginScreen(
          title: LocaleKeys.welcome_back,
          subtitle: LocaleKeys.customerLoginDesc,
          successRoute: Routes.customerHome,
          registerRoute: Routes.customerRegister,
        ),
      ),
    );
    final loginBtn = find.text(LocaleKeys.loginTitle.tr());
    expect(loginBtn, findsOneWidget);
    await tester.ensureVisible(loginBtn);
    await tester.tap(loginBtn);
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 100));
    expect(find.text(LocaleKeys.phoneOrEmailValidate.tr()), findsOneWidget);
  });

  testWidgets('دخول الإدارة يُعرض بحقلين', (tester) async {
    await pumpApp(
      tester,
      BlocProvider(
        create: (_) => LoginCubit(_repo(), role: UserRole.admin),
        child: const AdminLoginScreen(),
      ),
    );
    expect(find.byType(TextFormField), findsNWidgets(2));
    expect(find.text(LocaleKeys.adminLogin.tr()), findsWidgets);
  });

  testWidgets('الأونبوردنق ينتقل للصفحة الثانية', (tester) async {
    await pumpApp(tester, const OnboardingScreen());
    expect(find.text(LocaleKeys.onboarding1Title.tr()), findsOneWidget);
    final nextBtn = find.text(LocaleKeys.next.tr());
    await tester.ensureVisible(nextBtn);
    await tester.tap(nextBtn);
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 600));
    expect(find.text(LocaleKeys.onboarding2Title.tr()), findsOneWidget);
  });

  testWidgets('حقل OTP يقبل 6 خانات', (tester) async {
    final controller = TextEditingController();
    await pumpApp(
      tester,
      Scaffold(body: Center(child: SathaOtpInput(controller: controller))),
    );
    expect(find.byType(PinCodeTextField), findsOneWidget);
    await tester.enterText(find.byType(EditableText).first, '123456');
    await tester.pump();
    expect(controller.text, '123456');
  });
}
