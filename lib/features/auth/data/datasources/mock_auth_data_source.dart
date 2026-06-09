import 'package:satha/core/constants/app_constants.dart';
import 'package:satha/generated/locale_keys.g.dart';
import '../models/auth_request_models.dart';
import '../models/auth_response_model.dart';
import '../models/user_model.dart';
import '../models/user_role.dart';

/// سجل مستخدم وهمي للاختبار بدون باك إند.
class _MockAccount {
  final String id;
  final String name;
  final String phone;
  final String email;
  final String password;
  final UserRole role;
  final DriverApprovalStatus? status;

  const _MockAccount({
    required this.id,
    required this.name,
    required this.phone,
    required this.email,
    required this.password,
    required this.role,
    this.status,
  });

  UserModel toUserModel() => UserModel(
    id: int.tryParse(id),
    name: name,
    phone: phone,
    email: email,
    role: role.key,
    approvalStatus: status?.key,
  );
}

/// مصدر بيانات وهمي للمصادقة — يحاكي السيرفر (تأخير + حالات نجاح/فشل).
class MockAuthDataSource {
  static const List<_MockAccount> _accounts = [
    _MockAccount(
      id: '1',
      name: 'عميل سطحة',
      phone: '0500000001',
      email: 'customer@sat7a.app',
      password: 'Customer@123',
      role: UserRole.customer,
    ),
    _MockAccount(
      id: '2',
      name: 'سائق معتمد',
      phone: '0500000002',
      email: 'driver@sat7a.app',
      password: 'Driver@123',
      role: UserRole.driver,
      status: DriverApprovalStatus.approved,
    ),
    _MockAccount(
      id: '3',
      name: 'سائق قيد المراجعة',
      phone: '0500000003',
      email: 'pending@sat7a.app',
      password: 'Driver@123',
      role: UserRole.driver,
      status: DriverApprovalStatus.pending,
    ),
    _MockAccount(
      id: '4',
      name: 'مسؤول الإدارة',
      phone: '',
      email: 'admin@sat7a.app',
      password: 'Admin@123',
      role: UserRole.admin,
    ),
  ];

  Future<void> _simulateNetwork() => Future.delayed(AppConstants.mockDelay);

  bool _matches(_MockAccount a, String identifier) {
    final id = identifier.trim().toLowerCase();
    return a.phone == identifier.trim() || a.email.toLowerCase() == id;
  }

  Future<AuthResponseModel> login(LoginRequestModel body) async {
    await _simulateNetwork();
    final role = UserRoleX.fromKey(body.role);
    final account = _accounts
        .where((a) => a.role == role && _matches(a, body.phoneOrEmail))
        .cast<_MockAccount?>()
        .firstWhere((a) => a?.password == body.password, orElse: () => null);

    if (account == null) {
      return AuthResponseModel(
        status: 0,
        message: LocaleKeys.invalidCredentials,
      );
    }

    // السائق لا يدخل إلا لو معتمد.
    if (account.role == UserRole.driver) {
      if (account.status == DriverApprovalStatus.pending ||
          account.status == DriverApprovalStatus.suspended) {
        return AuthResponseModel(
          status: 0,
          message: LocaleKeys.accountPendingReview,
        );
      }
      if (account.status == DriverApprovalStatus.rejected) {
        return AuthResponseModel(
          status: 0,
          message: LocaleKeys.accountRejected,
        );
      }
    }

    return AuthResponseModel(
      status: 1,
      message: LocaleKeys.loginSuccess,
      token: 'mock_token_${account.role.key}_${account.id}',
      user: account.toUserModel(),
    );
  }

  Future<AuthResponseModel> registerCustomer(
    RegisterCustomerRequestModel body,
  ) async {
    await _simulateNetwork();
    return AuthResponseModel(
      status: 1,
      message: LocaleKeys.signUpSuccess,
      token: 'mock_token_customer_new',
      user: UserModel(
        id: 100,
        name: body.name,
        phone: body.phone,
        email: body.email,
        role: UserRole.customer.key,
        image: body.image,
      ),
    );
  }

  Future<AuthResponseModel> registerDriver(
    RegisterDriverRequestModel body,
  ) async {
    await _simulateNetwork();
    // السائق الجديد دايمًا قيد المراجعة من الإدارة.
    return AuthResponseModel(
      status: 1,
      message: LocaleKeys.request_sent_successfully,
      user: UserModel(
        id: 101,
        name: body.personalInfo.name,
        phone: body.personalInfo.phone,
        email: body.personalInfo.email,
        role: UserRole.driver.key,
        approvalStatus: DriverApprovalStatus.pending.key,
      ),
    );
  }

  Future<AuthResponseModel> forgotPassword(
    ForgotPasswordRequestModel body,
  ) async {
    await _simulateNetwork();
    return AuthResponseModel(
      status: 1,
      message: LocaleKeys.request_sent_successfully,
    );
  }

  Future<AuthResponseModel> verifyOtp(OtpRequestModel body) async {
    await _simulateNetwork();
    if (body.code == AppConstants.mockOtp) {
      return AuthResponseModel(
        status: 1,
        message: LocaleKeys.activatedSuccessfully,
      );
    }
    return AuthResponseModel(status: 0, message: LocaleKeys.invalidOtp);
  }

  Future<AuthResponseModel> resetPassword(
    ResetPasswordRequestModel body,
  ) async {
    await _simulateNetwork();
    if (body.code != AppConstants.mockOtp) {
      return AuthResponseModel(status: 0, message: LocaleKeys.invalidOtp);
    }
    return AuthResponseModel(
      status: 1,
      message: LocaleKeys.passwordUpdated,
    );
  }

  Future<void> logout() async {
    await _simulateNetwork();
  }
}
