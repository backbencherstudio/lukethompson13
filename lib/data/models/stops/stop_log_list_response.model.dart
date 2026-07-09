import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:lukethompson/core/resource/constants/color_manager.dart';
import 'package:lukethompson/core/resource/constants/status_colorable.dart';
import 'package:lukethompson/data/models/common/base.model.dart';

part 'stop_log_list_response.model.g.dart';

@JsonEnum(valueField: 'value')
enum StopLogStatus implements StatusColorable {
  all('ALL', 'All', ColorManager.infoColor),
  active('ACTIVE', 'Active', ColorManager.infoColor),
  completed('COMPLETED', 'Completed', ColorManager.successColor);

  const StopLogStatus(this.value, this.displayName, this.badgeColor);

  final String value;
  @override
  final String displayName;
  @override
  final Color badgeColor;
}

@JsonEnum(valueField: 'value')
enum ClaimStatus implements StatusColorable {
  draft('DRAFT', 'No Claim', ColorManager.subtextColor),
  submitted('SUBMITTED', 'Submitted', ColorManager.warningColor),
  paid('PAID', 'Paid', ColorManager.successColor),
  unpaid('UNPAID', 'Unpaid', ColorManager.errorColor),
  denied('DENIED', 'Denied', ColorManager.errorColor);

  const ClaimStatus(this.value, this.displayName, this.badgeColor);

  final String value;
  @override
  final String displayName;
  @override
  final Color badgeColor;
}

@JsonSerializable()
class StopLogListItem {
  final String id;

  @JsonKey(name: 'facility_name')
  final String facilityName;

  @JsonKey(name: 'shipper_facility_id')
  final String shipperFacilityId;

  final String date;

  final String amount;

  final StopLogStatus? status;

  @JsonKey(name: 'claim_status')
  final ClaimStatus? claimStatus;

  StopLogListItem({
    required this.id,
    required this.facilityName,
    required this.shipperFacilityId,
    required this.date,
    required this.amount,
    required this.status,
    required this.claimStatus,
  });

  factory StopLogListItem.fromJson(Map<String, dynamic> json) =>
      _$StopLogListItemFromJson(json);

  Map<String, dynamic> toJson() => _$StopLogListItemToJson(this);

  @override
  String toString() => 'StopLog${toJson()}';
}

@JsonSerializable()
class MetaDataFilters {
  final StopLogStatus status;

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

  MetaData({this.nextCursor, required this.limit, required this.filters});

  factory MetaData.fromJson(Map<String, dynamic> json) =>
      _$MetaDataFromJson(json);

  Map<String, dynamic> toJson() => _$MetaDataToJson(this);

  @override
  String toString() => 'MetaData${toJson()}';
}

@JsonSerializable()
class StopLogListResponse extends BaseResponse {
  final List<StopLogListItem>? data;

  @JsonKey(name: 'meta_data')
  final MetaData? metaData;

  StopLogListResponse({
    required super.success,
    required super.message,
    this.data,
    this.metaData,
  });

  factory StopLogListResponse.fromJson(Map<String, dynamic> json) =>
      _$StopLogListResponseFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$StopLogListResponseToJson(this);

  @override
  String toString() => 'StopLogListResponse${toJson()}';
}

class StopLogListParams {
  final String? cursor;
  final int? limit;
  final String? search;
  final StopLogStatus? status;

  const StopLogListParams({this.cursor, this.limit, this.search, this.status});

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is StopLogListParams &&
          runtimeType == other.runtimeType &&
          cursor == other.cursor &&
          limit == other.limit &&
          search == other.search &&
          status == other.status;

  @override
  int get hashCode => Object.hash(cursor, limit, search, status);
}
