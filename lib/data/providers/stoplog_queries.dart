import 'package:dio/dio.dart';

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

class RecordStopLogParams {
  final String id;
  final StopLogStep step;
  final String? shipperId;
  final String? facilityName;
  final String? location;
  final List<MultipartFile>? attachments;
  final String? bolNumber;

  const RecordStopLogParams({
    required this.id,
    required this.step,
    this.shipperId,
    this.facilityName,
    this.location,
    this.attachments,
    this.bolNumber,
  });
}

final recordStopLogMutation =
    createMutationWithParam<BaseResponse, RecordStopLogParams>(
  (tsx, params) async {
    final api = tsx.get(stoplogApiProvider);
    return await api.recordSingleStopLog(
      id: params.id,
      step: params.step,
      shipperId: params.shipperId,
      facilityName: params.facilityName,
      location: params.location,
      attachments: params.attachments,
      bolNumber: params.bolNumber,
    );
  },
);
