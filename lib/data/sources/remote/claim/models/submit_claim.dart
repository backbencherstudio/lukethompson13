import 'package:json_annotation/json_annotation.dart';
import 'package:lukethompson/data/models/models.dart';
import 'package:lukethompson/data/sources/remote/remote.dart';


part 'submit_claim.g.dart';

@JsonSerializable()
class SubmitClaimRequest {
  @JsonKey(name: 'claim_method')
  final String claimMethod;

  @JsonKey(name: 'recipient_email')
  final String? recipientEmail;

  @JsonKey(name: 'broker_email')
  final String? brokerEmail;

  const SubmitClaimRequest({
    required this.claimMethod,
    this.recipientEmail,
    this.brokerEmail,
  });

  factory SubmitClaimRequest.fromJson(Map<String, dynamic> json) =>
      _$SubmitClaimRequestFromJson(json);

  Map<String, dynamic> toJson() => _$SubmitClaimRequestToJson(this);
}

@JsonSerializable()
class ClaimSubmitData {
  @JsonKey(name: 'claim_id')
  final String claimId;

  final ClaimStatus status;

  @JsonKey(name: 'sent_at')
  final DateTime? sentAt;

  @JsonKey(name: 'claim_message')
  final String? claimMessage;

  const ClaimSubmitData({
    required this.claimId,
    required this.status,
    required this.sentAt,
    required this.claimMessage,
  });

  factory ClaimSubmitData.fromJson(Map<String, dynamic> json) =>
      _$ClaimSubmitDataFromJson(json);

  Map<String, dynamic> toJson() => _$ClaimSubmitDataToJson(this);

  @override
  String toString() => 'ClaimSubmitData${toJson()}';
}

@JsonSerializable()
class SubmitClaimResponse extends BaseResponse {
  final ClaimSubmitData data;

  const SubmitClaimResponse({
    required super.success,
    required super.message,
    required this.data,
  });

  factory SubmitClaimResponse.fromJson(Map<String, dynamic> json) =>
      _$SubmitClaimResponseFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$SubmitClaimResponseToJson(this);

  @override
  String toString() => 'SmsClaimResponse${toJson()}';
}
