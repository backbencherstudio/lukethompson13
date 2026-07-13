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
class TaxReportDateRange {
  final String start;
  final String end;

  TaxReportDateRange({required this.start, required this.end});

  factory TaxReportDateRange.fromJson(Map<String, dynamic> json) =>
      _$TaxReportDateRangeFromJson(json);

  Map<String, dynamic> toJson() => _$TaxReportDateRangeToJson(this);

  @override
  String toString() => 'TaxReportDateRange${toJson()}';
}

@JsonSerializable()
class RevenueRealization {
  final String label;
  final String claimed;
  final String collected;

  RevenueRealization({
    required this.label,
    required this.claimed,
    required this.collected,
  });

  factory RevenueRealization.fromJson(Map<String, dynamic> json) =>
      _$RevenueRealizationFromJson(json);

  Map<String, dynamic> toJson() => _$RevenueRealizationToJson(this);

  @override
  String toString() => 'RevenueRealization${toJson()}';

  static List<RevenueRealization> get mock => [
    RevenueRealization(label: 'Jan', claimed: '400', collected: '340'),
    RevenueRealization(label: 'Feb', claimed: '250', collected: '200'),
    RevenueRealization(label: 'Mar', claimed: '400', collected: '300'),
    RevenueRealization(label: 'Apr', claimed: '300', collected: '200'),
    RevenueRealization(label: 'May', claimed: '400', collected: '350'),
    RevenueRealization(label: 'Jun', claimed: '330', collected: '270'),
    RevenueRealization(label: 'Jul', claimed: '200', collected: '200'),
    RevenueRealization(label: 'Aug', claimed: '200', collected: '200'),
    RevenueRealization(label: 'Sep', claimed: '200', collected: '200'),
    RevenueRealization(label: 'Nov', claimed: '200', collected: '200'),
    RevenueRealization(label: 'Dec', claimed: '200', collected: '200'),
  ];
}

@JsonSerializable()
class TaxReportData {
  final String tab;
  final String period;

  @JsonKey(name: 'date_range')
  final TaxReportDateRange? dateRange;

  @JsonKey(name: 'total_claimed')
  final String totalClaimed;

  @JsonKey(name: 'total_collected')
  final String totalCollected;

  @JsonKey(name: 'collection_rate')
  final String collectionRate;

  @JsonKey(name: 'avg_days_to_pay')
  final String avgDaysToPay;

  @JsonKey(name: 'avg_days_to_pay_text')
  final String avgDaysToPayText;

  @JsonKey(name: 'revenue_lost')
  final String revenueLost;

  @JsonKey(name: 'revenue_realization')
  final List<RevenueRealization>? revenueRealization;

  TaxReportData({
    required this.tab,
    required this.period,
    this.dateRange,
    required this.totalClaimed,
    required this.totalCollected,
    required this.collectionRate,
    required this.avgDaysToPay,
    required this.avgDaysToPayText,
    required this.revenueLost,
    this.revenueRealization,
  });

  factory TaxReportData.fromJson(Map<String, dynamic> json) =>
      _$TaxReportDataFromJson(json);

  Map<String, dynamic> toJson() => _$TaxReportDataToJson(this);

  @override
  String toString() => 'TaxReportData${toJson()}';
}

@JsonSerializable()
class TaxReportResponse extends BaseResponse {
  final TaxReportData? data;

  TaxReportResponse({
    required super.success,
    required super.message,
    this.data,
  });

  factory TaxReportResponse.fromJson(Map<String, dynamic> json) =>
      _$TaxReportResponseFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$TaxReportResponseToJson(this);

  @override
  String toString() => 'TaxReportResponse${toJson()}';
}

enum TaxReportDataPeriod {
  monthly('MONTHLY'),
  yearly('YEARLY');

  final String value;
  const TaxReportDataPeriod(this.value);

  @override
  String toString() => value;
}

@JsonSerializable()
class WeeklyReportSummaryResponse extends BaseResponse {
  final ReportTabData? data;

  WeeklyReportSummaryResponse({
    required super.success,
    required super.message,
    this.data,
  });

  factory WeeklyReportSummaryResponse.fromJson(Map<String, dynamic> json) =>
      _$WeeklyReportSummaryResponseFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$WeeklyReportSummaryResponseToJson(this);

  @override
  String toString() => 'WeeklyReportSummaryResponse${toJson()}';
}
