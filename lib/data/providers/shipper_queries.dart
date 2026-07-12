import 'package:lukethompson/core/utils/mutation.dart';
import 'package:lukethompson/data/models/models.dart';
import 'package:lukethompson/data/sources/remote/shipper.api.dart';

final submitARatingForAShipperFacilityMutation =
    mutationProvider<SubmitARatingForAShipperFacility, BaseResponse>(
      SubmitARatingForAShipperFacility.new,
    );

class SubmitARatingForAShipperFacility extends MutationNotifier<BaseResponse> {
  Future<BaseResponse> submit(String id, int rate) {
    final api = ref.read(shipperApiProvider);

    return mutate(() async {
      return api.submitARatingForAShipperFacility(
        id,
        SubmitARatingForAShipperFacilityRequest(rate: rate),
      );
    });
  }
}
