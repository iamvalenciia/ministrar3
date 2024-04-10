// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'people_helping_in_my_hr.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PeopleHelpingInMyHelpRequestImpl _$$PeopleHelpingInMyHelpRequestImplFromJson(
        Map<String, dynamic> json) =>
    _$PeopleHelpingInMyHelpRequestImpl(
      activity_id: json['activity_id'] as int?,
      activity_owner: json['activity_owner'] as String?,
      status: json['status'] as bool?,
      username: json['username'] as String?,
      avatar_url: json['avatar_url'] as String?,
    );

Map<String, dynamic> _$$PeopleHelpingInMyHelpRequestImplToJson(
        _$PeopleHelpingInMyHelpRequestImpl instance) =>
    <String, dynamic>{
      'activity_id': instance.activity_id,
      'activity_owner': instance.activity_owner,
      'status': instance.status,
      'username': instance.username,
      'avatar_url': instance.avatar_url,
    };
