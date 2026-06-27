import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lukethompson/data/repositories/auth_repository.dart';

class AuthNotifier extends AsyncNotifier<void> {
  @override
  Future<void> build() async {}

  Future<void> login({required String email, required String password}) async {
    state = const AsyncLoading();

    final result = await AsyncValue.guard(() async {
      final repo = ref.read(authRepositoryProvider);
      final response = await repo.login(email: email, password: password);
    });

    state = result;
  }

  Future<void> logout() async {
    // ...
  }
}

final authProvider = AsyncNotifierProvider<AuthNotifier, void>(
  AuthNotifier.new,
);
