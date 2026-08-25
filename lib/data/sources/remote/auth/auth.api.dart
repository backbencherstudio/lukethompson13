import 'dart:io';

import 'package:dio/dio.dart';
import 'package:lukethompson/core/network/api_endpoints.dart';
import 'package:lukethompson/data/models/models.dart';
import 'package:retrofit/retrofit.dart';
import 'package:lukethompson/data/sources/remote/remote.dart';

part 'auth.api.g.dart';

@RestApi()
abstract class AuthApi {
  factory AuthApi(Dio dio) = _AuthApi;

  @POST(ApiEndpoints.login)
  Future<LoginResponse> login(@Body() LoginRequest body);

  @POST(ApiEndpoints.register)
  Future<BaseResponse> register(@Body() RegisterRequest body);

  @POST(ApiEndpoints.verifyUserEmailAddress)
  Future<BaseResponse> verifyUserEmailAddress(@Body() VerifyEmailRequest body);

  @POST(ApiEndpoints.resendRegistrationVerificationOTP)
  Future<BaseResponse> resendRegistrationVerificationOTP(
    @Body() ForgotPasswordRequest body,
  );

  @GET(ApiEndpoints.getMe)
  Future<GetMeResponse> getMe();

  @PATCH(ApiEndpoints.updateUserProfile)
  @MultiPart()
  Future<GetMeResponse> updateUserProfile(
    @Part(name: 'name') String? name,
    @Part(name: 'phone_number') String? phoneNumber,
    @Part(name: 'free_wait_time') int? freeWaitTime,
    @Part(name: 'rate_per_hour') int? ratePerHour,
    @Part(name: 'image') File? image,
    @Part(name: 'company') String? company,
  );

  @POST(ApiEndpoints.forgotPassword)
  Future<BaseResponse> forgotPassword(@Body() ForgotPasswordRequest body);

  @POST(ApiEndpoints.checkOtp)
  Future<BaseResponse> checkOtp(@Body() CheckOtpRequest body);

  @POST(ApiEndpoints.resetForgottenPassword)
  Future<BaseResponse> resetForgottenPassword(
    @Body() ResetPasswordRequest body,
  );
}
