// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$UserImpl _$$UserImplFromJson(Map<String, dynamic> json) => _$UserImpl(
      id: json['id'] as String,
      updated_at: json['updated_at'] as String?,
      username: json['username'] as String?,
      full_name: json['full_name'] as String?,
      avatar_url: json['avatar_url'] as String?,
    );

Map<String, dynamic> _$$UserImplToJson(_$UserImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'updated_at': instance.updated_at,
      'username': instance.username,
      'full_name': instance.full_name,
      'avatar_url': instance.avatar_url,
    };
