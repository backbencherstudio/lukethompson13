// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'meta_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ResponseFilter _$ResponseFilterFromJson(Map<String, dynamic> json) =>
    ResponseFilter(status: json['status'] as String);

Map<String, dynamic> _$ResponseFilterToJson(ResponseFilter instance) =>
    <String, dynamic>{'status': instance.status};

ResponseMetaData _$ResponseMetaDataFromJson(Map<String, dynamic> json) =>
    ResponseMetaData(
      nextCursor: json['next_cursor'] as String?,
      limit: (json['limit'] as num).toInt(),
      filters: ResponseFilter.fromJson(json['filters'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ResponseMetaDataToJson(ResponseMetaData instance) =>
    <String, dynamic>{
      'next_cursor': instance.nextCursor,
      'limit': instance.limit,
      'filters': instance.filters,
    };
