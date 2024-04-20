// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'activity_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Activity _$ActivityFromJson(Map<String, dynamic> json) {
  return _Activity.fromJson(json);
}

/// @nodoc
mixin _$Activity {
  int? get activity_id => throw _privateConstructorUsedError;
  String? get activity_type =>
      throw _privateConstructorUsedError; // Change this to String
  String? get activity_owner_id => throw _privateConstructorUsedError;
  String? get help_request_owner_username => throw _privateConstructorUsedError;
  DateTime? get inserted_at => throw _privateConstructorUsedError;
  bool? get status => throw _privateConstructorUsedError;
  DateTime? get status_updated_at => throw _privateConstructorUsedError;
  int? get help_request_id => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ActivityCopyWith<Activity> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ActivityCopyWith<$Res> {
  factory $ActivityCopyWith(Activity value, $Res Function(Activity) then) =
      _$ActivityCopyWithImpl<$Res, Activity>;
  @useResult
  $Res call(
      {int? activity_id,
      String? activity_type,
      String? activity_owner_id,
      String? help_request_owner_username,
      DateTime? inserted_at,
      bool? status,
      DateTime? status_updated_at,
      int? help_request_id});
}

/// @nodoc
class _$ActivityCopyWithImpl<$Res, $Val extends Activity>
    implements $ActivityCopyWith<$Res> {
  _$ActivityCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? activity_id = freezed,
    Object? activity_type = freezed,
    Object? activity_owner_id = freezed,
    Object? help_request_owner_username = freezed,
    Object? inserted_at = freezed,
    Object? status = freezed,
    Object? status_updated_at = freezed,
    Object? help_request_id = freezed,
  }) {
    return _then(_value.copyWith(
      activity_id: freezed == activity_id
          ? _value.activity_id
          : activity_id // ignore: cast_nullable_to_non_nullable
              as int?,
      activity_type: freezed == activity_type
          ? _value.activity_type
          : activity_type // ignore: cast_nullable_to_non_nullable
              as String?,
      activity_owner_id: freezed == activity_owner_id
          ? _value.activity_owner_id
          : activity_owner_id // ignore: cast_nullable_to_non_nullable
              as String?,
      help_request_owner_username: freezed == help_request_owner_username
          ? _value.help_request_owner_username
          : help_request_owner_username // ignore: cast_nullable_to_non_nullable
              as String?,
      inserted_at: freezed == inserted_at
          ? _value.inserted_at
          : inserted_at // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      status: freezed == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as bool?,
      status_updated_at: freezed == status_updated_at
          ? _value.status_updated_at
          : status_updated_at // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      help_request_id: freezed == help_request_id
          ? _value.help_request_id
          : help_request_id // ignore: cast_nullable_to_non_nullable
              as int?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ActivityImplCopyWith<$Res>
    implements $ActivityCopyWith<$Res> {
  factory _$$ActivityImplCopyWith(
          _$ActivityImpl value, $Res Function(_$ActivityImpl) then) =
      __$$ActivityImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int? activity_id,
      String? activity_type,
      String? activity_owner_id,
      String? help_request_owner_username,
      DateTime? inserted_at,
      bool? status,
      DateTime? status_updated_at,
      int? help_request_id});
}

/// @nodoc
class __$$ActivityImplCopyWithImpl<$Res>
    extends _$ActivityCopyWithImpl<$Res, _$ActivityImpl>
    implements _$$ActivityImplCopyWith<$Res> {
  __$$ActivityImplCopyWithImpl(
      _$ActivityImpl _value, $Res Function(_$ActivityImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? activity_id = freezed,
    Object? activity_type = freezed,
    Object? activity_owner_id = freezed,
    Object? help_request_owner_username = freezed,
    Object? inserted_at = freezed,
    Object? status = freezed,
    Object? status_updated_at = freezed,
    Object? help_request_id = freezed,
  }) {
    return _then(_$ActivityImpl(
      activity_id: freezed == activity_id
          ? _value.activity_id
          : activity_id // ignore: cast_nullable_to_non_nullable
              as int?,
      activity_type: freezed == activity_type
          ? _value.activity_type
          : activity_type // ignore: cast_nullable_to_non_nullable
              as String?,
      activity_owner_id: freezed == activity_owner_id
          ? _value.activity_owner_id
          : activity_owner_id // ignore: cast_nullable_to_non_nullable
              as String?,
      help_request_owner_username: freezed == help_request_owner_username
          ? _value.help_request_owner_username
          : help_request_owner_username // ignore: cast_nullable_to_non_nullable
              as String?,
      inserted_at: freezed == inserted_at
          ? _value.inserted_at
          : inserted_at // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      status: freezed == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as bool?,
      status_updated_at: freezed == status_updated_at
          ? _value.status_updated_at
          : status_updated_at // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      help_request_id: freezed == help_request_id
          ? _value.help_request_id
          : help_request_id // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ActivityImpl implements _Activity {
  _$ActivityImpl(
      {this.activity_id,
      this.activity_type,
      required this.activity_owner_id,
      this.help_request_owner_username,
      required this.inserted_at,
      this.status,
      this.status_updated_at,
      this.help_request_id});

  factory _$ActivityImpl.fromJson(Map<String, dynamic> json) =>
      _$$ActivityImplFromJson(json);

  @override
  final int? activity_id;
  @override
  final String? activity_type;
// Change this to String
  @override
  final String? activity_owner_id;
  @override
  final String? help_request_owner_username;
  @override
  final DateTime? inserted_at;
  @override
  final bool? status;
  @override
  final DateTime? status_updated_at;
  @override
  final int? help_request_id;

  @override
  String toString() {
    return 'Activity(activity_id: $activity_id, activity_type: $activity_type, activity_owner_id: $activity_owner_id, help_request_owner_username: $help_request_owner_username, inserted_at: $inserted_at, status: $status, status_updated_at: $status_updated_at, help_request_id: $help_request_id)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ActivityImpl &&
            (identical(other.activity_id, activity_id) ||
                other.activity_id == activity_id) &&
            (identical(other.activity_type, activity_type) ||
                other.activity_type == activity_type) &&
            (identical(other.activity_owner_id, activity_owner_id) ||
                other.activity_owner_id == activity_owner_id) &&
            (identical(other.help_request_owner_username,
                    help_request_owner_username) ||
                other.help_request_owner_username ==
                    help_request_owner_username) &&
            (identical(other.inserted_at, inserted_at) ||
                other.inserted_at == inserted_at) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.status_updated_at, status_updated_at) ||
                other.status_updated_at == status_updated_at) &&
            (identical(other.help_request_id, help_request_id) ||
                other.help_request_id == help_request_id));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      activity_id,
      activity_type,
      activity_owner_id,
      help_request_owner_username,
      inserted_at,
      status,
      status_updated_at,
      help_request_id);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ActivityImplCopyWith<_$ActivityImpl> get copyWith =>
      __$$ActivityImplCopyWithImpl<_$ActivityImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ActivityImplToJson(
      this,
    );
  }
}

abstract class _Activity implements Activity {
  factory _Activity(
      {final int? activity_id,
      final String? activity_type,
      required final String? activity_owner_id,
      final String? help_request_owner_username,
      required final DateTime? inserted_at,
      final bool? status,
      final DateTime? status_updated_at,
      final int? help_request_id}) = _$ActivityImpl;

  factory _Activity.fromJson(Map<String, dynamic> json) =
      _$ActivityImpl.fromJson;

  @override
  int? get activity_id;
  @override
  String? get activity_type;
  @override // Change this to String
  String? get activity_owner_id;
  @override
  String? get help_request_owner_username;
  @override
  DateTime? get inserted_at;
  @override
  bool? get status;
  @override
  DateTime? get status_updated_at;
  @override
  int? get help_request_id;
  @override
  @JsonKey(ignore: true)
  _$$ActivityImplCopyWith<_$ActivityImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
