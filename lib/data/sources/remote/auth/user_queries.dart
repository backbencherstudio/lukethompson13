import 'dart:io';

import 'package:lukethompson/data/sources/remote/remote.dart';
import 'package:zenquery/zenquery.dart';
import 'package:lukethompson/data/sources/remote/auth/auth_repository.dart';

final userQuery = createQueryPersist((ref) async {
  final repo = ref.read(authRepositoryProvider);
  final response = await repo.getMe();
  return response.data;
});

class UpdateUserProfileParams {
  final String? name;
  final String? phoneNumber;
  final int? freeWaitTime;
  final int? ratePerHour;
  final File? image;
  final CreateCompanyRequest? company;

  const UpdateUserProfileParams({
    this.name,
    this.phoneNumber,
    this.freeWaitTime,
    this.ratePerHour,
    this.image,
    this.company,
  });
}

final updateUserProfileMutation =
    createMutationWithParam<GetMeResponse, UpdateUserProfileParams>((
      tsx,
      params,
    ) async {
      final repo = tsx.get(authRepositoryProvider);
      final response = await repo.updateUserProfile(
        name: params.name,
        phoneNumber: params.phoneNumber,
        freeWaitTime: params.freeWaitTime,
        ratePerHour: params.ratePerHour,
        image: params.image,
        company: params.company,
      );
      return response;
    });
