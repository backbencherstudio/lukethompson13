// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'stop_log_list_response.model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Rating _$RatingFromJson(Map<String, dynamic> json) =>
    Rating(id: json['id'] as String, rating: json['rating'] as String);

Map<String, dynamic> _$RatingToJson(Rating instance) => <String, dynamic>{
  'id': instance.id,
  'rating': instance.rating,
};

Broker _$BrokerFromJson(Map<String, dynamic> json) =>
    Broker(name: json['name'] as String?, email: json['email'] as String?);

Map<String, dynamic> _$BrokerToJson(Broker instance) => <String, dynamic>{
  'name': instance.name,
  'email': instance.email,
};

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
      rating: json['rating'] == null
          ? null
          : Rating.fromJson(json['rating'] as Map<String, dynamic>),
      broker: json['broker'] == null
          ? null
          : Broker.fromJson(json['broker'] as Map<String, dynamic>),
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
      'rating': instance.rating,
      'broker': instance.broker,
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

StopLogListResponse _$StopLogListResponseFromJson(Map<String, dynamic> json) =>
    StopLogListResponse(
      success: json['success'] as bool,
      message: json['message'] as String,
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => StopLogListItem.fromJson(e as Map<String, dynamic>))
          .toList(),
      metaData: json['meta_data'] == null
          ? null
          : ResponseMetaData.fromJson(
              json['meta_data'] as Map<String, dynamic>,
            ),
    );

Map<String, dynamic> _$StopLogListResponseToJson(
  StopLogListResponse instance,
) => <String, dynamic>{
  'success': instance.success,
  'message': instance.message,
  'data': instance.data,
  'meta_data': instance.metaData,
};
