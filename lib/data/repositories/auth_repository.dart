import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lukethompson/core/network/dio_client.dart';
import 'package:lukethompson/data/api/auth.api.dart';
import 'package:lukethompson/data/models/auth.model.dart';

class AuthRepository {
  final AuthApi _authApi;
  AuthRepository({required AuthApi authApi}) : _authApi = authApi;

  Future<LoginResponse> login({
    required String email,
    required String password,
  }) => _authApi.login(LoginRequest(email: email, password: password));
}

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  final dio = ref.read(dioClientProvider);
  return AuthRepository(authApi: AuthApi(dio));
});
