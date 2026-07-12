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

final markAClaimAsPaidMutation =
    mutationProvider<MarkAClaimAsPaidMutation, BaseResponse>(
      MarkAClaimAsPaidMutation.new,
    );

class MarkAClaimAsPaidMutation extends MutationNotifier<BaseResponse> {
  Future<BaseResponse> submit(String id, [MarkAClaimAsPaidRequest? body]) {
    final api = ref.read(claimApiProvider);

    return mutate(() async {
      return api.markAClaimAsPaid(id, body);
    });
  }
}

final markAClaimAsDeniedMutation =
    mutationProvider<MarkAClaimAsDeniedMutation, BaseResponse>(
      MarkAClaimAsDeniedMutation.new,
    );

class MarkAClaimAsDeniedMutation extends MutationNotifier<BaseResponse> {
  Future<BaseResponse> submit(String id, [MarkAClaimAsDeniedRequest? body]) {
    final api = ref.read(claimApiProvider);

    return mutate(() async {
      return api.markAClaimAsDenied(id, body);
    });
  }
}

final sendClaimFollowUpEmailMutation =
    mutationProvider<SendClaimFollowUpEmailMutation, BaseResponse>(
      SendClaimFollowUpEmailMutation.new,
    );

class SendClaimFollowUpEmailMutation extends MutationNotifier<BaseResponse> {
  Future<BaseResponse> sendFollowUp(String id, int level) {
    final api = ref.read(claimApiProvider);

    return mutate(() async {
      return api.sendClaimFollowUpEmail(
        id,
        SendClaimFollowUpEmailRequest(level: level),
      );
    });
  }
}
