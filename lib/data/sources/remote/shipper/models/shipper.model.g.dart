// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'shipper.model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SubmitARatingForAShipperFacilityRequest
_$SubmitARatingForAShipperFacilityRequestFromJson(Map<String, dynamic> json) =>
    SubmitARatingForAShipperFacilityRequest(
      rate: (json['rate'] as num).toInt(),
    );

Map<String, dynamic> _$SubmitARatingForAShipperFacilityRequestToJson(
  SubmitARatingForAShipperFacilityRequest instance,
) => <String, dynamic>{'rate': instance.rate};

ShipperRatingItem _$ShipperRatingItemFromJson(Map<String, dynamic> json) =>
    ShipperRatingItem(
      id: json['id'] as String,
      facilityName: json['facility_name'] as String,
      rating: (json['rating'] as num).toDouble(),
      statusSubtext: json['status_subtext'] as String,
      claimsCount: (json['claims_count'] as num?)?.toInt(),
      avgPayDays: (json['avg_pay_days'] as num?)?.toInt(),
      paidClaimsCount: (json['paid_claims_count'] as num?)?.toInt(),
    );

Map<String, dynamic> _$ShipperRatingItemToJson(ShipperRatingItem instance) =>
    <String, dynamic>{
      'id': instance.id,
      'facility_name': instance.facilityName,
      'rating': instance.rating,
      'status_subtext': instance.statusSubtext,
      'claims_count': instance.claimsCount,
      'avg_pay_days': instance.avgPayDays,
      'paid_claims_count': instance.paidClaimsCount,
    };

ShipperSearchFacilityItem _$ShipperSearchFacilityItemFromJson(
  Map<String, dynamic> json,
) => ShipperSearchFacilityItem(
  id: json['id'] as String,
  name: json['name'] as String,
  address: json['address'] as String?,
  rating: (json['rating'] as num).toDouble(),
);

Map<String, dynamic> _$ShipperSearchFacilityItemToJson(
  ShipperSearchFacilityItem instance,
) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'address': instance.address,
  'rating': instance.rating,
};

ShipperSearchFacilitiesResponse _$ShipperSearchFacilitiesResponseFromJson(
  Map<String, dynamic> json,
) => ShipperSearchFacilitiesResponse(
  success: json['success'] as bool,
  message: json['message'] as String,
  data: (json['data'] as List<dynamic>?)
      ?.map(
        (e) => ShipperSearchFacilityItem.fromJson(e as Map<String, dynamic>),
      )
      .toList(),
  metaData: json['meta_data'] == null
      ? null
      : ResponseMetaData.fromJson(json['meta_data'] as Map<String, dynamic>),
);

Map<String, dynamic> _$ShipperSearchFacilitiesResponseToJson(
  ShipperSearchFacilitiesResponse instance,
) => <String, dynamic>{
  'success': instance.success,
  'message': instance.message,
  'data': instance.data,
  'meta_data': instance.metaData,
};

ShipperRatingsResponse _$ShipperRatingsResponseFromJson(
  Map<String, dynamic> json,
) => ShipperRatingsResponse(
  success: json['success'] as bool,
  message: json['message'] as String,
  data: (json['data'] as List<dynamic>?)
      ?.map((e) => ShipperRatingItem.fromJson(e as Map<String, dynamic>))
      .toList(),
  metaData: json['meta_data'] == null
      ? null
      : ResponseMetaData.fromJson(json['meta_data'] as Map<String, dynamic>),
);

Map<String, dynamic> _$ShipperRatingsResponseToJson(
  ShipperRatingsResponse instance,
) => <String, dynamic>{
  'success': instance.success,
  'message': instance.message,
  'data': instance.data,
  'meta_data': instance.metaData,
};
