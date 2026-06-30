import 'package:json_annotation/json_annotation.dart';
import 'package:lukethompson/data/models/base.model.dart';

part 'stoplog.model.g.dart';

enum HomeDataPeriod {
  today('TODAY'),
  week('WEEK'),
  month('MONTH'),
  year('YEAR');

  final String value;
  const HomeDataPeriod(this.value);

  @override
  String toString() => value;
}

@JsonSerializable()
class HomeDataOverviewResponse extends BaseResponse {
  final HomeDataOverview? data;

  HomeDataOverviewResponse({
    required super.success,
    required super.message,
    this.data,
  });

  factory HomeDataOverviewResponse.fromJson(Map<String, dynamic> json) =>
      _$HomeDataOverviewResponseFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$HomeDataOverviewResponseToJson(this);

  @override
  String toString() => 'HomeDataOverviewResponse${toJson()}';
}

@JsonSerializable()
class HomeDataOverview {
  @JsonKey(name: 'total_detention')
  final String totalDetention;

  @JsonKey(name: 'total_lost')
  final String totalLost;

  @JsonKey(name: 'total_stops')
  final int totalStops;

  @JsonKey(name: 'claimed_stops')
  final int claimedStops;

  @JsonKey(name: 'total_hours')
  final String totalHours;

  @JsonKey(name: 'avg_hours_per_stop')
  final String avgHoursPerStop;

  @JsonKey(name: 'avg_hours_per_stop_text')
  final String avgHoursPerStopText;

  @JsonKey(name: 'collection_rate')
  final String collectionRate;

  @JsonKey(name: 'collection_rate_change')
  final String collectionRateChange;

  @JsonKey(name: 'weekly_activity')
  final WeeklyActivity? weeklyActivity;

  HomeDataOverview({
    required this.totalDetention,
    required this.totalLost,
    required this.totalStops,
    required this.claimedStops,
    required this.totalHours,
    required this.avgHoursPerStop,
    required this.avgHoursPerStopText,
    required this.collectionRate,
    required this.collectionRateChange,
    this.weeklyActivity,
  });

  factory HomeDataOverview.fromJson(Map<String, dynamic> json) =>
      _$HomeDataOverviewFromJson(json);

  Map<String, dynamic> toJson() => _$HomeDataOverviewToJson(this);

  @override
  String toString() => 'HomeDataOverview${toJson()}';
}

@JsonSerializable()
class WeeklyActivity {
  @JsonKey(name: 'total_stops')
  final int totalStops;

  final List<DayData> data;

  WeeklyActivity({required this.totalStops, required this.data});

  factory WeeklyActivity.fromJson(Map<String, dynamic> json) =>
      _$WeeklyActivityFromJson(json);

  Map<String, dynamic> toJson() => _$WeeklyActivityToJson(this);

  @override
  String toString() => 'WeeklyActivity${toJson()}';
}

@JsonSerializable()
class TopWorstStop {
  @JsonKey(name: 'facility_name')
  final String? facilityNamefoo;

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

@JsonSerializable()
class DayData {
  final String day;

  @JsonKey(name: 'total_stops')
  final int totalStops;

  DayData({required this.day, required this.totalStops});

  factory DayData.fromJson(Map<String, dynamic> json) =>
      _$DayDataFromJson(json);

  Map<String, dynamic> toJson() => _$DayDataToJson(this);

  @override
  String toString() => 'DayData${toJson()}';
}
