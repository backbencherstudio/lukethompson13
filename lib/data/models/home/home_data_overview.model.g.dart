// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_data_overview.model.dart';

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

DayData _$DayDataFromJson(Map<String, dynamic> json) => DayData(
  day: json['day'] as String,
  totalStops: (json['total_stops'] as num).toInt(),
);

Map<String, dynamic> _$DayDataToJson(DayData instance) => <String, dynamic>{
  'day': instance.day,
  'total_stops': instance.totalStops,
};
