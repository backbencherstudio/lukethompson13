import 'package:json_annotation/json_annotation.dart';
import 'package:lukethompson/data/models/common/base.model.dart';

part 'stop_log_response.model.g.dart';

@JsonSerializable()
class StopLog {
  final String id;

  @JsonKey(name: 'facility_name')
  final String facilityName;

  @JsonKey(name: 'shipper_facility_id')
  final String shipperFacilityId;

  final String date;

  final String amount;

  final String status;

  StopLog({
    required this.id,
    required this.facilityName,
    required this.shipperFacilityId,
    required this.date,
    required this.amount,
    required this.status,
  });

  factory StopLog.fromJson(Map<String, dynamic> json) =>
      _$StopLogFromJson(json);

  Map<String, dynamic> toJson() => _$StopLogToJson(this);

  @override
  String toString() => 'StopLog${toJson()}';
}

@JsonSerializable()
class MetaDataFilters {
  final String status;

  MetaDataFilters({required this.status});

  factory MetaDataFilters.fromJson(Map<String, dynamic> json) =>
      _$MetaDataFiltersFromJson(json);

  Map<String, dynamic> toJson() => _$MetaDataFiltersToJson(this);

  @override
  String toString() => 'MetaDataFilters${toJson()}';
}

@JsonSerializable()
class MetaData {
  @JsonKey(name: 'next_cursor')
  final String? nextCursor;

  final int limit;

  final MetaDataFilters filters;

  MetaData({
    this.nextCursor,
    required this.limit,
    required this.filters,
  });

  factory MetaData.fromJson(Map<String, dynamic> json) =>
      _$MetaDataFromJson(json);

  Map<String, dynamic> toJson() => _$MetaDataToJson(this);

  @override
  String toString() => 'MetaData${toJson()}';
}

@JsonSerializable()
class StopLogResponse extends BaseResponse {
  final List<StopLog>? data;

  @JsonKey(name: 'meta_data')
  final MetaData? metaData;

  StopLogResponse({
    required super.success,
    required super.message,
    this.data,
    this.metaData,
  });

  factory StopLogResponse.fromJson(Map<String, dynamic> json) =>
      _$StopLogResponseFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$StopLogResponseToJson(this);

  @override
  String toString() => 'StopLogResponse${toJson()}';
}
