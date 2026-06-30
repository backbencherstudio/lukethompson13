import 'package:lukethompson/core/network/error_handle.dart';
import 'package:lukethompson/core/network/providers.dart';
import 'package:lukethompson/data/models/auth.model.dart';
import 'package:lukethompson/data/models/auth_state.dart';
import 'package:lukethompson/data/models/base.model.dart';
import 'package:lukethompson/data/repositories/auth_repository.dart';
import 'package:lukethompson/data/sources/local/shared_preference/shared_preference.dart';
import 'package:zenquery/zenquery.dart';

class AuthNotifier extends Notifier<AuthState> {
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

  Future<BaseResponse?> register({
    required String name,
    required String email,
    required String password,
    int? freeWaitTime,
    int? ratePerHour,
    String type = 'user',
  }) async {
    state = const AuthState.loading();
    try {
      final repo = ref.read(authRepositoryProvider);
      final response = await repo.register(
        name: name,
        email: email,
        password: password,
        freeWaitTime: freeWaitTime,
        ratePerHour: ratePerHour,
        type: type,
      );
      if (response.success) {
        state = const AuthState.initial();
        return response;
      } else {
        state = AuthState.failure(response.message);
        return null;
      }
    } catch (e) {
      state = AuthState.failure(ErrorHandle.extractServerMessage(e));
      return null;
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

final authProvider = NotifierProvider<AuthNotifier, AuthState>(
  AuthNotifier.new,
);

final forgotPasswordMutation =
    createMutationWithParam<BaseResponse, ForgotPasswordRequest>((
      tsx,
      params,
    ) async {
      final repo = tsx.get(authRepositoryProvider);
      return await repo.forgotPassword(email: params.email);
    });

final verifyEmailMutation =
    createMutationWithParam<BaseResponse, VerifyEmailRequest>((
      tsx,
      params,
    ) async {
      final repo = tsx.get(authRepositoryProvider);
      return await repo.verifyEmail(email: params.email, token: params.token);
    });

final checkOtpMutation = createMutationWithParam<BaseResponse, CheckOtpRequest>(
  (tsx, params) async {
    final repo = tsx.get(authRepositoryProvider);
    return await repo.checkOtp(email: params.email, otp: params.otp);
  },
);

final resetForgottenPasswordMutation =
    createMutationWithParam<BaseResponse, ResetPasswordRequest>((
      tsx,
      params,
    ) async {
      final repo = tsx.get(authRepositoryProvider);
      return await repo.resetForgottenPassword(
        email: params.email,
        token: params.token,
        password: params.password,
      );
    });
