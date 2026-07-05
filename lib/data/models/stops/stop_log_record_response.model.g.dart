// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'stop_log_record_response.model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StopLogRecordLocation _$StopLogRecordLocationFromJson(
  Map<String, dynamic> json,
) => StopLogRecordLocation(
  id: json['id'] as String?,
  createdAt: json['created_at'] as String?,
  updatedAt: json['updated_at'] as String?,
  city: json['city'] as String?,
  state: json['state'] as String?,
  country: json['country'] as String?,
  address: json['address'] as String?,
  zip: json['zip'] as String?,
  lat: json['lat'] as String?,
  lng: json['lng'] as String?,
);

Map<String, dynamic> _$StopLogRecordLocationToJson(
  StopLogRecordLocation instance,
) => <String, dynamic>{
  'id': instance.id,
  'created_at': instance.createdAt,
  'updated_at': instance.updatedAt,
  'city': instance.city,
  'state': instance.state,
  'country': instance.country,
  'address': instance.address,
  'zip': instance.zip,
  'lat': instance.lat,
  'lng': instance.lng,
};

StopLogRecordData _$StopLogRecordDataFromJson(Map<String, dynamic> json) =>
    StopLogRecordData(
      id: json['id'] as String?,
      userId: json['user_id'] as String?,
      shipperFacilityId: json['shipper_facility_id'] as String?,
      shipperName: json['shipper_name'] as String?,
      facilityName: json['facility_name'] as String?,
      bolNumber: json['bol_number'] as String?,
      status: $enumDecodeNullable(_$SingleStoplogStatusEnumMap, json['status']),
      arrivedAt: json['arrived_at'] as String?,
      dockedAt: json['docked_at'] as String?,
      completedAt: json['completed_at'] as String?,
      departedAt: json['departed_at'] as String?,
      arrivalLocation: json['arrival_location'] == null
          ? null
          : StopLogRecordLocation.fromJson(
              json['arrival_location'] as Map<String, dynamic>,
            ),
      facilityAddress: json['facility_address'] == null
          ? null
          : StopLogRecordLocation.fromJson(
              json['facility_address'] as Map<String, dynamic>,
            ),
      attachments: (json['attachments'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      shipperId: json['shipper_id'] as String?,
      currentStep: StopLogStep.fromValue(json['current_step'] as String?),
    );

Map<String, dynamic> _$StopLogRecordDataToJson(StopLogRecordData instance) =>
    <String, dynamic>{
      'id': instance.id,
      'user_id': instance.userId,
      'shipper_facility_id': instance.shipperFacilityId,
      'shipper_name': instance.shipperName,
      'facility_name': instance.facilityName,
      'bol_number': instance.bolNumber,
      'status': _$SingleStoplogStatusEnumMap[instance.status],
      'arrived_at': instance.arrivedAt,
      'docked_at': instance.dockedAt,
      'completed_at': instance.completedAt,
      'departed_at': instance.departedAt,
      'arrival_location': instance.arrivalLocation,
      'facility_address': instance.facilityAddress,
      'attachments': instance.attachments,
      'shipper_id': instance.shipperId,
      'current_step': _$StopLogStepEnumMap[instance.currentStep],
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
};

StopLogRecordResponse _$StopLogRecordResponseFromJson(
  Map<String, dynamic> json,
) => StopLogRecordResponse(
  success: json['success'] as bool,
  message: json['message'] as String,
  data: json['data'] == null
      ? null
      : StopLogRecordData.fromJson(json['data'] as Map<String, dynamic>),
);

Map<String, dynamic> _$StopLogRecordResponseToJson(
  StopLogRecordResponse instance,
) => <String, dynamic>{
  'success': instance.success,
  'message': instance.message,
  'data': instance.data,
};
