// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'stop_log_attachment.model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StopLogAttachment _$StopLogAttachmentFromJson(Map<String, dynamic> json) =>
    StopLogAttachment(
      id: json['id'] as String,
      type: json['type'] as String,
      fileName: json['file_name'] as String,
      fileUrl: json['file_url'] as String?,
      mimeType: json['mime_type'] as String?,
      sizeBytes: (json['size_bytes'] as num?)?.toInt(),
      createdAt: json['created_at'] as String?,
    );

Map<String, dynamic> _$StopLogAttachmentToJson(StopLogAttachment instance) =>
    <String, dynamic>{
      'id': instance.id,
      'type': instance.type,
      'file_name': instance.fileName,
      'file_url': instance.fileUrl,
      'mime_type': instance.mimeType,
      'size_bytes': instance.sizeBytes,
      'created_at': instance.createdAt,
    };
