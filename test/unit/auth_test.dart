import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:satha/core/cache/cache_helper.dart';
import 'package:satha/core/networking/api_result.dart';
import 'package:satha/features/auth/data/auth_session.dart';
import 'package:satha/features/auth/data/datasources/mock_auth_data_source.dart';
import 'package:satha/features/auth/data/models/app_user.dart';
import 'package:satha/features/auth/data/models/auth_request_models.dart';
import 'package:satha/features/auth/data/models/user_role.dart';
import 'package:satha/features/auth/data/apis/auth_api_service.dart';
import 'package:satha/features/auth/data/repos/auth_repo.dart';
import 'package:satha/features/auth/driver_register/logic/driver_register_cubit.dart';
import 'package:satha/features/start/on_boarding/logic/onboarding_cubit.dart';
import 'package:satha/generated/locale_keys.g.dart';
import 'package:dio/dio.dart';
import 'package:satha/core/helper/validators.dart';

void main() {
  final ds = MockAuthDataSource();

  group('Mock customer login', () {
    test('ينجح ببيانات صحيحة', () async {
      final res = await ds.login(
        LoginRequestModel(
          phoneOrEmail: '0500000001',
          password: 'Customer@123',
          role: 'customer',
        ),
      );
      expect(res.status, 1);
      expect(res.user?.role, 'customer');
      expect(res.token, isNotNull);
    });

    test('يفشل بكلمة مرور خاطئة', () async {
      final res = await ds.login(
        LoginRequestModel(
          phoneOrEmail: '0500000001',
          password: 'wrong',
          role: 'customer',
        ),
      );
      expect(res.status, 0);
      expect(res.message, LocaleKeys.invalidCredentials);
    });
  });

  group('Mock driver login', () {
    test('السائق المعتمد ينجح', () async {
      final res = await ds.login(
        LoginRequestModel(
          phoneOrEmail: '0500000002',
          password: 'Driver@123',
          role: 'driver',
        ),
      );
      expect(res.status, 1);
      expect(res.user?.approvalStatus, 'approved');
    });

    test('السائق قيد المراجعة يُمنع', () async {
      final res = await ds.login(
        LoginRequestModel(
          phoneOrEmail: '0500000003',
          password: 'Driver@123',
          role: 'driver',
        ),
      );
      expect(res.status, 0);
      expect(res.message, LocaleKeys.accountPendingReview);
    });
  });

  group('Mock admin login', () {
    test('ينجح ببيانات المسؤول', () async {
      final res = await ds.login(
        LoginRequestModel(
          phoneOrEmail: 'admin@sat7a.app',
          password: 'Admin@123',
          role: 'admin',
        ),
      );
      expect(res.status, 1);
      expect(res.user?.role, 'admin');
    });
  });

  group('Mock OTP', () {
    test('الرمز 123456 ينجح', () async {
      final res = await ds.verifyOtp(
        OtpRequestModel(identifier: '0500000001', code: '123456'),
      );
      expect(res.status, 1);
    });

    test('رمز خاطئ يفشل', () async {
      final res = await ds.verifyOtp(
        OtpRequestModel(identifier: '0500000001', code: '000000'),
      );
      expect(res.status, 0);
      expect(res.message, LocaleKeys.invalidOtp);
    });
  });

  group('Cache & session', () {
    setUp(() async {
      SharedPreferences.setMockInitialValues({});
      await CacheHelper.init();
    });

    test('تسجيل الخروج يمسح الجلسة المخزّنة', () async {
      await AuthSession.save(
        user: const AppUser(
          id: '1',
          name: 'عميل',
          phone: '0500000001',
          email: 'c@sat7a.app',
          role: UserRole.customer,
        ),
        token: 'token123',
      );
      expect(AuthSession.isLoggedIn, isTrue);

      await AuthSession.clear();
      expect(AuthSession.isLoggedIn, isFalse);
      expect(CacheHelper.getUserType(), '');
    });

    test('حفظ إكمال الأونبوردنق', () async {
      expect(CacheHelper.getShowIntro(), isFalse);
      await CacheHelper.setShowIntro(true);
      expect(CacheHelper.getShowIntro(), isTrue);
    });

    test('حارس الدور: العميل دوره customer بعد الحفظ', () async {
      await AuthSession.save(
        user: const AppUser(
          id: '2',
          name: 'سائق',
          phone: '0500000002',
          email: 'd@sat7a.app',
          role: UserRole.driver,
          approvalStatus: DriverApprovalStatus.approved,
        ),
        token: 'tok',
      );
      expect(AuthSession.role, UserRole.driver);
      expect(AuthSession.role == UserRole.customer, isFalse);
    });
  });

  group('AuthRepo via ApiResult', () {
    test('AuthRepo يرجّع نجاح للعميل (mock)', () async {
      final repo = AuthRepo(AuthApiService(Dio()), MockAuthDataSource());
      final result = await repo.login(
        LoginRequestModel(
          phoneOrEmail: '0500000001',
          password: 'Customer@123',
          role: 'customer',
        ),
      );
      final status = result.when(success: (r) => r.status, error: (_) => -1);
      expect(status, 1);
    });
  });

  group('Driver multi-step navigation', () {
    test('nextStep / prevStep يحرّكان الخطوة الحالية', () {
      final cubit = DriverRegisterCubit(
        AuthRepo(AuthApiService(Dio()), MockAuthDataSource()),
      );
      expect(cubit.currentStep, 0);
      cubit.nextStep();
      expect(cubit.currentStep, 1);
      cubit.nextStep();
      cubit.nextStep();
      expect(cubit.currentStep, 3);
      cubit.prevStep();
      expect(cubit.currentStep, 2);
      cubit.close();
    });
  });

  group('Onboarding cubit', () {
    test('onPageChanged يحدّث الصفحة', () {
      final cubit = OnboardingCubit();
      expect(cubit.state, 0);
      cubit.onPageChanged(2);
      expect(cubit.state, 2);
      cubit.close();
    });
  });

  group('Validators', () {
    test('confirmPassword يكشف عدم التطابق', () {
      expect(Validators.confirmPassword('abc12345', 'abc12345'), isNull);
      expect(Validators.confirmPassword('abc12345', 'different'), isNotNull);
    });

    test('password يرفض الأقل من 8 أحرف', () {
      expect(Validators.password('123'), isNotNull);
      expect(Validators.password('12345678'), isNull);
    });
  });
}
