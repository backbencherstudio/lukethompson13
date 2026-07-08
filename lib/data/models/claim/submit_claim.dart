import 'package:json_annotation/json_annotation.dart';

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
