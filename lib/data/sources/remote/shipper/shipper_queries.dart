import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lukethompson/core/utils/mutation.dart';
import 'package:lukethompson/data/models/models.dart';
import 'package:lukethompson/data/sources/remote/shipper/models/models.dart';
import 'package:lukethompson/data/sources/remote/shipper/shipper.api.dart';

class ShipperSearchNotifier
    extends AsyncNotifier<List<ShipperSearchFacilityItem>?> {
  @override
  Future<List<ShipperSearchFacilityItem>?> build() async => null;

  Future<void> search(ShipperSearchParams params) async {
    _search(params);
  }

  Future<void> searchInitialData(FacilityType facilityType) async {
    state = const AsyncLoading();
    _search(ShipperSearchParams(type: facilityType));
  }

  Future<void> _search(ShipperSearchParams params) async {
    try {
      final api = ref.read(shipperApiProvider);
      final response = await api.getSearchAllShipperFacilities(
        params.search,
        params.cursor,
        params.limit,
        params.type?.toJson(),
      );
      state = AsyncData(response.data);
    } catch (e, st) {
      state = AsyncError(e, st);
    }
  }
}

final getSearchAllShipperFacilitiesProvider =
    AsyncNotifierProvider<
      ShipperSearchNotifier,
      List<ShipperSearchFacilityItem>?
    >(ShipperSearchNotifier.new);

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

final createANewShipperFacilityMutation =
    mutationProvider<CreateANewShipperFacility, CreateShipperResponse>(
      CreateANewShipperFacility.new,
    );

class CreateANewShipperFacility
    extends MutationNotifier<CreateShipperResponse> {
  Future<CreateShipperResponse> create(CreateShippperRequest body) {
    final api = ref.read(shipperApiProvider);

    return mutate(() async {
      return api.createANewShipperFacility(body);
    });
  }
}
