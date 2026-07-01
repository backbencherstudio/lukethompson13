import 'package:json_annotation/json_annotation.dart';
import 'package:lukethompson/data/models/common/base.model.dart';

part 'report.model.g.dart';

@JsonSerializable()
class TopWorstStop {
  @JsonKey(name: 'facility_name')
  final String? facilityName;

  @JsonKey(name: 'waiting_hours')
  final String waitingHours;

  @JsonKey(name: 'waiting_time_text')
  final String waitingTimeText;

  TopWorstStop({
    this.facilityName,
    required this.waitingHours,
    required this.waitingTimeText,
  });

  factory TopWorstStop.fromJson(Map<String, dynamic> json) =>
      _$TopWorstStopFromJson(json);

  Map<String, dynamic> toJson() => _$TopWorstStopToJson(this);

  @override
  String toString() => 'TopWorstStop${toJson()}';
}

@JsonSerializable()
class ReportTabData {
  final String tab;

  @JsonKey(name: 'total_waiting_hours')
  final String totalWaitingHours;

  @JsonKey(name: 'total_waiting_text')
  final String totalWaitingText;

  @JsonKey(name: 'detention_captured')
  final String detentionCaptured;

  @JsonKey(name: 'revenue_lost')
  final String revenueLost;

  @JsonKey(name: 'top_worst_stop')
  final TopWorstStop? topWorstStop;

  ReportTabData({
    required this.tab,
    required this.totalWaitingHours,
    required this.totalWaitingText,
    required this.detentionCaptured,
    required this.revenueLost,
    this.topWorstStop,
  });

  factory ReportTabData.fromJson(Map<String, dynamic> json) =>
      _$ReportTabDataFromJson(json);

  Map<String, dynamic> toJson() => _$ReportTabDataToJson(this);

  @override
  String toString() => 'ReportTabData${toJson()}';
}

@JsonSerializable()
class ReportResponse extends BaseResponse {
  final List<ReportTabData>? data;

  ReportResponse({required super.success, required super.message, this.data});

  factory ReportResponse.fromJson(Map<String, dynamic> json) =>
      _$ReportResponseFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$ReportResponseToJson(this);

  @override
  String toString() => 'ReportResponse${toJson()}';
}
