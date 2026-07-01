import 'package:lukethompson/data/models/auth/auth.model.dart';

class AuthState {
  final User? user;
  final String? token;
  final String? error;
  final bool isLoading;

  bool get isAuthenticated => token != null && token!.isNotEmpty;

  const AuthState({this.user, this.token, this.error, this.isLoading = false});

  const AuthState.initial()
    : user = null,
      token = null,
      error = null,
      isLoading = false;

  const AuthState.loading()
    : user = null,
      token = null,
      error = null,
      isLoading = true;

  AuthState.authenticated({this.user, required String this.token})
    : error = null,
      isLoading = false;

  AuthState.failure(String this.error)
    : user = null,
      token = null,
      isLoading = false;
}
