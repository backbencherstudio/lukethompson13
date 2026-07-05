import 'package:json_annotation/json_annotation.dart';
import 'package:lukethompson/data/models/common/base.model.dart';
import 'package:lukethompson/data/models/stops/stop_log.model.dart';
import 'package:lukethompson/data/models/stops/stop_log_location.model.dart';
import 'package:lukethompson/data/models/stops/stop_log_attachment.model.dart';

part 'single_stoplog.model.g.dart';

@JsonSerializable()
class SingleStoplogData {
  final String? id;

  @JsonKey(name: 'user_id')
  final String? userId;

  @JsonKey(name: 'shipper_facility_id')
  final String? shipperFacilityId;

  @JsonKey(name: 'shipper_id')
  final String? shipperId;

  @JsonKey(name: 'shipper_name')
  final String? shipperName;

  @JsonKey(name: 'facility_name')
  final String? facilityName;

  @JsonKey(name: 'bol_number')
  final String? bolNumber;

  final SingleStoplogStatus? status;

  @JsonKey(name: 'arrived_at')
  final DateTime? arrivedAt;

  @JsonKey(name: 'docked_at')
  final DateTime? dockedAt;

  @JsonKey(name: 'completed_at')
  final DateTime? completedAt;

  @JsonKey(name: 'departed_at')
  final DateTime? departedAt;

  @JsonKey(name: 'arrival_location')
  final StopLogLocation? arrivalLocation;

  @JsonKey(name: 'facility_address')
  final StopLogLocation? facilityAddress;

  final List<StopLogAttachment>? attachments;

  @JsonKey(name: 'current_step', fromJson: StopLogStep.fromValue, toJson: null)
  final StopLogStep? currentStep;

  SingleStoplogData({
    this.id,
    this.userId,
    this.shipperFacilityId,
    this.shipperId,
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
    this.currentStep,
  });

  factory SingleStoplogData.fromJson(Map<String, dynamic> json) =>
      _$SingleStoplogDataFromJson(json);

  Map<String, dynamic> toJson() => _$SingleStoplogDataToJson(this);

  @override
  String toString() => 'SingleStoplogData${toJson()}';
}

@JsonSerializable()
class SingleStoplogResponse extends BaseResponse {
  final SingleStoplogData? data;

  SingleStoplogResponse({
    required super.success,
    required super.message,
    this.data,
  });

  factory SingleStoplogResponse.fromJson(Map<String, dynamic> json) =>
      _$SingleStoplogResponseFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$SingleStoplogResponseToJson(this);

  @override
  String toString() => 'SingleStoplogResponse${toJson()}';
}

enum SingleStoplogStatus {
  @JsonValue('ACTIVE')
  active,
  @JsonValue('COMPLETED')
  completed,
  @JsonValue('PROGRESS')
  progress,
}
