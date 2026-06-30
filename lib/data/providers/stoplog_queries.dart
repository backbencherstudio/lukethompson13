import 'package:lukethompson/data/models/stoplog.model.dart';
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
