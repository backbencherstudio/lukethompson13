import 'package:json_annotation/json_annotation.dart';
import 'package:lukethompson/data/models/common/base.model.dart';
import 'package:lukethompson/data/models/common/meta_data.dart';

part 'shipper.model.g.dart';

enum FacilityType {
  shipper,
  broker;

  String toJson() => name;
}

class ShipperSearchParams {
  final String? search;
  final String? cursor;
  final int? limit;
  final FacilityType? type;

  const ShipperSearchParams({this.search, this.cursor, this.limit, this.type});

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;

    return other is ShipperSearchParams &&
        other.search == search &&
        other.cursor == cursor &&
        other.limit == limit &&
        other.type == type;
  }

  @override
  int get hashCode => Object.hash(search, cursor, limit, type);
}

@JsonSerializable()
class SubmitARatingForAShipperFacilityRequest {
  const SubmitARatingForAShipperFacilityRequest({
    required this.rate,
    required this.brokerRate,
  });

  final int rate;
  final int brokerRate;

  factory SubmitARatingForAShipperFacilityRequest.fromJson(
    Map<String, dynamic> json,
  ) => _$SubmitARatingForAShipperFacilityRequestFromJson(json);

  Map<String, dynamic> toJson() =>
      _$SubmitARatingForAShipperFacilityRequestToJson(this);

  @override
  String toString() => 'SubmitARatingForAShipperFacilityRequest${toJson()}';
}

@JsonSerializable()
class ShipperRatingItem {
  final String id;

  @JsonKey(name: 'facility_name')
  final String? facilityName;

  final double? rating;

  @JsonKey(name: 'status_subtext')
  final String? statusSubtext;

  @JsonKey(name: 'claims_count')
  final int? claimsCount;

  @JsonKey(name: 'avg_pay_days')
  final int? avgPayDays;

  @JsonKey(name: 'paid_claims_count')
  final int? paidClaimsCount;

  // Broker object ======================================

  final String? name;
  final String? email;

  @JsonKey(name: 'avg_rating')
  final double? avgRating;

  @JsonKey(name: 'rating_category')
  final String? ratingCategory;

  @JsonKey(name: 'total_ratings')
  final int? totalRatings;

  @JsonKey(name: 'total_shippers')
  final int? totalShippers;

  @JsonKey(name: 'recent_shippers')
  final List<BrokerRecentShipperItem>? recentShippers;

  const ShipperRatingItem({
    required this.id,

    this.facilityName,
    this.rating,
    this.statusSubtext,
    this.claimsCount,
    this.avgPayDays,
    this.paidClaimsCount,

    this.name,
    this.email,
    this.avgRating,
    this.ratingCategory,
    this.totalRatings,
    this.totalShippers,
    this.recentShippers,
  });

  factory ShipperRatingItem.fromJson(Map<String, dynamic> json) =>
      _$ShipperRatingItemFromJson(json);

  Map<String, dynamic> toJson() => _$ShipperRatingItemToJson(this);

  @override
  String toString() => 'ShipperRatingItem${toJson()}';
}

@JsonSerializable()
class ShipperSearchFacilityItem {
  final String? id;
  final String name;
  final String? address;
  final String? lat;
  final String? lng;
  final double? rating;
  final String? email;
  final int? totalShippers;

  const ShipperSearchFacilityItem({
    this.id,
    required this.name,
    this.address,
    this.rating,
    this.lat,
    this.lng,
    this.email,
    this.totalShippers,
  });

  factory ShipperSearchFacilityItem.fromJson(Map<String, dynamic> json) =>
      _$ShipperSearchFacilityItemFromJson(json);

  Map<String, dynamic> toJson() => _$ShipperSearchFacilityItemToJson(this);

  @override
  String toString() => 'ShipperSearchFacilityItem${toJson()}';
}

@JsonSerializable()
class ShipperSearchFacilitiesResponse extends BaseResponse {
  final List<ShipperSearchFacilityItem>? data;

  @JsonKey(name: 'meta_data')
  final ResponseMetaData? metaData;

  ShipperSearchFacilitiesResponse({
    required super.success,
    required super.message,
    this.data,
    this.metaData,
  });

  factory ShipperSearchFacilitiesResponse.fromJson(Map<String, dynamic> json) =>
      _$ShipperSearchFacilitiesResponseFromJson(json);

  @override
  Map<String, dynamic> toJson() =>
      _$ShipperSearchFacilitiesResponseToJson(this);

  @override
  String toString() => 'ShipperSearchFacilitiesResponse${toJson()}';
}

@JsonSerializable()
class ShipperRatingsResponse extends BaseResponse {
  final List<ShipperRatingItem>? data;

  @JsonKey(name: 'meta_data')
  final ResponseMetaData? metaData;

  ShipperRatingsResponse({
    required super.success,
    required super.message,
    this.data,
    this.metaData,
  });

  factory ShipperRatingsResponse.fromJson(Map<String, dynamic> json) =>
      _$ShipperRatingsResponseFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$ShipperRatingsResponseToJson(this);

  @override
  String toString() => 'ShipperRatingsResponse${toJson()}';
}

@JsonSerializable()
class CreateShippperRequest {
  final String name;
  final String address;
  final double? lat;
  final double? lng;
  final String? city;
  final String? state;
  final String? zip;
  final String? country;
  final String? brokerId;
  final String? brokerName;
  final String? brokerEmail;

  CreateShippperRequest({
    required this.name,
    required this.address,
    this.lat,
    this.lng,
    this.city,
    this.state,
    this.zip,
    this.country,

    this.brokerId,
    this.brokerName,
    this.brokerEmail,
  });

  factory CreateShippperRequest.fromJson(Map<String, dynamic> json) =>
      _$CreateShippperRequestFromJson(json);

  Map<String, dynamic> toJson() => _$CreateShippperRequestToJson(this);

  @override
  String toString() => 'CreateShippperRequest${toJson()}';
}

@JsonSerializable()
class CreateBrokerRequest {
  final String name;
  final String email;
  final String phone;
  final String brokerId;
  final String address;
  final String city;
  final String state;
  final String zip;
  final String country;

  CreateBrokerRequest({
    required this.name,
    required this.email,
    required this.phone,
    required this.brokerId,
    required this.address,
    required this.city,
    required this.state,
    required this.zip,
    required this.country,
  });

  factory CreateBrokerRequest.fromJson(Map<String, dynamic> json) =>
      _$CreateBrokerRequestFromJson(json);

  Map<String, dynamic> toJson() => _$CreateBrokerRequestToJson(this);

  @override
  String toString() => 'CreateBrokerRequest${toJson()}';
}

@JsonSerializable()
class CreateBrokerResponseData {
  final String? id;

  @JsonKey(name: 'created_at')
  final String? createdAt;

  @JsonKey(name: 'updated_at')
  final String? updatedAt;

  final String? name;
  final String? email;
  final String? phone;

  @JsonKey(name: 'brokerId')
  final String? brokerId;

  @JsonKey(name: 'location_id')
  final String? locationId;

  final ShipperLocationDataModel? location;

  CreateBrokerResponseData({
    this.id,
    this.createdAt,
    this.updatedAt,
    this.name,
    this.email,
    this.phone,
    this.brokerId,
    this.locationId,
    this.location,
  });

  factory CreateBrokerResponseData.fromJson(Map<String, dynamic> json) =>
      _$CreateBrokerResponseDataFromJson(json);

  Map<String, dynamic> toJson() => _$CreateBrokerResponseDataToJson(this);

  @override
  String toString() => 'CreateBrokerResponseData${toJson()}';
}

@JsonSerializable()
class CreateShipperResponse extends BaseResponse {
  final ShipperLocationItem? data;

  CreateShipperResponse({
    required super.success,
    required super.message,
    this.data,
  });

  factory CreateShipperResponse.fromJson(Map<String, dynamic> json) =>
      _$CreateShipperResponseFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$CreateShipperResponseToJson(this);

  @override
  String toString() => 'CreateShipperResponse${toJson()}';
}

@JsonSerializable()
class CreateBrokerResponse extends BaseResponse {
  final CreateBrokerResponseData? data;

  CreateBrokerResponse({
    required super.success,
    required super.message,
    this.data,
  });

  factory CreateBrokerResponse.fromJson(Map<String, dynamic> json) =>
      _$CreateBrokerResponseFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$CreateBrokerResponseToJson(this);

  @override
  String toString() => 'CreateBrokerResponse${toJson()}';
}

@JsonSerializable()
class ShipperLocationItem {
  final String? id;

  @JsonKey(name: 'created_at')
  final String? createdAt;

  @JsonKey(name: 'updated_at')
  final String? updatedAt;

  final String? name;

  @JsonKey(name: 'normalized_name')
  final String? normalizedName;

  final String? email;
  final String? phone;

  @JsonKey(name: 'broker_id')
  final String? brokerId;

  @JsonKey(name: 'location_id')
  final String? locationId;

  final ShipperLocationDataModel? location;

  ShipperLocationItem({
    this.id,
    this.createdAt,
    this.updatedAt,
    this.name,
    this.normalizedName,
    this.email,
    this.phone,
    this.brokerId,
    this.locationId,
    this.location,
  });

  factory ShipperLocationItem.fromJson(Map<String, dynamic> json) =>
      _$ShipperLocationItemFromJson(json);

  Map<String, dynamic> toJson() => _$ShipperLocationItemToJson(this);

  @override
  String toString() => 'ShipperLocationItem${toJson()}';
}

@JsonSerializable()
class BrokerRecentShipperItem {
  final String id;
  final String name;
  final RecentShipperLocation? location;

  const BrokerRecentShipperItem({
    required this.id,
    required this.name,
    this.location,
  });

  factory BrokerRecentShipperItem.fromJson(Map<String, dynamic> json) =>
      _$BrokerRecentShipperItemFromJson(json);

  Map<String, dynamic> toJson() => _$BrokerRecentShipperItemToJson(this);

  @override
  String toString() => 'BrokerRecentShipperItem${toJson()}';
}

@JsonSerializable()
class RecentShipperLocation {
  final String? address;
  final String? city;
  final String? state;

  const RecentShipperLocation({this.address, this.city, this.state});

  factory RecentShipperLocation.fromJson(Map<String, dynamic> json) =>
      _$RecentShipperLocationFromJson(json);

  Map<String, dynamic> toJson() => _$RecentShipperLocationToJson(this);

  @override
  String toString() => 'RecentShipperLocation${toJson()}';
}

@JsonSerializable()
class ShipperLocationDataModel {
  final String? id;

  @JsonKey(name: 'created_at')
  final String? createdAt;

  @JsonKey(name: 'updated_at')
  final String? updatedAt;

  final String? city;
  final String? state;
  final String? country;
  final String? address;
  final String? zip;
  final String? lat;
  final String? lng;

  ShipperLocationDataModel({
    this.id,
    this.createdAt,
    this.updatedAt,
    this.city,
    this.state,
    this.country,
    this.address,
    this.zip,
    this.lat,
    this.lng,
  });

  factory ShipperLocationDataModel.fromJson(Map<String, dynamic> json) =>
      _$ShipperLocationDataModelFromJson(json);

  Map<String, dynamic> toJson() => _$ShipperLocationDataModelToJson(this);

  @override
  String toString() => 'ShipperLocationDataModel${toJson()}';
}
