import 'package:json_annotation/json_annotation.dart';

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
