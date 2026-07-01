// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'stop_log_response.model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StopLog _$StopLogFromJson(Map<String, dynamic> json) => StopLog(
  id: json['id'] as String,
  facilityName: json['facility_name'] as String,
  shipperFacilityId: json['shipper_facility_id'] as String,
  date: json['date'] as String,
  amount: json['amount'] as String,
  status: json['status'] as String,
);

Map<String, dynamic> _$StopLogToJson(StopLog instance) => <String, dynamic>{
  'id': instance.id,
  'facility_name': instance.facilityName,
  'shipper_facility_id': instance.shipperFacilityId,
  'date': instance.date,
  'amount': instance.amount,
  'status': instance.status,
};

MetaDataFilters _$MetaDataFiltersFromJson(Map<String, dynamic> json) =>
    MetaDataFilters(status: json['status'] as String);

Map<String, dynamic> _$MetaDataFiltersToJson(MetaDataFilters instance) =>
    <String, dynamic>{'status': instance.status};

MetaData _$MetaDataFromJson(Map<String, dynamic> json) => MetaData(
  nextCursor: json['next_cursor'] as String?,
  limit: (json['limit'] as num).toInt(),
  filters: MetaDataFilters.fromJson(json['filters'] as Map<String, dynamic>),
);

Map<String, dynamic> _$MetaDataToJson(MetaData instance) => <String, dynamic>{
  'next_cursor': instance.nextCursor,
  'limit': instance.limit,
  'filters': instance.filters,
};

StopLogResponse _$StopLogResponseFromJson(Map<String, dynamic> json) =>
    StopLogResponse(
      success: json['success'] as bool,
      message: json['message'] as String,
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => StopLog.fromJson(e as Map<String, dynamic>))
          .toList(),
      metaData: json['meta_data'] == null
          ? null
          : MetaData.fromJson(json['meta_data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$StopLogResponseToJson(StopLogResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
      'message': instance.message,
      'data': instance.data,
      'meta_data': instance.metaData,
    };
