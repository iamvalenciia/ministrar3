// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'help_request_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$HelpRequestModelImpl _$$HelpRequestModelImplFromJson(
        Map<String, dynamic> json) =>
    _$HelpRequestModelImpl(
      hr_id: json['hr_id'] as int,
      help_request_owner_id: json['help_request_owner_id'] as String,
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
      location_sharing_enabled: json['location_sharing_enabled'] as bool?,
      phone_number: json['phone_number'] as String?,
      x_username: json['x_username'] as String?,
      instagram_username: json['instagram_username'] as String?,
      people_helping_count: json['people_helping_count'] as int?,
      people_provide_help_count: json['people_provide_help_count'] as int?,
    );

Map<String, dynamic> _$$HelpRequestModelImplToJson(
        _$HelpRequestModelImpl instance) =>
    <String, dynamic>{
      'hr_id': instance.hr_id,
      'help_request_owner_id': instance.help_request_owner_id,
      'category': instance.category,
      'content': instance.content,
      'inserted_at': instance.inserted_at?.toIso8601String(),
      'receive_help_at': instance.receive_help_at?.toIso8601String(),
      'lat': instance.lat,
      'long': instance.long,
      'username': instance.username,
      'avatar_url': instance.avatar_url,
      'location_sharing_enabled': instance.location_sharing_enabled,
      'phone_number': instance.phone_number,
      'x_username': instance.x_username,
      'instagram_username': instance.instagram_username,
      'people_helping_count': instance.people_helping_count,
      'people_provide_help_count': instance.people_provide_help_count,
    };
