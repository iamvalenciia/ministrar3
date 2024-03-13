// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'help_request_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$HelpRequestModelImpl _$$HelpRequestModelImplFromJson(
        Map<String, dynamic> json) =>
    _$HelpRequestModelImpl(
      id: json['id'] as int,
      user_id: json['user_id'] as String?,
      category: json['category'] as String?,
      content: json['content'] as String?,
      inserted_at: json['inserted_at'] == null
          ? null
          : DateTime.parse(json['inserted_at'] as String),
      receive_help_at: json['receive_help_at'] == null
          ? null
          : DateTime.parse(json['receive_help_at'] as String),
      lat: (json['lat'] as num?)?.toDouble(),
      long: (json['long'] as num?)?.toDouble(),
      username: json['username'] as String?,
      avatar_url: json['avatar_url'] as String?,
      distance: (json['distance'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$$HelpRequestModelImplToJson(
        _$HelpRequestModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'user_id': instance.user_id,
      'category': instance.category,
      'content': instance.content,
      'inserted_at': instance.inserted_at?.toIso8601String(),
      'receive_help_at': instance.receive_help_at?.toIso8601String(),
      'lat': instance.lat,
      'long': instance.long,
      'username': instance.username,
      'avatar_url': instance.avatar_url,
      'distance': instance.distance,
    };
