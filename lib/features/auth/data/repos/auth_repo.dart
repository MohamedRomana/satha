import '../../../../core/constants/app_constants.dart';
import '../../../../core/networking/api_error_model.dart';
import '../../../../core/networking/api_result.dart';
import '../apis/auth_api_service.dart';
import '../datasources/mock_auth_data_source.dart';
import '../models/auth_request_models.dart';
import '../models/auth_response_model.dart';

/// مستودع المصادقة — يبدّل تلقائيًا بين الـ mock والـ API الحقيقي
/// حسب [AppConstants.useMockData]. كل method ترجّع [ApiResult].
class AuthRepo {
  final AuthApiService _api;
  final MockAuthDataSource _mock;

  AuthRepo(this._api, this._mock);

  Future<ApiResult<AuthResponseModel>> login(LoginRequestModel body) async {
    try {
      final res = AppConstants.useMockData
          ? await _mock.login(body)
          : (body.role == 'driver'
                ? await _api.driverLogin(body)
                : body.role == 'admin'
                ? await _api.adminLogin(body)
                : await _api.customerLogin(body));
      return ApiResult.success(res);
    } catch (e) {
      return ApiResult.error(ApiErrorModel(message: e.toString()));
    }
  }

  Future<ApiResult<AuthResponseModel>> registerCustomer(
    RegisterCustomerRequestModel body,
  ) async {
    try {
      final res = AppConstants.useMockData
          ? await _mock.registerCustomer(body)
          : await _api.customerRegister(body);
      return ApiResult.success(res);
    } catch (e) {
      return ApiResult.error(ApiErrorModel(message: e.toString()));
    }
  }

  Future<ApiResult<AuthResponseModel>> registerDriver(
    RegisterDriverRequestModel body,
  ) async {
    try {
      final res = AppConstants.useMockData
          ? await _mock.registerDriver(body)
          : await _api.driverRegister(body);
      return ApiResult.success(res);
    } catch (e) {
      return ApiResult.error(ApiErrorModel(message: e.toString()));
    }
  }

  Future<ApiResult<AuthResponseModel>> forgotPassword(
    ForgotPasswordRequestModel body,
  ) async {
    try {
      final res = AppConstants.useMockData
          ? await _mock.forgotPassword(body)
          : await _api.forgotPassword(body);
      return ApiResult.success(res);
    } catch (e) {
      return ApiResult.error(ApiErrorModel(message: e.toString()));
    }
  }

  Future<ApiResult<AuthResponseModel>> verifyOtp(OtpRequestModel body) async {
    try {
      final res = AppConstants.useMockData
          ? await _mock.verifyOtp(body)
          : await _api.verifyOtp(body);
      return ApiResult.success(res);
    } catch (e) {
      return ApiResult.error(ApiErrorModel(message: e.toString()));
    }
  }

  Future<ApiResult<AuthResponseModel>> resetPassword(
    ResetPasswordRequestModel body,
  ) async {
    try {
      final res = AppConstants.useMockData
          ? await _mock.resetPassword(body)
          : await _api.resetPassword(body);
      return ApiResult.success(res);
    } catch (e) {
      return ApiResult.error(ApiErrorModel(message: e.toString()));
    }
  }

  Future<void> logout() async {
    try {
      if (AppConstants.useMockData) {
        await _mock.logout();
      } else {
        await _api.logout();
      }
    } catch (_) {
      // تجاهل أخطاء الخروج — الجلسة المحلية تُمسح على أي حال.
    }
  }
}
