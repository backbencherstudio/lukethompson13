import 'package:lukethompson/core/utils/mutation.dart';
import 'package:lukethompson/data/models/models.dart';
import 'package:lukethompson/data/sources/remote/auth/auth_repository.dart';
import 'package:zenquery/zenquery.dart';
import 'package:lukethompson/data/sources/remote/remote.dart';

final registerMutation = createMutationWithParam<BaseResponse, RegisterRequest>(
  (tsx, params) async {
    final repo = tsx.get(authRepositoryProvider);
    return await repo.register(
      name: params.name,
      email: params.email,
      password: params.password,
      freeWaitTime: params.freeWaitTime,
      ratePerHour: params.ratePerHour,
      type: params.type,
    );
  },
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

final resendRegistrationVerificationOTPMutation =
    createMutationWithParam<BaseResponse, ForgotPasswordRequest>((
      tsx,
      params,
    ) async {
      final repo = tsx.get(authRepositoryProvider);
      return await repo.resendRegistrationVerificationOTP(email: params.email);
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

final deleteAccountMutation =
    mutationProvider<DeleteAccountMutationNotifire, BaseResponse>(
      DeleteAccountMutationNotifire.new,
    );

class DeleteAccountMutationNotifire extends MutationNotifier<BaseResponse> {
  Future<BaseResponse> delete(String password) {
    final repo = ref.read(authRepositoryProvider);

    return mutate(() async {
      return repo.deleteAccount(password: password);
    });
  }
}
