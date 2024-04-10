// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'activity_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ActivityImpl _$$ActivityImplFromJson(Map<String, dynamic> json) =>
    _$ActivityImpl(
      activity_id: json['activity_id'] as int?,
      activity_type: json['activity_type'] as String?,
      activity_owner: json['activity_owner'] as String?,
      inserted_at: json['inserted_at'] == null
          ? null
          : DateTime.parse(json['inserted_at'] as String),
      status: json['status'] as bool?,
      status_updated_at: json['status_updated_at'] == null
          ? null
          : DateTime.parse(json['status_updated_at'] as String),
      help_request_owner_id: json['help_request_owner_id'] as String?,
    );

Map<String, dynamic> _$$ActivityImplToJson(_$ActivityImpl instance) =>
    <String, dynamic>{
      'activity_id': instance.activity_id,
      'activity_type': instance.activity_type,
      'activity_owner': instance.activity_owner,
      'inserted_at': instance.inserted_at?.toIso8601String(),
      'status': instance.status,
      'status_updated_at': instance.status_updated_at?.toIso8601String(),
      'help_request_owner_id': instance.help_request_owner_id,
    };
