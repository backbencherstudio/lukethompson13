import 'package:json_annotation/json_annotation.dart';

part 'mark_a_claim_as_paid_request.model.g.dart';

@JsonSerializable(includeIfNull: false)
class MarkAClaimAsPaidRequest {
  @JsonKey(name: 'paid_amount')
  final double? paidAmount;

  const MarkAClaimAsPaidRequest({this.paidAmount});

  factory MarkAClaimAsPaidRequest.fromJson(Map<String, dynamic> json) =>
      _$MarkAClaimAsPaidRequestFromJson(json);

  Map<String, dynamic> toJson() => _$MarkAClaimAsPaidRequestToJson(this);
}

@JsonSerializable(includeIfNull: false)
class MarkAClaimAsDeniedRequest {
  @JsonKey(name: 'denied_by')
  final String? deniedBy;

  @JsonKey(name: 'denial_reason')
  final String? denialReason;

  const MarkAClaimAsDeniedRequest({this.deniedBy, this.denialReason});

  factory MarkAClaimAsDeniedRequest.fromJson(Map<String, dynamic> json) =>
      _$MarkAClaimAsDeniedRequestFromJson(json);

  Map<String, dynamic> toJson() => _$MarkAClaimAsDeniedRequestToJson(this);
}

@JsonSerializable()
class SendClaimFollowUpEmailRequest {
  final int level;

  const SendClaimFollowUpEmailRequest({required this.level});

  factory SendClaimFollowUpEmailRequest.fromJson(Map<String, dynamic> json) =>
      _$SendClaimFollowUpEmailRequestFromJson(json);

  Map<String, dynamic> toJson() => _$SendClaimFollowUpEmailRequestToJson(this);
}
