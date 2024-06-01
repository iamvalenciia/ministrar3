// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user_ranking_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

UserRanking _$UserRankingFromJson(Map<String, dynamic> json) {
  return _UserRanking.fromJson(json);
}

/// @nodoc
mixin _$UserRanking {
  int get user_position => throw _privateConstructorUsedError;
  String get user_id => throw _privateConstructorUsedError;
  String? get username => throw _privateConstructorUsedError;
  String? get full_name => throw _privateConstructorUsedError;
  int get help_count => throw _privateConstructorUsedError;
  String? get avatar_url => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $UserRankingCopyWith<UserRanking> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserRankingCopyWith<$Res> {
  factory $UserRankingCopyWith(
          UserRanking value, $Res Function(UserRanking) then) =
      _$UserRankingCopyWithImpl<$Res, UserRanking>;
  @useResult
  $Res call(
      {int user_position,
      String user_id,
      String? username,
      String? full_name,
      int help_count,
      String? avatar_url});
}

/// @nodoc
class _$UserRankingCopyWithImpl<$Res, $Val extends UserRanking>
    implements $UserRankingCopyWith<$Res> {
  _$UserRankingCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? user_position = null,
    Object? user_id = null,
    Object? username = freezed,
    Object? full_name = freezed,
    Object? help_count = null,
    Object? avatar_url = freezed,
  }) {
    return _then(_value.copyWith(
      user_position: null == user_position
          ? _value.user_position
          : user_position // ignore: cast_nullable_to_non_nullable
              as int,
      user_id: null == user_id
          ? _value.user_id
          : user_id // ignore: cast_nullable_to_non_nullable
              as String,
      username: freezed == username
          ? _value.username
          : username // ignore: cast_nullable_to_non_nullable
              as String?,
      full_name: freezed == full_name
          ? _value.full_name
          : full_name // ignore: cast_nullable_to_non_nullable
              as String?,
      help_count: null == help_count
          ? _value.help_count
          : help_count // ignore: cast_nullable_to_non_nullable
              as int,
      avatar_url: freezed == avatar_url
          ? _value.avatar_url
          : avatar_url // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$UserRankingImplCopyWith<$Res>
    implements $UserRankingCopyWith<$Res> {
  factory _$$UserRankingImplCopyWith(
          _$UserRankingImpl value, $Res Function(_$UserRankingImpl) then) =
      __$$UserRankingImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int user_position,
      String user_id,
      String? username,
      String? full_name,
      int help_count,
      String? avatar_url});
}

/// @nodoc
class __$$UserRankingImplCopyWithImpl<$Res>
    extends _$UserRankingCopyWithImpl<$Res, _$UserRankingImpl>
    implements _$$UserRankingImplCopyWith<$Res> {
  __$$UserRankingImplCopyWithImpl(
      _$UserRankingImpl _value, $Res Function(_$UserRankingImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? user_position = null,
    Object? user_id = null,
    Object? username = freezed,
    Object? full_name = freezed,
    Object? help_count = null,
    Object? avatar_url = freezed,
  }) {
    return _then(_$UserRankingImpl(
      user_position: null == user_position
          ? _value.user_position
          : user_position // ignore: cast_nullable_to_non_nullable
              as int,
      user_id: null == user_id
          ? _value.user_id
          : user_id // ignore: cast_nullable_to_non_nullable
              as String,
      username: freezed == username
          ? _value.username
          : username // ignore: cast_nullable_to_non_nullable
              as String?,
      full_name: freezed == full_name
          ? _value.full_name
          : full_name // ignore: cast_nullable_to_non_nullable
              as String?,
      help_count: null == help_count
          ? _value.help_count
          : help_count // ignore: cast_nullable_to_non_nullable
              as int,
      avatar_url: freezed == avatar_url
          ? _value.avatar_url
          : avatar_url // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$UserRankingImpl implements _UserRanking {
  _$UserRankingImpl(
      {required this.user_position,
      required this.user_id,
      required this.username,
      required this.full_name,
      required this.help_count,
      this.avatar_url});

  factory _$UserRankingImpl.fromJson(Map<String, dynamic> json) =>
      _$$UserRankingImplFromJson(json);

  @override
  final int user_position;
  @override
  final String user_id;
  @override
  final String? username;
  @override
  final String? full_name;
  @override
  final int help_count;
  @override
  final String? avatar_url;

  @override
  String toString() {
    return 'UserRanking(user_position: $user_position, user_id: $user_id, username: $username, full_name: $full_name, help_count: $help_count, avatar_url: $avatar_url)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UserRankingImpl &&
            (identical(other.user_position, user_position) ||
                other.user_position == user_position) &&
            (identical(other.user_id, user_id) || other.user_id == user_id) &&
            (identical(other.username, username) ||
                other.username == username) &&
            (identical(other.full_name, full_name) ||
                other.full_name == full_name) &&
            (identical(other.help_count, help_count) ||
                other.help_count == help_count) &&
            (identical(other.avatar_url, avatar_url) ||
                other.avatar_url == avatar_url));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, user_position, user_id, username,
      full_name, help_count, avatar_url);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$UserRankingImplCopyWith<_$UserRankingImpl> get copyWith =>
      __$$UserRankingImplCopyWithImpl<_$UserRankingImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$UserRankingImplToJson(
      this,
    );
  }
}

abstract class _UserRanking implements UserRanking {
  factory _UserRanking(
      {required final int user_position,
      required final String user_id,
      required final String? username,
      required final String? full_name,
      required final int help_count,
      final String? avatar_url}) = _$UserRankingImpl;

  factory _UserRanking.fromJson(Map<String, dynamic> json) =
      _$UserRankingImpl.fromJson;

  @override
  int get user_position;
  @override
  String get user_id;
  @override
  String? get username;
  @override
  String? get full_name;
  @override
  int get help_count;
  @override
  String? get avatar_url;
  @override
  @JsonKey(ignore: true)
  _$$UserRankingImplCopyWith<_$UserRankingImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
