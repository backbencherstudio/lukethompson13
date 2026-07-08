import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lukethompson/core/network/api_endpoints.dart';
import 'package:lukethompson/core/network/providers.dart';
import 'package:lukethompson/data/models/claim/submit_claim.dart';
import 'package:lukethompson/data/models/models.dart';
import 'package:retrofit/retrofit.dart';

part 'claim.api.g.dart';

@RestApi()
abstract class ClaimApi {
  factory ClaimApi(Dio dio) = _ClaimApi;

  @POST(ApiEndpoints.submitAClaim)
  Future<BaseResponse> submitAClaim(
    @Path('id') String id,
    @Body() SubmitClaimRequest body,
  );
}

final claimApiProvider = Provider<ClaimApi>((ref) {
  final dio = ref.read(dioClientProvider);
  return ClaimApi(dio);
});
