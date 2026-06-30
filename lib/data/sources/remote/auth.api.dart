import 'dart:io';

import 'package:dio/dio.dart';
import 'package:lukethompson/core/network/api_endpoints.dart';
import 'package:lukethompson/data/models/auth.model.dart';
import 'package:lukethompson/data/models/base.model.dart';
import 'package:retrofit/retrofit.dart';

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
  );

  @POST(ApiEndpoints.forgotPassword)
  Future<BaseResponse> forgotPassword(@Body() ForgotPasswordRequest body);

  @POST(ApiEndpoints.verifyOtp)
  Future<BaseResponse> checkOtp(@Body() CheckOtpRequest body);

  @POST(ApiEndpoints.resetForgottenPassword)
  Future<BaseResponse> resetForgottenPassword(@Body() ResetPasswordRequest body);
}
