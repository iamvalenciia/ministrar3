// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'people_helping_in_my_hr.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

PeopleHelpingInMyHelpRequest _$PeopleHelpingInMyHelpRequestFromJson(
    Map<String, dynamic> json) {
  return _PeopleHelpingInMyHelpRequest.fromJson(json);
}

/// @nodoc
mixin _$PeopleHelpingInMyHelpRequest {
  int? get activity_id =>
      throw _privateConstructorUsedError; // Change this to String
  String? get activity_owner => throw _privateConstructorUsedError;
  bool? get status => throw _privateConstructorUsedError;
  String? get username => throw _privateConstructorUsedError;
  String? get avatar_url => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $PeopleHelpingInMyHelpRequestCopyWith<PeopleHelpingInMyHelpRequest>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PeopleHelpingInMyHelpRequestCopyWith<$Res> {
  factory $PeopleHelpingInMyHelpRequestCopyWith(
          PeopleHelpingInMyHelpRequest value,
          $Res Function(PeopleHelpingInMyHelpRequest) then) =
      _$PeopleHelpingInMyHelpRequestCopyWithImpl<$Res,
          PeopleHelpingInMyHelpRequest>;
  @useResult
  $Res call(
      {int? activity_id,
      String? activity_owner,
      bool? status,
      String? username,
      String? avatar_url});
}

/// @nodoc
class _$PeopleHelpingInMyHelpRequestCopyWithImpl<$Res,
        $Val extends PeopleHelpingInMyHelpRequest>
    implements $PeopleHelpingInMyHelpRequestCopyWith<$Res> {
  _$PeopleHelpingInMyHelpRequestCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? activity_id = freezed,
    Object? activity_owner = freezed,
    Object? status = freezed,
    Object? username = freezed,
    Object? avatar_url = freezed,
  }) {
    return _then(_value.copyWith(
      activity_id: freezed == activity_id
          ? _value.activity_id
          : activity_id // ignore: cast_nullable_to_non_nullable
              as int?,
      activity_owner: freezed == activity_owner
          ? _value.activity_owner
          : activity_owner // ignore: cast_nullable_to_non_nullable
              as String?,
      status: freezed == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as bool?,
      username: freezed == username
          ? _value.username
          : username // ignore: cast_nullable_to_non_nullable
              as String?,
      avatar_url: freezed == avatar_url
          ? _value.avatar_url
          : avatar_url // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$PeopleHelpingInMyHelpRequestImplCopyWith<$Res>
    implements $PeopleHelpingInMyHelpRequestCopyWith<$Res> {
  factory _$$PeopleHelpingInMyHelpRequestImplCopyWith(
          _$PeopleHelpingInMyHelpRequestImpl value,
          $Res Function(_$PeopleHelpingInMyHelpRequestImpl) then) =
      __$$PeopleHelpingInMyHelpRequestImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int? activity_id,
      String? activity_owner,
      bool? status,
      String? username,
      String? avatar_url});
}

/// @nodoc
class __$$PeopleHelpingInMyHelpRequestImplCopyWithImpl<$Res>
    extends _$PeopleHelpingInMyHelpRequestCopyWithImpl<$Res,
        _$PeopleHelpingInMyHelpRequestImpl>
    implements _$$PeopleHelpingInMyHelpRequestImplCopyWith<$Res> {
  __$$PeopleHelpingInMyHelpRequestImplCopyWithImpl(
      _$PeopleHelpingInMyHelpRequestImpl _value,
      $Res Function(_$PeopleHelpingInMyHelpRequestImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? activity_id = freezed,
    Object? activity_owner = freezed,
    Object? status = freezed,
    Object? username = freezed,
    Object? avatar_url = freezed,
  }) {
    return _then(_$PeopleHelpingInMyHelpRequestImpl(
      activity_id: freezed == activity_id
          ? _value.activity_id
          : activity_id // ignore: cast_nullable_to_non_nullable
              as int?,
      activity_owner: freezed == activity_owner
          ? _value.activity_owner
          : activity_owner // ignore: cast_nullable_to_non_nullable
              as String?,
      status: freezed == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as bool?,
      username: freezed == username
          ? _value.username
          : username // ignore: cast_nullable_to_non_nullable
              as String?,
      avatar_url: freezed == avatar_url
          ? _value.avatar_url
          : avatar_url // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$PeopleHelpingInMyHelpRequestImpl
    implements _PeopleHelpingInMyHelpRequest {
  _$PeopleHelpingInMyHelpRequestImpl(
      {this.activity_id,
      required this.activity_owner,
      this.status,
      this.username,
      this.avatar_url});

  factory _$PeopleHelpingInMyHelpRequestImpl.fromJson(
          Map<String, dynamic> json) =>
      _$$PeopleHelpingInMyHelpRequestImplFromJson(json);

  @override
  final int? activity_id;
// Change this to String
  @override
  final String? activity_owner;
  @override
  final bool? status;
  @override
  final String? username;
  @override
  final String? avatar_url;

  @override
  String toString() {
    return 'PeopleHelpingInMyHelpRequest(activity_id: $activity_id, activity_owner: $activity_owner, status: $status, username: $username, avatar_url: $avatar_url)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PeopleHelpingInMyHelpRequestImpl &&
            (identical(other.activity_id, activity_id) ||
                other.activity_id == activity_id) &&
            (identical(other.activity_owner, activity_owner) ||
                other.activity_owner == activity_owner) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.username, username) ||
                other.username == username) &&
            (identical(other.avatar_url, avatar_url) ||
                other.avatar_url == avatar_url));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, activity_id, activity_owner, status, username, avatar_url);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$PeopleHelpingInMyHelpRequestImplCopyWith<
          _$PeopleHelpingInMyHelpRequestImpl>
      get copyWith => __$$PeopleHelpingInMyHelpRequestImplCopyWithImpl<
          _$PeopleHelpingInMyHelpRequestImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PeopleHelpingInMyHelpRequestImplToJson(
      this,
    );
  }
}

abstract class _PeopleHelpingInMyHelpRequest
    implements PeopleHelpingInMyHelpRequest {
  factory _PeopleHelpingInMyHelpRequest(
      {final int? activity_id,
      required final String? activity_owner,
      final bool? status,
      final String? username,
      final String? avatar_url}) = _$PeopleHelpingInMyHelpRequestImpl;

  factory _PeopleHelpingInMyHelpRequest.fromJson(Map<String, dynamic> json) =
      _$PeopleHelpingInMyHelpRequestImpl.fromJson;

  @override
  int? get activity_id;
  @override // Change this to String
  String? get activity_owner;
  @override
  bool? get status;
  @override
  String? get username;
  @override
  String? get avatar_url;
  @override
  @JsonKey(ignore: true)
  _$$PeopleHelpingInMyHelpRequestImplCopyWith<
          _$PeopleHelpingInMyHelpRequestImpl>
      get copyWith => throw _privateConstructorUsedError;
}
