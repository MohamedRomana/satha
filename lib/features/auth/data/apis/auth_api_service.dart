import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import 'package:satha/core/networking/api_constants.dart';
import '../models/auth_request_models.dart';
import '../models/auth_response_model.dart';

part 'auth_api_service.g.dart';

/// واجهة الـ API للمصادقة (Retrofit) — جاهزة للربط مع الباك إند.
/// لا تُستخدم فعليًا طالما [AppConstants.useMockData] = true.
@RestApi(baseUrl: ApiConstants.baseUrl)
abstract class AuthApiService {
  factory AuthApiService(Dio dio, {String baseUrl}) = _AuthApiService;

  @POST(ApiConstants.authCustomerLogin)
  Future<AuthResponseModel> customerLogin(@Body() LoginRequestModel body);

  @POST(ApiConstants.authCustomerRegister)
  Future<AuthResponseModel> customerRegister(
    @Body() RegisterCustomerRequestModel body,
  );

  @POST(ApiConstants.authDriverLogin)
  Future<AuthResponseModel> driverLogin(@Body() LoginRequestModel body);

  @POST(ApiConstants.authDriverRegister)
  Future<AuthResponseModel> driverRegister(
    @Body() RegisterDriverRequestModel body,
  );

  @POST(ApiConstants.authAdminLogin)
  Future<AuthResponseModel> adminLogin(@Body() LoginRequestModel body);

  @POST(ApiConstants.authForgotPassword)
  Future<AuthResponseModel> forgotPassword(
    @Body() ForgotPasswordRequestModel body,
  );

  @POST(ApiConstants.authVerifyOtp)
  Future<AuthResponseModel> verifyOtp(@Body() OtpRequestModel body);

  @POST(ApiConstants.authResetPassword)
  Future<AuthResponseModel> resetPassword(
    @Body() ResetPasswordRequestModel body,
  );

  @POST(ApiConstants.authLogout)
  Future<AuthResponseModel> logout();

  @GET(ApiConstants.authMe)
  Future<AuthResponseModel> me();
}
