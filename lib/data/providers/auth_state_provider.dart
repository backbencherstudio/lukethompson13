import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lukethompson/core/network/error_handle.dart';
import 'package:lukethompson/core/network/providers.dart';
import 'package:lukethompson/data/models/auth_state.dart';
import 'package:lukethompson/data/repositories/auth_repository.dart';
import 'package:lukethompson/data/sources/local/shared_preference/shared_preference.dart';

class AuthStateNotifier extends Notifier<AuthState> {
  @override
  AuthState build() {
    _init();
    return const AuthState.initial();
  }

  Future<void> _init() async {
    final token = await SharedPreferenceData.getToken();
    if (token != null && token != 'null' && token.isNotEmpty) {
      ref.read(cachedTokenProvider.notifier).setToken(token);
      state = AuthState.authenticated(token: token);
    }
  }

  Future<void> login({required String email, required String password}) async {
    state = const AuthState.loading();
    try {
      final repo = ref.read(authRepositoryProvider);
      final response = await repo.login(email: email, password: password);
      if (response.success && response.authorization != null) {
        final token = response.authorization!.accessToken;
        await SharedPreferenceData.setToken(token);
        ref.read(cachedTokenProvider.notifier).setToken(token);

        state = AuthState.authenticated(user: response.user, token: token);
      } else {
        state = AuthState.failure(response.message);
      }
    } catch (e) {
      state = AuthState.failure(ErrorHandle.extractServerMessage(e));
    }
  }

  Future<void> logout() async {
    ref.read(cachedTokenProvider.notifier).setToken(null);
    await SharedPreferenceData.removeToken();
    state = const AuthState.initial();
  }
}

final authStateProvider = NotifierProvider<AuthStateNotifier, AuthState>(
  AuthStateNotifier.new,
);
