import 'package:lukethompson/data/sources/remote/stoplog.api.dart';
import 'package:zenquery/zenquery.dart';

final getWeeklyReportSummaryQuery = createQueryPersist((ref) async {
  final api = ref.read(stoplogApiProvider);
  final response = await api.getWeeklyReportSummary('WEEKLY_SUMMARY');
  return response.data;
});
