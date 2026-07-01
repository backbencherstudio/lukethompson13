import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lukethompson/core/network/api_endpoints.dart';
import 'package:lukethompson/core/network/providers.dart';
import 'package:lukethompson/data/models/models.dart';
import 'package:retrofit/retrofit.dart';

part 'stoplog.api.g.dart';

@RestApi()
abstract class StoplogApi {
  factory StoplogApi(Dio dio) = _StoplogApi;

  @GET(ApiEndpoints.stoplogHomeData)
  Future<HomeDataOverviewResponse> homeDataOverview(
    @Query('period') HomeDataPeriod period,
  );
}

final stoplogApiProvider = Provider<StoplogApi>((ref) {
  final dio = ref.read(dioClientProvider);
  return StoplogApi(dio);
});
