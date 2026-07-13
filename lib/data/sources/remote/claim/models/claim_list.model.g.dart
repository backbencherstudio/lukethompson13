// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'claim_list.model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ClaimItem _$ClaimItemFromJson(Map<String, dynamic> json) => ClaimItem(
  id: json['id'] as String,
  facilityName: json['facility_name'] as String,
  date: DateTime.parse(json['date'] as String),
  amount: json['amount'] as num,
  status: $enumDecode(_$ClaimStatusEnumMap, json['status']),
);

Map<String, dynamic> _$ClaimItemToJson(ClaimItem instance) => <String, dynamic>{
  'id': instance.id,
  'facility_name': instance.facilityName,
  'date': instance.date.toIso8601String(),
  'amount': instance.amount,
  'status': _$ClaimStatusEnumMap[instance.status]!,
};

const _$ClaimStatusEnumMap = {
  ClaimStatus.draft: 'DRAFT',
  ClaimStatus.submitted: 'SUBMITTED',
  ClaimStatus.paid: 'PAID',
  ClaimStatus.unpaid: 'UNPAID',
  ClaimStatus.denied: 'DENIED',
};

ClaimCounts _$ClaimCountsFromJson(Map<String, dynamic> json) => ClaimCounts(
  all: (json['all'] as num).toInt(),
  draft: (json['draft'] as num).toInt(),
  submitted: (json['submitted'] as num).toInt(),
  paid: (json['paid'] as num).toInt(),
  denied: (json['denied'] as num).toInt(),
);

Map<String, dynamic> _$ClaimCountsToJson(ClaimCounts instance) =>
    <String, dynamic>{
      'all': instance.all,
      'draft': instance.draft,
      'submitted': instance.submitted,
      'paid': instance.paid,
      'denied': instance.denied,
    };

ClaimStats _$ClaimStatsFromJson(Map<String, dynamic> json) => ClaimStats(
  pendingClaimsAmount: json['pending_claims_amount'] as String,
  settledThisWeekAmount: json['settled_this_week_amount'] as String,
);

Map<String, dynamic> _$ClaimStatsToJson(ClaimStats instance) =>
    <String, dynamic>{
      'pending_claims_amount': instance.pendingClaimsAmount,
      'settled_this_week_amount': instance.settledThisWeekAmount,
    };

ClaimListMetaData _$ClaimListMetaDataFromJson(Map<String, dynamic> json) =>
    ClaimListMetaData(
      nextCursor: json['next_cursor'] as String?,
      limit: (json['limit'] as num).toInt(),
      filters: ResponseFilter.fromJson(json['filters'] as Map<String, dynamic>),
      counts: ClaimCounts.fromJson(json['counts'] as Map<String, dynamic>),
      stats: ClaimStats.fromJson(json['stats'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ClaimListMetaDataToJson(ClaimListMetaData instance) =>
    <String, dynamic>{
      'next_cursor': instance.nextCursor,
      'limit': instance.limit,
      'filters': instance.filters,
      'counts': instance.counts,
      'stats': instance.stats,
    };

ClaimListResponse _$ClaimListResponseFromJson(Map<String, dynamic> json) =>
    ClaimListResponse(
      success: json['success'] as bool,
      message: json['message'] as String,
      data: (json['data'] as List<dynamic>)
          .map((e) => ClaimItem.fromJson(e as Map<String, dynamic>))
          .toList(),
      metaData: ClaimListMetaData.fromJson(
        json['meta_data'] as Map<String, dynamic>,
      ),
    );

Map<String, dynamic> _$ClaimListResponseToJson(ClaimListResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
      'message': instance.message,
      'data': instance.data,
      'meta_data': instance.metaData,
    };
