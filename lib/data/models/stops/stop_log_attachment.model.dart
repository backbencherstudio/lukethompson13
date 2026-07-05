import 'package:json_annotation/json_annotation.dart';

part 'stop_log_attachment.model.g.dart';

@JsonSerializable()
class StopLogAttachment {
  final String id;

  final String type;

  @JsonKey(name: 'file_name')
  final String fileName;

  @JsonKey(name: 'file_url')
  final String fileUrl;

  @JsonKey(name: 'mime_type')
  final String mimeType;

  @JsonKey(name: 'size_bytes')
  final int sizeBytes;

  @JsonKey(name: 'created_at')
  final String createdAt;

  StopLogAttachment({
    required this.id,
    required this.type,
    required this.fileName,
    required this.fileUrl,
    required this.mimeType,
    required this.sizeBytes,
    required this.createdAt,
  });

  factory StopLogAttachment.fromJson(Map<String, dynamic> json) =>
      _$StopLogAttachmentFromJson(json);

  Map<String, dynamic> toJson() => _$StopLogAttachmentToJson(this);

  @override
  String toString() => 'StopLogAttachment${toJson()}';
}
