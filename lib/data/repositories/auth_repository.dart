import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lukethompson/core/network/providers.dart';
import 'package:lukethompson/data/sources/remote/auth.api.dart';
import 'package:lukethompson/data/models/models.dart';

class AuthRepository {
  final AuthApi _authApi;
  AuthRepository({required AuthApi authApi}) : _authApi = authApi;

  Future<LoginResponse> login({
    required String email,
    required String password,
  }) => _authApi.login(LoginRequest(email: email, password: password));

  Future<BaseResponse> verifyEmail({
    required String email,
    required String token,
  }) => _authApi.verifyUserEmailAddress(
    VerifyEmailRequest(email: email, token: token),
  );

  Future<BaseResponse> forgotPassword({required String email}) =>
      _authApi.forgotPassword(ForgotPasswordRequest(email: email));

  Future<BaseResponse> checkOtp({required String email, required String otp}) =>
      _authApi.checkOtp(CheckOtpRequest(email: email, otp: otp));

  Future<BaseResponse> resetForgottenPassword({
    required String email,
    required String token,
    required String password,
  }) =>
      _authApi.resetForgottenPassword(
        ResetPasswordRequest(email: email, token: token, password: password),
      );

  Future<GetMeResponse> getMe() => _authApi.getMe();

  Future<BaseResponse> register({
    required String name,
    required String email,
    required String password,
    int? freeWaitTime,
    int? ratePerHour,
    required String type,
  }) => _authApi.register(
    RegisterRequest(
      name: name,
      email: email,
      password: password,
      freeWaitTime: freeWaitTime,
      ratePerHour: ratePerHour,
      type: type,
    ),
  );

  Future<GetMeResponse> updateUserProfile({
    String? name,
    String? phoneNumber,
    int? freeWaitTime,
    int? ratePerHour,
    File? image,
  }) => _authApi.updateUserProfile(
    name,
    phoneNumber,
    freeWaitTime,
    ratePerHour,
    image,
  );
}

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  final dio = ref.read(dioClientProvider);
  return AuthRepository(authApi: AuthApi(dio));
});
