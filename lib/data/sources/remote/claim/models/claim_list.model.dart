import 'package:json_annotation/json_annotation.dart';
import 'package:lukethompson/data/models/models.dart';
import 'package:lukethompson/data/sources/remote/remote.dart';

part 'claim_list.model.g.dart';

@JsonSerializable()
class ClaimItem {
  final String id;

  @JsonKey(name: 'facility_name')
  final String facilityName;

  final DateTime date;

  final num amount;

  final ClaimStatus status;

  const ClaimItem({
    required this.id,
    required this.facilityName,
    required this.date,
    required this.amount,
    required this.status,
  });

  factory ClaimItem.fromJson(Map<String, dynamic> json) =>
      _$ClaimItemFromJson(json);

  Map<String, dynamic> toJson() => _$ClaimItemToJson(this);

  @override
  String toString() => 'ClaimItem${toJson()}';
}

@JsonSerializable()
class ClaimCounts {
  final int all;
  final int draft;
  final int submitted;
  final int paid;
  final int denied;

  const ClaimCounts({
    required this.all,
    required this.draft,
    required this.submitted,
    required this.paid,
    required this.denied,
  });

  factory ClaimCounts.fromJson(Map<String, dynamic> json) =>
      _$ClaimCountsFromJson(json);

  Map<String, dynamic> toJson() => _$ClaimCountsToJson(this);

  @override
  String toString() => 'ClaimCounts${toJson()}';
}

@JsonSerializable()
class ClaimStats {
  @JsonKey(name: 'pending_claims_amount')
  final String pendingClaimsAmount;

  @JsonKey(name: 'settled_this_week_amount')
  final String settledThisWeekAmount;

  const ClaimStats({
    required this.pendingClaimsAmount,
    required this.settledThisWeekAmount,
  });

  factory ClaimStats.fromJson(Map<String, dynamic> json) =>
      _$ClaimStatsFromJson(json);

  Map<String, dynamic> toJson() => _$ClaimStatsToJson(this);

  @override
  String toString() => 'ClaimStats${toJson()}';
}

@JsonSerializable()
class ClaimListMetaData {
  @JsonKey(name: 'next_cursor')
  final String? nextCursor;

  final int limit;

  final ResponseFilter filters;

  final ClaimCounts counts;

  final ClaimStats stats;

  const ClaimListMetaData({
    this.nextCursor,
    required this.limit,
    required this.filters,
    required this.counts,
    required this.stats,
  });

  factory ClaimListMetaData.fromJson(Map<String, dynamic> json) =>
      _$ClaimListMetaDataFromJson(json);

  Map<String, dynamic> toJson() => _$ClaimListMetaDataToJson(this);

  @override
  String toString() => 'ClaimListMetaData${toJson()}';
}

@JsonSerializable()
class ClaimListResponse extends BaseResponse {
  final List<ClaimItem> data;

  @JsonKey(name: 'meta_data')
  final ClaimListMetaData metaData;

  const ClaimListResponse({
    required super.success,
    required super.message,
    required this.data,
    required this.metaData,
  });

  factory ClaimListResponse.fromJson(Map<String, dynamic> json) =>
      _$ClaimListResponseFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$ClaimListResponseToJson(this);

  @override
  String toString() => 'ClaimListResponse${toJson()}';
}
