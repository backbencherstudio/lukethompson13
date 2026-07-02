import 'package:lukethompson/data/models/report/report.model.dart';
import 'package:lukethompson/data/sources/remote/stoplog.api.dart';
import 'package:zenquery/zenquery.dart';

final getWeeklyReportSummaryQuery = createQueryPersist((ref) async {
  final api = ref.read(stoplogApiProvider);
  final response = await api.getWeeklyReportSummary(tab: 'WEEKLY_SUMMARY');
  return response.data;
});

final getTaxReportSummaryQuery = createQueryFamilyPersist((
  ref,
  TaxReportDataPeriod period,
) async {
  final api = ref.read(stoplogApiProvider);
  final response = await api.getTaxReportSummary(
    tab: 'TAX_REPORT',
    period: period,
  );
  return response.data;
});
