import 'dart:async';
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:lukethompson/core/utils/mutation.dart';
import 'package:lukethompson/data/sources/remote/remote.dart';
import 'package:zenquery/zenquery.dart';

final getStoplogHomeOverviewQuery = createQueryFamilyPersist((
  ref,
  HomeDataPeriod period,
) async {
  final api = ref.read(stoplogApiProvider);
  final response = await api.homeDataOverview(period);
  return response.data;
});

final getCurrentActiveStoplog = createQuery((ref) async {
  final api = ref.read(stoplogApiProvider);
  final response = await api.getCurrentActiveStoplog();
  return response.data;
});

final getSingleLogWithId = createQueryFamily((ref, String? id) async {
  if (id == null) return null;

  final api = ref.read(stoplogApiProvider);
  final response = await api.getSingleStoplog(id);
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
  final String? id;
  final StopLogStep step;
  final String? shipperId;
  final String? brokerId;
  final String? facilityName;
  final StopLogLocation? location;
  final List<MultipartFile>? attachments;
  final String? bolNumber;

  const RecordStopLogParams({
    required this.step,
    this.id,
    this.shipperId,
    this.facilityName,
    this.location,
    this.attachments,
    this.bolNumber,
    this.brokerId,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is RecordStopLogParams &&
        other.id == id &&
        other.step == step &&
        other.shipperId == shipperId &&
        other.brokerId == brokerId &&
        other.facilityName == facilityName &&
        other.location == location &&
        listEquals(other.attachments, attachments) &&
        other.bolNumber == bolNumber;
  }

  @override
  int get hashCode => Object.hash(
    id,
    step,
    shipperId,
    brokerId,
    facilityName,
    location,
    bolNumber,
  );
}

final recordStopLogProviderAction =
    mutationProvider<RecordStopLogNotifier, StopLogRecordResponse>(
      RecordStopLogNotifier.new,
    );

class RecordStopLogNotifier extends MutationNotifier<StopLogRecordResponse> {
  Future<StopLogRecordResponse> record(RecordStopLogParams params) {
    final api = ref.read(stoplogApiProvider);

    return mutate(() async {
      return api.recordSingleStopLog(
        id: params.id,
        step: params.step,
        shipperId: params.shipperId,
        brokerId: params.brokerId,
        facilityName: params.facilityName,
        location: params.location != null
            ? jsonEncode(params.location!.toJson())
            : null,
        attachments: params.attachments,
        bolNumber: params.bolNumber,
      );
    });
  }
}
