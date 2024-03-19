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

Activitie _$ActivitieFromJson(Map<String, dynamic> json) {
  return _Activitie.fromJson(json);
}

/// @nodoc
mixin _$Activitie {
  int? get id => throw _privateConstructorUsedError;
  set id(int? value) => throw _privateConstructorUsedError;
  String get activity_owner => throw _privateConstructorUsedError;
  set activity_owner(String value) => throw _privateConstructorUsedError;
  DateTime get inserted_at => throw _privateConstructorUsedError;
  set inserted_at(DateTime value) => throw _privateConstructorUsedError;
  String get post_owner => throw _privateConstructorUsedError;
  set post_owner(String value) => throw _privateConstructorUsedError;
  bool? get status => throw _privateConstructorUsedError;
  set status(bool? value) => throw _privateConstructorUsedError;
  DateTime? get status_updated_at => throw _privateConstructorUsedError;
  set status_updated_at(DateTime? value) => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ActivitieCopyWith<Activitie> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ActivitieCopyWith<$Res> {
  factory $ActivitieCopyWith(Activitie value, $Res Function(Activitie) then) =
      _$ActivitieCopyWithImpl<$Res, Activitie>;
  @useResult
  $Res call(
      {int? id,
      String activity_owner,
      DateTime inserted_at,
      String post_owner,
      bool? status,
      DateTime? status_updated_at});
}

/// @nodoc
class _$ActivitieCopyWithImpl<$Res, $Val extends Activitie>
    implements $ActivitieCopyWith<$Res> {
  _$ActivitieCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? activity_owner = null,
    Object? inserted_at = null,
    Object? post_owner = null,
    Object? status = freezed,
    Object? status_updated_at = freezed,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      activity_owner: null == activity_owner
          ? _value.activity_owner
          : activity_owner // ignore: cast_nullable_to_non_nullable
              as String,
      inserted_at: null == inserted_at
          ? _value.inserted_at
          : inserted_at // ignore: cast_nullable_to_non_nullable
              as DateTime,
      post_owner: null == post_owner
          ? _value.post_owner
          : post_owner // ignore: cast_nullable_to_non_nullable
              as String,
      status: freezed == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as bool?,
      status_updated_at: freezed == status_updated_at
          ? _value.status_updated_at
          : status_updated_at // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ActivitieImplCopyWith<$Res>
    implements $ActivitieCopyWith<$Res> {
  factory _$$ActivitieImplCopyWith(
          _$ActivitieImpl value, $Res Function(_$ActivitieImpl) then) =
      __$$ActivitieImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int? id,
      String activity_owner,
      DateTime inserted_at,
      String post_owner,
      bool? status,
      DateTime? status_updated_at});
}

/// @nodoc
class __$$ActivitieImplCopyWithImpl<$Res>
    extends _$ActivitieCopyWithImpl<$Res, _$ActivitieImpl>
    implements _$$ActivitieImplCopyWith<$Res> {
  __$$ActivitieImplCopyWithImpl(
      _$ActivitieImpl _value, $Res Function(_$ActivitieImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? activity_owner = null,
    Object? inserted_at = null,
    Object? post_owner = null,
    Object? status = freezed,
    Object? status_updated_at = freezed,
  }) {
    return _then(_$ActivitieImpl(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      activity_owner: null == activity_owner
          ? _value.activity_owner
          : activity_owner // ignore: cast_nullable_to_non_nullable
              as String,
      inserted_at: null == inserted_at
          ? _value.inserted_at
          : inserted_at // ignore: cast_nullable_to_non_nullable
              as DateTime,
      post_owner: null == post_owner
          ? _value.post_owner
          : post_owner // ignore: cast_nullable_to_non_nullable
              as String,
      status: freezed == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as bool?,
      status_updated_at: freezed == status_updated_at
          ? _value.status_updated_at
          : status_updated_at // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ActivitieImpl implements _Activitie {
  _$ActivitieImpl(
      {this.id,
      required this.activity_owner,
      required this.inserted_at,
      required this.post_owner,
      this.status,
      this.status_updated_at});

  factory _$ActivitieImpl.fromJson(Map<String, dynamic> json) =>
      _$$ActivitieImplFromJson(json);

  @override
  int? id;
  @override
  String activity_owner;
  @override
  DateTime inserted_at;
  @override
  String post_owner;
  @override
  bool? status;
  @override
  DateTime? status_updated_at;

  @override
  String toString() {
    return 'Activitie(id: $id, activity_owner: $activity_owner, inserted_at: $inserted_at, post_owner: $post_owner, status: $status, status_updated_at: $status_updated_at)';
  }

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ActivitieImplCopyWith<_$ActivitieImpl> get copyWith =>
      __$$ActivitieImplCopyWithImpl<_$ActivitieImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ActivitieImplToJson(
      this,
    );
  }
}

abstract class _Activitie implements Activitie {
  factory _Activitie(
      {int? id,
      required String activity_owner,
      required DateTime inserted_at,
      required String post_owner,
      bool? status,
      DateTime? status_updated_at}) = _$ActivitieImpl;

  factory _Activitie.fromJson(Map<String, dynamic> json) =
      _$ActivitieImpl.fromJson;

  @override
  int? get id;
  set id(int? value);
  @override
  String get activity_owner;
  set activity_owner(String value);
  @override
  DateTime get inserted_at;
  set inserted_at(DateTime value);
  @override
  String get post_owner;
  set post_owner(String value);
  @override
  bool? get status;
  set status(bool? value);
  @override
  DateTime? get status_updated_at;
  set status_updated_at(DateTime? value);
  @override
  @JsonKey(ignore: true)
  _$$ActivitieImplCopyWith<_$ActivitieImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
