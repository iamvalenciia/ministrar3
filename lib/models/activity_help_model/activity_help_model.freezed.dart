// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'activity_help_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

ActivityHelpModel _$ActivityHelpModelFromJson(Map<String, dynamic> json) {
  return _ActivityHelpModel.fromJson(json);
}

/// @nodoc
mixin _$ActivityHelpModel {
  int get id => throw _privateConstructorUsedError;
  int? get post_id => throw _privateConstructorUsedError;
  String? get helper_id => throw _privateConstructorUsedError;
  DateTime? get created_at => throw _privateConstructorUsedError;
  bool? get status => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ActivityHelpModelCopyWith<ActivityHelpModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ActivityHelpModelCopyWith<$Res> {
  factory $ActivityHelpModelCopyWith(
          ActivityHelpModel value, $Res Function(ActivityHelpModel) then) =
      _$ActivityHelpModelCopyWithImpl<$Res, ActivityHelpModel>;
  @useResult
  $Res call(
      {int id,
      int? post_id,
      String? helper_id,
      DateTime? created_at,
      bool? status});
}

/// @nodoc
class _$ActivityHelpModelCopyWithImpl<$Res, $Val extends ActivityHelpModel>
    implements $ActivityHelpModelCopyWith<$Res> {
  _$ActivityHelpModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? post_id = freezed,
    Object? helper_id = freezed,
    Object? created_at = freezed,
    Object? status = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      post_id: freezed == post_id
          ? _value.post_id
          : post_id // ignore: cast_nullable_to_non_nullable
              as int?,
      helper_id: freezed == helper_id
          ? _value.helper_id
          : helper_id // ignore: cast_nullable_to_non_nullable
              as String?,
      created_at: freezed == created_at
          ? _value.created_at
          : created_at // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      status: freezed == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as bool?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ActivityHelpModelImplCopyWith<$Res>
    implements $ActivityHelpModelCopyWith<$Res> {
  factory _$$ActivityHelpModelImplCopyWith(_$ActivityHelpModelImpl value,
          $Res Function(_$ActivityHelpModelImpl) then) =
      __$$ActivityHelpModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int id,
      int? post_id,
      String? helper_id,
      DateTime? created_at,
      bool? status});
}

/// @nodoc
class __$$ActivityHelpModelImplCopyWithImpl<$Res>
    extends _$ActivityHelpModelCopyWithImpl<$Res, _$ActivityHelpModelImpl>
    implements _$$ActivityHelpModelImplCopyWith<$Res> {
  __$$ActivityHelpModelImplCopyWithImpl(_$ActivityHelpModelImpl _value,
      $Res Function(_$ActivityHelpModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? post_id = freezed,
    Object? helper_id = freezed,
    Object? created_at = freezed,
    Object? status = freezed,
  }) {
    return _then(_$ActivityHelpModelImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      post_id: freezed == post_id
          ? _value.post_id
          : post_id // ignore: cast_nullable_to_non_nullable
              as int?,
      helper_id: freezed == helper_id
          ? _value.helper_id
          : helper_id // ignore: cast_nullable_to_non_nullable
              as String?,
      created_at: freezed == created_at
          ? _value.created_at
          : created_at // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      status: freezed == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as bool?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ActivityHelpModelImpl implements _ActivityHelpModel {
  _$ActivityHelpModelImpl(
      {required this.id,
      this.post_id,
      this.helper_id,
      this.created_at,
      this.status});

  factory _$ActivityHelpModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$ActivityHelpModelImplFromJson(json);

  @override
  final int id;
  @override
  final int? post_id;
  @override
  final String? helper_id;
  @override
  final DateTime? created_at;
  @override
  final bool? status;

  @override
  String toString() {
    return 'ActivityHelpModel(id: $id, post_id: $post_id, helper_id: $helper_id, created_at: $created_at, status: $status)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ActivityHelpModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.post_id, post_id) || other.post_id == post_id) &&
            (identical(other.helper_id, helper_id) ||
                other.helper_id == helper_id) &&
            (identical(other.created_at, created_at) ||
                other.created_at == created_at) &&
            (identical(other.status, status) || other.status == status));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, id, post_id, helper_id, created_at, status);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ActivityHelpModelImplCopyWith<_$ActivityHelpModelImpl> get copyWith =>
      __$$ActivityHelpModelImplCopyWithImpl<_$ActivityHelpModelImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ActivityHelpModelImplToJson(
      this,
    );
  }
}

abstract class _ActivityHelpModel implements ActivityHelpModel {
  factory _ActivityHelpModel(
      {required final int id,
      final int? post_id,
      final String? helper_id,
      final DateTime? created_at,
      final bool? status}) = _$ActivityHelpModelImpl;

  factory _ActivityHelpModel.fromJson(Map<String, dynamic> json) =
      _$ActivityHelpModelImpl.fromJson;

  @override
  int get id;
  @override
  int? get post_id;
  @override
  String? get helper_id;
  @override
  DateTime? get created_at;
  @override
  bool? get status;
  @override
  @JsonKey(ignore: true)
  _$$ActivityHelpModelImplCopyWith<_$ActivityHelpModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
