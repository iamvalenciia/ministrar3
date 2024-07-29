// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'help_points_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$HelpPointsModelImpl _$$HelpPointsModelImplFromJson(
        Map<String, dynamic> json) =>
    _$HelpPointsModelImpl(
      id: json['id'] as int?,
      user_id: json['user_id'] as String?,
      points: json['points'] as int?,
      last_updated: json['last_updated'] == null
          ? null
          : DateTime.parse(json['last_updated'] as String),
    );

Map<String, dynamic> _$$HelpPointsModelImplToJson(
        _$HelpPointsModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'user_id': instance.user_id,
      'points': instance.points,
      'last_updated': instance.last_updated?.toIso8601String(),
    };
