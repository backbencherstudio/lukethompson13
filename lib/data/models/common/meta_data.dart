import 'package:json_annotation/json_annotation.dart';

part 'meta_data.g.dart';

@JsonSerializable()
class ResponseFilter {
  final String? status;

  ResponseFilter({this.status});

  factory ResponseFilter.fromJson(Map<String, dynamic> json) =>
      _$ResponseFilterFromJson(json);

  Map<String, dynamic> toJson() => _$ResponseFilterToJson(this);

  @override
  String toString() => 'ResponseFilter${toJson()}';
}

@JsonSerializable()
class ResponseMetaData {
  @JsonKey(name: 'next_cursor')
  final String? nextCursor;

  final int limit;

  final ResponseFilter? filters;

  ResponseMetaData({this.nextCursor, required this.limit, this.filters});

  factory ResponseMetaData.fromJson(Map<String, dynamic> json) =>
      _$ResponseMetaDataFromJson(json);

  Map<String, dynamic> toJson() => _$ResponseMetaDataToJson(this);

  @override
  String toString() => 'ResponseMetaData${toJson()}';
}
