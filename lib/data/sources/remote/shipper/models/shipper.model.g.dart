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
  id: json['id'] as String?,
  name: json['name'] as String,
  address: json['address'] as String?,
  rating: (json['rating'] as num?)?.toDouble(),
  lat: json['lat'] as String?,
  lng: json['lng'] as String?,
  email: json['email'] as String?,
  totalShippers: (json['totalShippers'] as num?)?.toInt(),
);

Map<String, dynamic> _$ShipperSearchFacilityItemToJson(
  ShipperSearchFacilityItem instance,
) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'address': instance.address,
  'lat': instance.lat,
  'lng': instance.lng,
  'rating': instance.rating,
  'email': instance.email,
  'totalShippers': instance.totalShippers,
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

CreateShippperRequest _$CreateShippperRequestFromJson(
  Map<String, dynamic> json,
) => CreateShippperRequest(
  name: json['name'] as String,
  address: json['address'] as String,
  lat: (json['lat'] as num?)?.toDouble(),
  lng: (json['lng'] as num?)?.toDouble(),
  city: json['city'] as String?,
  state: json['state'] as String?,
  zip: json['zip'] as String?,
  country: json['country'] as String?,
  brokerId: json['brokerId'] as String?,
  brokerName: json['brokerName'] as String?,
  brokerEmail: json['brokerEmail'] as String?,
);

Map<String, dynamic> _$CreateShippperRequestToJson(
  CreateShippperRequest instance,
) => <String, dynamic>{
  'name': instance.name,
  'address': instance.address,
  'lat': instance.lat,
  'lng': instance.lng,
  'city': instance.city,
  'state': instance.state,
  'zip': instance.zip,
  'country': instance.country,
  'brokerId': instance.brokerId,
  'brokerName': instance.brokerName,
  'brokerEmail': instance.brokerEmail,
};

CreateShipperResponse _$CreateShipperResponseFromJson(
  Map<String, dynamic> json,
) => CreateShipperResponse(
  success: json['success'] as bool,
  message: json['message'] as String,
  data: json['data'] == null
      ? null
      : ShipperLocationItem.fromJson(json['data'] as Map<String, dynamic>),
);

Map<String, dynamic> _$CreateShipperResponseToJson(
  CreateShipperResponse instance,
) => <String, dynamic>{
  'success': instance.success,
  'message': instance.message,
  'data': instance.data,
};

ShipperLocationItem _$ShipperLocationItemFromJson(Map<String, dynamic> json) =>
    ShipperLocationItem(
      id: json['id'] as String?,
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
      name: json['name'] as String?,
      normalizedName: json['normalized_name'] as String?,
      locationId: json['location_id'] as String?,
      location: json['location'] == null
          ? null
          : ShipperLocationDataModel.fromJson(
              json['location'] as Map<String, dynamic>,
            ),
    );

Map<String, dynamic> _$ShipperLocationItemToJson(
  ShipperLocationItem instance,
) => <String, dynamic>{
  'id': instance.id,
  'created_at': instance.createdAt,
  'updated_at': instance.updatedAt,
  'name': instance.name,
  'normalized_name': instance.normalizedName,
  'location_id': instance.locationId,
  'location': instance.location,
};

ShipperLocationDataModel _$ShipperLocationDataModelFromJson(
  Map<String, dynamic> json,
) => ShipperLocationDataModel(
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

Map<String, dynamic> _$ShipperLocationDataModelToJson(
  ShipperLocationDataModel instance,
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
