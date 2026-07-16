import 'package:json_annotation/json_annotation.dart';
import 'package:lukethompson/data/models/common/base.model.dart';
import 'package:lukethompson/data/models/common/meta_data.dart';

part 'shipper.model.g.dart';

class ShipperSearchParams {
  final String? search;
  final String? cursor;
  final int? limit;

  const ShipperSearchParams({this.search, this.cursor, this.limit});

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;

    return other is ShipperSearchParams &&
        other.search == search &&
        other.cursor == cursor &&
        other.limit == limit;
  }

  @override
  int get hashCode => Object.hash(search, cursor, limit);
}

@JsonSerializable()
class SubmitARatingForAShipperFacilityRequest {
  const SubmitARatingForAShipperFacilityRequest({required this.rate});

  final int rate;

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
  final String facilityName;

  final double rating;

  @JsonKey(name: 'status_subtext')
  final String statusSubtext;

  @JsonKey(name: 'claims_count')
  final int? claimsCount;

  @JsonKey(name: 'avg_pay_days')
  final int? avgPayDays;

  @JsonKey(name: 'paid_claims_count')
  final int? paidClaimsCount;

  const ShipperRatingItem({
    required this.id,
    required this.facilityName,
    required this.rating,
    required this.statusSubtext,
    required this.claimsCount,
    this.avgPayDays,
    required this.paidClaimsCount,
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
  final double? rating;

  const ShipperSearchFacilityItem({
    this.id,
    required this.name,
    this.address,
    this.rating,
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
