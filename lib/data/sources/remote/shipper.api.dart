import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lukethompson/core/network/api_endpoints.dart';
import 'package:lukethompson/core/network/providers.dart';
import 'package:lukethompson/data/models/models.dart';
import 'package:retrofit/retrofit.dart';

part 'shipper.api.g.dart';

@RestApi()
abstract class ShipperApi {
  factory ShipperApi(Dio dio) = _ShipperApi;

  @POST(ApiEndpoints.submitARatingForAShipperFacility)
  Future<BaseResponse> submitARatingForAShipperFacility(
    @Path('stop_log_id') String stopLogId,
    @Body() SubmitARatingForAShipperFacilityRequest body,
  );

  @GET(ApiEndpoints.shippersRatings)
  Future<ShipperRatingsResponse> getAllShippersAndFacilitiesWithRatings(
    @Query('cursor') String? cursor,
    @Query('limit') int? limit,
    @Query('status') String? status,
  );
}

final shipperApiProvider = Provider<ShipperApi>((ref) {
  final dio = ref.read(dioClientProvider);
  return ShipperApi(dio);
});

