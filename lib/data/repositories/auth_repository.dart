import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lukethompson/core/network/dio_client.dart';
import 'package:lukethompson/data/api/auth.api.dart';
import 'package:lukethompson/data/models/auth.model.dart';
import 'package:lukethompson/data/models/base.model.dart';

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
