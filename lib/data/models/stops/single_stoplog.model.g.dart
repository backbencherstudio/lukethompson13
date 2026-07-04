// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'single_stoplog.model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SingleStoplogData _$SingleStoplogDataFromJson(Map<String, dynamic> json) =>
    SingleStoplogData(
      id: json['id'] as String,
      status: $enumDecode(_$SingleStoplogStatusEnumMap, json['status']),
      facilityName: json['facility_name'] as String,
      arrivedAt: DateTime.parse(json['arrived_at'] as String),
      departedAt: json['departed_at'] == null
          ? null
          : DateTime.parse(json['departed_at'] as String),
      bolNumber: json['bol_number'] as String?,
      gpsCoordinates: json['gps_coordinates'] as String?,
      ratePerHour: (json['rate_per_hour'] as num).toInt(),
      freeWaitTime: (json['free_wait_time'] as num).toInt(),
      billableTime: json['billable_time'] as String,
      billableTimeText: json['billable_time_text'] as String,
      arrivalDepartureTime: json['arrival_departure_time'] as String,
      address: json['address'] as String,
      detention: json['detention'] as String,
      lost: json['lost'] as String,
      attachments: (json['attachments'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      claim: json['claim'],
    );

Map<String, dynamic> _$SingleStoplogDataToJson(SingleStoplogData instance) =>
    <String, dynamic>{
      'id': instance.id,
      'status': _$SingleStoplogStatusEnumMap[instance.status]!,
      'facility_name': instance.facilityName,
      'arrived_at': instance.arrivedAt.toIso8601String(),
      'departed_at': instance.departedAt?.toIso8601String(),
      'bol_number': instance.bolNumber,
      'gps_coordinates': instance.gpsCoordinates,
      'rate_per_hour': instance.ratePerHour,
      'free_wait_time': instance.freeWaitTime,
      'billable_time': instance.billableTime,
      'billable_time_text': instance.billableTimeText,
      'arrival_departure_time': instance.arrivalDepartureTime,
      'address': instance.address,
      'detention': instance.detention,
      'lost': instance.lost,
      'attachments': instance.attachments,
      'claim': instance.claim,
    };

const _$SingleStoplogStatusEnumMap = {
  SingleStoplogStatus.active: 'ACTIVE',
  SingleStoplogStatus.completed: 'COMPLETED',
  SingleStoplogStatus.progress: 'PROGRESS',
};

SingleStoplogResponse _$SingleStoplogResponseFromJson(
  Map<String, dynamic> json,
) => SingleStoplogResponse(
  success: json['success'] as bool,
  message: json['message'] as String,
  data: json['data'] == null
      ? null
      : SingleStoplogData.fromJson(json['data'] as Map<String, dynamic>),
);

Map<String, dynamic> _$SingleStoplogResponseToJson(
  SingleStoplogResponse instance,
) => <String, dynamic>{
  'success': instance.success,
  'message': instance.message,
  'data': instance.data,
};
