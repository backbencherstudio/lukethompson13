// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'report.model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TopWorstStop _$TopWorstStopFromJson(Map<String, dynamic> json) => TopWorstStop(
  facilityName: json['facility_name'] as String?,
  waitingHours: json['waiting_hours'] as String,
  waitingTimeText: json['waiting_time_text'] as String,
);

Map<String, dynamic> _$TopWorstStopToJson(TopWorstStop instance) =>
    <String, dynamic>{
      'facility_name': instance.facilityName,
      'waiting_hours': instance.waitingHours,
      'waiting_time_text': instance.waitingTimeText,
    };

ReportTabData _$ReportTabDataFromJson(Map<String, dynamic> json) =>
    ReportTabData(
      tab: json['tab'] as String,
      totalWaitingHours: json['total_waiting_hours'] as String,
      totalWaitingText: json['total_waiting_text'] as String,
      detentionCaptured: json['detention_captured'] as String,
      revenueLost: json['revenue_lost'] as String,
      topWorstStop: json['top_worst_stop'] == null
          ? null
          : TopWorstStop.fromJson(
              json['top_worst_stop'] as Map<String, dynamic>,
            ),
    );

Map<String, dynamic> _$ReportTabDataToJson(ReportTabData instance) =>
    <String, dynamic>{
      'tab': instance.tab,
      'total_waiting_hours': instance.totalWaitingHours,
      'total_waiting_text': instance.totalWaitingText,
      'detention_captured': instance.detentionCaptured,
      'revenue_lost': instance.revenueLost,
      'top_worst_stop': instance.topWorstStop,
    };

TaxReportDateRange _$TaxReportDateRangeFromJson(Map<String, dynamic> json) =>
    TaxReportDateRange(
      start: json['start'] as String,
      end: json['end'] as String,
    );

Map<String, dynamic> _$TaxReportDateRangeToJson(TaxReportDateRange instance) =>
    <String, dynamic>{'start': instance.start, 'end': instance.end};

RevenueRealization _$RevenueRealizationFromJson(Map<String, dynamic> json) =>
    RevenueRealization(
      label: json['label'] as String,
      claimed: json['claimed'] as String,
      collected: json['collected'] as String,
    );

Map<String, dynamic> _$RevenueRealizationToJson(RevenueRealization instance) =>
    <String, dynamic>{
      'label': instance.label,
      'claimed': instance.claimed,
      'collected': instance.collected,
    };

TaxReportData _$TaxReportDataFromJson(Map<String, dynamic> json) =>
    TaxReportData(
      tab: json['tab'] as String,
      period: json['period'] as String,
      dateRange: json['date_range'] == null
          ? null
          : TaxReportDateRange.fromJson(
              json['date_range'] as Map<String, dynamic>,
            ),
      totalClaimed: json['total_claimed'] as String,
      totalCollected: json['total_collected'] as String,
      collectionRate: json['collection_rate'] as String,
      avgDaysToPay: json['avg_days_to_pay'] as String,
      avgDaysToPayText: json['avg_days_to_pay_text'] as String,
      revenueLost: json['revenue_lost'] as String,
      revenueRealization: (json['revenue_realization'] as List<dynamic>?)
          ?.map((e) => RevenueRealization.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$TaxReportDataToJson(TaxReportData instance) =>
    <String, dynamic>{
      'tab': instance.tab,
      'period': instance.period,
      'date_range': instance.dateRange,
      'total_claimed': instance.totalClaimed,
      'total_collected': instance.totalCollected,
      'collection_rate': instance.collectionRate,
      'avg_days_to_pay': instance.avgDaysToPay,
      'avg_days_to_pay_text': instance.avgDaysToPayText,
      'revenue_lost': instance.revenueLost,
      'revenue_realization': instance.revenueRealization,
    };

TaxReportResponse _$TaxReportResponseFromJson(Map<String, dynamic> json) =>
    TaxReportResponse(
      success: json['success'] as bool,
      message: json['message'] as String,
      data: json['data'] == null
          ? null
          : TaxReportData.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$TaxReportResponseToJson(TaxReportResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
      'message': instance.message,
      'data': instance.data,
    };

WeeklyReportSummaryResponse _$WeeklyReportSummaryResponseFromJson(
  Map<String, dynamic> json,
) => WeeklyReportSummaryResponse(
  success: json['success'] as bool,
  message: json['message'] as String,
  data: json['data'] == null
      ? null
      : ReportTabData.fromJson(json['data'] as Map<String, dynamic>),
);

Map<String, dynamic> _$WeeklyReportSummaryResponseToJson(
  WeeklyReportSummaryResponse instance,
) => <String, dynamic>{
  'success': instance.success,
  'message': instance.message,
  'data': instance.data,
};
