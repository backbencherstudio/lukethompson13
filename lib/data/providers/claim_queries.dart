import 'package:lukethompson/data/models/stops/mark_a_claim_as_paid_request.model.dart';
import 'package:lukethompson/data/sources/remote/claim.api.dart';
import 'package:lukethompson/core/utils/mutation.dart';
import 'package:lukethompson/data/models/models.dart';

final submitAClaimAction =
    mutationProvider<SubmitClaimNotifire, SubmitClaimResponse>(
      SubmitClaimNotifire.new,
    );

class SubmitClaimNotifire extends MutationNotifier<SubmitClaimResponse> {
  Future<SubmitClaimResponse> submit(String id, SubmitClaimRequest body) {
    final api = ref.read(claimApiProvider);

    return mutate(() async {
      return api.submitAClaim(id, body);
    });
  }
}

final markAClaimAsPaid =
    mutationProvider<MarkAClaimAsPaidNotifire, BaseResponse>(
      MarkAClaimAsPaidNotifire.new,
    );

class MarkAClaimAsPaidNotifire extends MutationNotifier<BaseResponse> {
  Future<BaseResponse> submit(String id, MarkAClaimAsPaidRequest body) {
    final api = ref.read(claimApiProvider);

    return mutate(() async {
      return api.markAClaimAsPaid(id, body);
    });
  }
}
