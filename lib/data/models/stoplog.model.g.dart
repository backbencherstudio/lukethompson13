// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'stoplog.model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HomeDataOverviewResponse _$HomeDataOverviewResponseFromJson(
  Map<String, dynamic> json,
) => HomeDataOverviewResponse(
  success: json['success'] as bool,
  message: json['message'] as String,
  data: json['data'] == null
      ? null
      : HomeDataOverview.fromJson(json['data'] as Map<String, dynamic>),
);

Map<String, dynamic> _$HomeDataOverviewResponseToJson(
  HomeDataOverviewResponse instance,
) => <String, dynamic>{
  'success': instance.success,
  'message': instance.message,
  'data': instance.data,
};

HomeDataOverview _$HomeDataOverviewFromJson(Map<String, dynamic> json) =>
    HomeDataOverview(
      totalDetention: json['total_detention'] as String,
      totalLost: json['total_lost'] as String,
      totalStops: (json['total_stops'] as num).toInt(),
      claimedStops: (json['claimed_stops'] as num).toInt(),
      totalHours: json['total_hours'] as String,
      avgHoursPerStop: json['avg_hours_per_stop'] as String,
      avgHoursPerStopText: json['avg_hours_per_stop_text'] as String,
      collectionRate: json['collection_rate'] as String,
      collectionRateChange: json['collection_rate_change'] as String,
      weeklyActivity: json['weekly_activity'] == null
          ? null
          : WeeklyActivity.fromJson(
              json['weekly_activity'] as Map<String, dynamic>,
            ),
    );

Map<String, dynamic> _$HomeDataOverviewToJson(HomeDataOverview instance) =>
    <String, dynamic>{
      'total_detention': instance.totalDetention,
      'total_lost': instance.totalLost,
      'total_stops': instance.totalStops,
      'claimed_stops': instance.claimedStops,
      'total_hours': instance.totalHours,
      'avg_hours_per_stop': instance.avgHoursPerStop,
      'avg_hours_per_stop_text': instance.avgHoursPerStopText,
      'collection_rate': instance.collectionRate,
      'collection_rate_change': instance.collectionRateChange,
      'weekly_activity': instance.weeklyActivity,
    };

WeeklyActivity _$WeeklyActivityFromJson(Map<String, dynamic> json) =>
    WeeklyActivity(
      totalStops: (json['total_stops'] as num).toInt(),
      data: (json['data'] as List<dynamic>)
          .map((e) => DayData.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$WeeklyActivityToJson(WeeklyActivity instance) =>
    <String, dynamic>{
      'total_stops': instance.totalStops,
      'data': instance.data,
    };

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

ReportResponse _$ReportResponseFromJson(Map<String, dynamic> json) =>
    ReportResponse(
      success: json['success'] as bool,
      message: json['message'] as String,
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => ReportTabData.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ReportResponseToJson(ReportResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
      'message': instance.message,
      'data': instance.data,
    };

DayData _$DayDataFromJson(Map<String, dynamic> json) => DayData(
  day: json['day'] as String,
  totalStops: (json['total_stops'] as num).toInt(),
);

Map<String, dynamic> _$DayDataToJson(DayData instance) => <String, dynamic>{
  'day': instance.day,
  'total_stops': instance.totalStops,
};
