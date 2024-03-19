// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'activity_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ActivitieImpl _$$ActivitieImplFromJson(Map<String, dynamic> json) =>
    _$ActivitieImpl(
      id: json['id'] as int?,
      activity_owner: json['activity_owner'] as String,
      inserted_at: DateTime.parse(json['inserted_at'] as String),
      post_owner: json['post_owner'] as String,
      status: json['status'] as bool?,
      status_updated_at: json['status_updated_at'] == null
          ? null
          : DateTime.parse(json['status_updated_at'] as String),
    );

Map<String, dynamic> _$$ActivitieImplToJson(_$ActivitieImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'activity_owner': instance.activity_owner,
      'inserted_at': instance.inserted_at.toIso8601String(),
      'post_owner': instance.post_owner,
      'status': instance.status,
      'status_updated_at': instance.status_updated_at?.toIso8601String(),
    };
