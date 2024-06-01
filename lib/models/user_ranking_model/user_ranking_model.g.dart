// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_ranking_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$UserRankingImpl _$$UserRankingImplFromJson(Map<String, dynamic> json) =>
    _$UserRankingImpl(
      user_position: json['user_position'] as int,
      user_id: json['user_id'] as String,
      username: json['username'] as String?,
      full_name: json['full_name'] as String?,
      help_count: json['help_count'] as int,
      avatar_url: json['avatar_url'] as String?,
    );

Map<String, dynamic> _$$UserRankingImplToJson(_$UserRankingImpl instance) =>
    <String, dynamic>{
      'user_position': instance.user_position,
      'user_id': instance.user_id,
      'username': instance.username,
      'full_name': instance.full_name,
      'help_count': instance.help_count,
      'avatar_url': instance.avatar_url,
    };
