import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lukethompson/data/models/auth_state.dart';
import 'package:lukethompson/data/repositories/auth_repository.dart';
import 'package:lukethompson/data/sources/local/shared_preference/shared_preference.dart';

class AuthNotifier extends Notifier<AuthState> {
  @override
  AuthState build() {
    _init();
    return const AuthState.initial();
  }

  Future<void> _init() async {
    final token = await SharedPreferenceData.getToken();
    if (token != null && token != 'null' && token.isNotEmpty) {
      state = AuthState.authenticated(token: token);
    }
  }

  Future<void> login({required String email, required String password}) async {
    state = const AuthState.loading();
    try {
      final repo = ref.read(authRepositoryProvider);
      final response = await repo.login(email: email, password: password);
      if (response.success && response.authorization != null) {
        await SharedPreferenceData.setToken(response.authorization!.accessToken);
        state = AuthState.authenticated(
          user: response.user,
          token: response.authorization!.accessToken,
        );
      } else {
        state = AuthState.failure(response.message);
      }
    } catch (e) {
      state = AuthState.failure(e.toString());
    }
  }

  Future<void> logout() async {
    await SharedPreferenceData.removeToken();
    state = const AuthState.initial();
  }
}

final authProvider = NotifierProvider<AuthNotifier, AuthState>(
  AuthNotifier.new,
);
