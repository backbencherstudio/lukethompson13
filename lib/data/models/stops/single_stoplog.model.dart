import 'package:json_annotation/json_annotation.dart';
import 'package:lukethompson/data/models/common/base.model.dart';

part 'single_stoplog.model.g.dart';

@JsonSerializable()
class SingleStoplogData {
  final String id;

  @JsonKey(name: 'status')
  final SingleStoplogStatus status;

  @JsonKey(name: 'facility_name')
  final String facilityName;

  @JsonKey(name: 'arrived_at')
  final DateTime arrivedAt;

  @JsonKey(name: 'departed_at')
  final DateTime? departedAt;

  @JsonKey(name: 'bol_number')
  final String? bolNumber;

  @JsonKey(name: 'gps_coordinates')
  final String? gpsCoordinates;

  @JsonKey(name: 'rate_per_hour')
  final int ratePerHour;

  @JsonKey(name: 'free_wait_time')
  final int freeWaitTime;

  @JsonKey(name: 'billable_time')
  final String billableTime;

  @JsonKey(name: 'billable_time_text')
  final String billableTimeText;

  @JsonKey(name: 'arrival_departure_time')
  final String arrivalDepartureTime;

  final String address;
  final String detention;
  final String lost;
  final List<String> attachments;
  final dynamic claim;

  SingleStoplogData({
    required this.id,
    required this.status,
    required this.facilityName,
    required this.arrivedAt,
    this.departedAt,
    this.bolNumber,
    this.gpsCoordinates,
    required this.ratePerHour,
    required this.freeWaitTime,
    required this.billableTime,
    required this.billableTimeText,
    required this.arrivalDepartureTime,
    required this.address,
    required this.detention,
    required this.lost,
    required this.attachments,
    this.claim,
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
  progress;
}
