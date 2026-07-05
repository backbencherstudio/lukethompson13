import 'package:json_annotation/json_annotation.dart';
import 'package:lukethompson/data/models/common/base.model.dart';
import 'package:lukethompson/data/models/stops/single_stoplog.model.dart';
import 'package:lukethompson/data/models/stops/stop_log.model.dart';
import 'package:lukethompson/data/models/stops/stop_log_location.model.dart';
import 'package:lukethompson/data/models/stops/stop_log_attachment.model.dart';

part 'stop_log_record_response.model.g.dart';

@JsonSerializable()
class StopLogRecordLocation {
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

  StopLogRecordLocation({
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

  factory StopLogRecordLocation.fromJson(Map<String, dynamic> json) =>
      _$StopLogRecordLocationFromJson(json);

  Map<String, dynamic> toJson() => _$StopLogRecordLocationToJson(this);

  @override
  String toString() => 'StopLogRecordLocation${toJson()}';
}

@JsonSerializable()
class StopLogRecordData {
  final String? id;

  @JsonKey(name: 'user_id')
  final String? userId;

  @JsonKey(name: 'shipper_facility_id')
  final String? shipperFacilityId;

  @JsonKey(name: 'shipper_name')
  final String? shipperName;

  @JsonKey(name: 'facility_name')
  final String? facilityName;

  @JsonKey(name: 'bol_number')
  final String? bolNumber;

  final SingleStoplogStatus? status;

  @JsonKey(name: 'arrived_at')
  final String? arrivedAt;

  @JsonKey(name: 'docked_at')
  final String? dockedAt;

  @JsonKey(name: 'completed_at')
  final String? completedAt;

  @JsonKey(name: 'departed_at')
  final String? departedAt;

  @JsonKey(name: 'arrival_location')
  final StopLogRecordLocation? arrivalLocation;

  @JsonKey(name: 'facility_address')
  final StopLogRecordLocation? facilityAddress;

  final List<StopLogAttachment>? attachments;

  @JsonKey(name: 'shipper_id')
  final String? shipperId;

  @JsonKey(name: 'current_step', fromJson: StopLogStep.fromValue, toJson: null)
  final StopLogStep? currentStep;

  StopLogRecordData({
    this.id,
    this.userId,
    this.shipperFacilityId,
    this.shipperName,
    this.facilityName,
    this.bolNumber,
    this.status,
    this.arrivedAt,
    this.dockedAt,
    this.completedAt,
    this.departedAt,
    this.arrivalLocation,
    this.facilityAddress,
    this.attachments,
    this.shipperId,
    this.currentStep,
  });

  factory StopLogRecordData.fromJson(Map<String, dynamic> json) =>
      _$StopLogRecordDataFromJson(json);

  Map<String, dynamic> toJson() => _$StopLogRecordDataToJson(this);

  @override
  String toString() => 'StopLogRecordData${toJson()}';
}

@JsonSerializable()
class StopLogRecordResponse extends BaseResponse {
  final StopLogRecordData? data;

  StopLogRecordResponse({
    required super.success,
    required super.message,
    this.data,
  });

  factory StopLogRecordResponse.fromJson(Map<String, dynamic> json) =>
      _$StopLogRecordResponseFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$StopLogRecordResponseToJson(this);

  @override
  String toString() => 'StopLogRecordResponse${toJson()}';
}
