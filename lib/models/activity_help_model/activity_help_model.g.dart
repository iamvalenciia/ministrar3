// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'activity_help_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ActivityHelpModelImpl _$$ActivityHelpModelImplFromJson(
        Map<String, dynamic> json) =>
    _$ActivityHelpModelImpl(
      id: json['id'] as int,
      post_id: json['post_id'] as int?,
      helper_id: json['helper_id'] as String?,
      created_at: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
      status: json['status'] as bool?,
    );

Map<String, dynamic> _$$ActivityHelpModelImplToJson(
        _$ActivityHelpModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'post_id': instance.post_id,
      'helper_id': instance.helper_id,
      'created_at': instance.created_at?.toIso8601String(),
      'status': instance.status,
    };
