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
