import 'package:json_annotation/json_annotation.dart';
import 'package:lukethompson/data/models/common/base.model.dart';
import 'package:lukethompson/data/models/common/meta_data.dart';

part 'shipper.model.g.dart';

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
  final int claimsCount;

  @JsonKey(name: 'avg_pay_days')
  final int? avgPayDays;

  @JsonKey(name: 'paid_claims_count')
  final int paidClaimsCount;

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
