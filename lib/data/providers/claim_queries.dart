import 'package:lukethompson/core/utils/mutation.dart';
import 'package:lukethompson/data/models/claim/submit_claim.dart';
import 'package:lukethompson/data/models/common/base.model.dart';
import 'package:lukethompson/data/sources/remote/claim.api.dart';

final submitAClaimAction = mutationProvider<SubmitClaimNotifire, BaseResponse>(
  SubmitClaimNotifire.new,
);

class SubmitClaimNotifire extends MutationNotifier<BaseResponse> {
  Future<BaseResponse> submit(String id, SubmitClaimRequest body) {
    final api = ref.read(claimApiProvider);

    return mutate(() async {
      return api.submitAClaim(id, body);
    });
  }
}
