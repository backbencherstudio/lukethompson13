// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'active_stoplog.model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ActiveStoplogData _$ActiveStoplogDataFromJson(Map<String, dynamic> json) =>
    ActiveStoplogData(id: json['id'] as String);

Map<String, dynamic> _$ActiveStoplogDataToJson(ActiveStoplogData instance) =>
    <String, dynamic>{'id': instance.id};

ActiveStoplogResponse _$ActiveStoplogResponseFromJson(
  Map<String, dynamic> json,
) => ActiveStoplogResponse(
  success: json['success'] as bool,
  message: json['message'] as String,
  data: json['data'] == null
      ? null
      : ActiveStoplogData.fromJson(json['data'] as Map<String, dynamic>),
);

Map<String, dynamic> _$ActiveStoplogResponseToJson(
  ActiveStoplogResponse instance,
) => <String, dynamic>{
  'success': instance.success,
  'message': instance.message,
  'data': instance.data,
};
