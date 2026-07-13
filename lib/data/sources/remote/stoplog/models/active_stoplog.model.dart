import 'package:json_annotation/json_annotation.dart';
import 'package:lukethompson/data/models/common/base.model.dart';

part 'active_stoplog.model.g.dart';

@JsonSerializable()
class ActiveStoplogData {
  final String id;

  ActiveStoplogData({required this.id});

  factory ActiveStoplogData.fromJson(Map<String, dynamic> json) =>
      _$ActiveStoplogDataFromJson(json);

  Map<String, dynamic> toJson() => _$ActiveStoplogDataToJson(this);

  @override
  String toString() => 'ActiveStoplogData${toJson()}';
}

@JsonSerializable()
class ActiveStoplogResponse extends BaseResponse {
  final ActiveStoplogData? data;

  ActiveStoplogResponse({
    required super.success,
    required super.message,
    this.data,
  });

  factory ActiveStoplogResponse.fromJson(Map<String, dynamic> json) =>
      _$ActiveStoplogResponseFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$ActiveStoplogResponseToJson(this);

  @override
  String toString() => 'ActiveStoplogResponse${toJson()}';
}
