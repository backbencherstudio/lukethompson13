// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'single_stoplog.model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SingleStoplogData _$SingleStoplogDataFromJson(Map<String, dynamic> json) =>
    SingleStoplogData(
      id: json['id'] as String?,
      userId: json['user_id'] as String?,
      shipperFacilityId: json['shipper_facility_id'] as String?,
      shipperId: json['shipper_id'] as String?,
      shipperName: json['shipper_name'] as String?,
      facilityName: json['facility_name'] as String?,
      bolNumber: json['bol_number'] as String?,
      status: $enumDecodeNullable(_$SingleStoplogStatusEnumMap, json['status']),
      arrivedAt: json['arrived_at'] == null
          ? null
          : DateTime.parse(json['arrived_at'] as String),
      dockedAt: json['docked_at'] == null
          ? null
          : DateTime.parse(json['docked_at'] as String),
      completedAt: json['completed_at'] == null
          ? null
          : DateTime.parse(json['completed_at'] as String),
      departedAt: json['departed_at'] == null
          ? null
          : DateTime.parse(json['departed_at'] as String),
      arrivalLocation: json['arrival_location'] == null
          ? null
          : StopLogLocation.fromJson(
              json['arrival_location'] as Map<String, dynamic>,
            ),
      facilityAddress: json['facility_address'] == null
          ? null
          : StopLogLocation.fromJson(
              json['facility_address'] as Map<String, dynamic>,
            ),
      attachments: (json['attachments'] as List<dynamic>?)
          ?.map((e) => StopLogAttachment.fromJson(e as Map<String, dynamic>))
          .toList(),
      currentStep: StopLogStep.fromValue(json['current_step'] as String?),
      gpsCoordinates: json['gps_coordinates'] as String?,
      ratePerHour: (json['rate_per_hour'] as num?)?.toInt(),
      freeWaitTime: (json['free_wait_time'] as num?)?.toInt(),
      billableTime: json['billable_time'] as String?,
      billableTimeText: json['billable_time_text'] as String?,
      arrivalDepartureTime: json['arrival_departure_time'] as String?,
      address: json['address'] as String?,
      detention: json['detention'] as String?,
      lost: json['lost'] as String?,
    );

Map<String, dynamic> _$SingleStoplogDataToJson(SingleStoplogData instance) =>
    <String, dynamic>{
      'id': instance.id,
      'user_id': instance.userId,
      'shipper_facility_id': instance.shipperFacilityId,
      'shipper_id': instance.shipperId,
      'shipper_name': instance.shipperName,
      'facility_name': instance.facilityName,
      'bol_number': instance.bolNumber,
      'status': _$SingleStoplogStatusEnumMap[instance.status],
      'arrived_at': instance.arrivedAt?.toIso8601String(),
      'docked_at': instance.dockedAt?.toIso8601String(),
      'completed_at': instance.completedAt?.toIso8601String(),
      'departed_at': instance.departedAt?.toIso8601String(),
      'arrival_location': instance.arrivalLocation,
      'facility_address': instance.facilityAddress,
      'attachments': instance.attachments,
      'current_step': _$StopLogStepEnumMap[instance.currentStep],
      'gps_coordinates': instance.gpsCoordinates,
      'rate_per_hour': instance.ratePerHour,
      'free_wait_time': instance.freeWaitTime,
      'billable_time': instance.billableTime,
      'billable_time_text': instance.billableTimeText,
      'arrival_departure_time': instance.arrivalDepartureTime,
      'address': instance.address,
      'detention': instance.detention,
      'lost': instance.lost,
    };

const _$SingleStoplogStatusEnumMap = {
  SingleStoplogStatus.active: 'ACTIVE',
  SingleStoplogStatus.completed: 'COMPLETED',
  SingleStoplogStatus.progress: 'PROGRESS',
};

const _$StopLogStepEnumMap = {
  StopLogStep.arrivalTime: 'arrivalTime',
  StopLogStep.dockInTime: 'dockInTime',
  StopLogStep.completedTime: 'completedTime',
  StopLogStep.departureTime: 'departureTime',
  StopLogStep.uploadDocuments: 'uploadDocuments',
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
