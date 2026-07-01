import 'package:lukethompson/data/models/models.dart';
import 'package:lukethompson/data/sources/remote/stoplog.api.dart';
import 'package:zenquery/zenquery.dart';

final getStoplogHomeOverviewQuery = createQueryFamilyPersist((
  ref,
  HomeDataPeriod period,
) async {
  final api = ref.read(stoplogApiProvider);
  final response = await api.homeDataOverview(period);
  return response.data;
});

final getStoplogListQuery = createQueryFamilyPersist((
  ref,
  StopLogListParams params,
) async {
  final api = ref.read(stoplogApiProvider);

  final response = await api.getStopLogList(
    params.cursor,
    params.limit,
    params.search,
    params.status,
  );

  return response.data;
});
