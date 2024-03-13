// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'activity_post_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ActivityPostModelImpl _$$ActivityPostModelImplFromJson(
        Map<String, dynamic> json) =>
    _$ActivityPostModelImpl(
      id: json['id'] as int,
      owner_id: json['owner_id'] as String,
      created_at: DateTime.parse(json['created_at'] as String),
    );

Map<String, dynamic> _$$ActivityPostModelImplToJson(
        _$ActivityPostModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'owner_id': instance.owner_id,
      'created_at': instance.created_at.toIso8601String(),
    };
