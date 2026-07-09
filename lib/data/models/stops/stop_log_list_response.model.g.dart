// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'stop_log_list_response.model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StopLogListItem _$StopLogListItemFromJson(Map<String, dynamic> json) =>
    StopLogListItem(
      id: json['id'] as String,
      facilityName: json['facility_name'] as String,
      shipperFacilityId: json['shipper_facility_id'] as String,
      date: json['date'] as String,
      amount: json['amount'] as String,
      status: $enumDecodeNullable(_$StopLogStatusEnumMap, json['status']),
      claimStatus: $enumDecodeNullable(
        _$ClaimStatusEnumMap,
        json['claim_status'],
      ),
    );

Map<String, dynamic> _$StopLogListItemToJson(StopLogListItem instance) =>
    <String, dynamic>{
      'id': instance.id,
      'facility_name': instance.facilityName,
      'shipper_facility_id': instance.shipperFacilityId,
      'date': instance.date,
      'amount': instance.amount,
      'status': _$StopLogStatusEnumMap[instance.status],
      'claim_status': _$ClaimStatusEnumMap[instance.claimStatus],
    };

const _$StopLogStatusEnumMap = {
  StopLogStatus.all: 'ALL',
  StopLogStatus.active: 'ACTIVE',
  StopLogStatus.completed: 'COMPLETED',
};

const _$ClaimStatusEnumMap = {
  ClaimStatus.draft: 'DRAFT',
  ClaimStatus.submitted: 'SUBMITTED',
  ClaimStatus.paid: 'PAID',
  ClaimStatus.unpaid: 'UNPAID',
  ClaimStatus.denied: 'DENIED',
};

MetaDataFilters _$MetaDataFiltersFromJson(Map<String, dynamic> json) =>
    MetaDataFilters(
      status: $enumDecode(_$StopLogStatusEnumMap, json['status']),
    );

Map<String, dynamic> _$MetaDataFiltersToJson(MetaDataFilters instance) =>
    <String, dynamic>{'status': _$StopLogStatusEnumMap[instance.status]!};

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

StopLogListResponse _$StopLogListResponseFromJson(Map<String, dynamic> json) =>
    StopLogListResponse(
      success: json['success'] as bool,
      message: json['message'] as String,
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => StopLogListItem.fromJson(e as Map<String, dynamic>))
          .toList(),
      metaData: json['meta_data'] == null
          ? null
          : MetaData.fromJson(json['meta_data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$StopLogListResponseToJson(
  StopLogListResponse instance,
) => <String, dynamic>{
  'success': instance.success,
  'message': instance.message,
  'data': instance.data,
  'meta_data': instance.metaData,
};
