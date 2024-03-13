// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'activity_post_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

ActivityPostModel _$ActivityPostModelFromJson(Map<String, dynamic> json) {
  return _ActivityPostModel.fromJson(json);
}

/// @nodoc
mixin _$ActivityPostModel {
  int get id => throw _privateConstructorUsedError;
  String get owner_id => throw _privateConstructorUsedError;
  DateTime get created_at => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ActivityPostModelCopyWith<ActivityPostModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ActivityPostModelCopyWith<$Res> {
  factory $ActivityPostModelCopyWith(
          ActivityPostModel value, $Res Function(ActivityPostModel) then) =
      _$ActivityPostModelCopyWithImpl<$Res, ActivityPostModel>;
  @useResult
  $Res call({int id, String owner_id, DateTime created_at});
}

/// @nodoc
class _$ActivityPostModelCopyWithImpl<$Res, $Val extends ActivityPostModel>
    implements $ActivityPostModelCopyWith<$Res> {
  _$ActivityPostModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? owner_id = null,
    Object? created_at = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      owner_id: null == owner_id
          ? _value.owner_id
          : owner_id // ignore: cast_nullable_to_non_nullable
              as String,
      created_at: null == created_at
          ? _value.created_at
          : created_at // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ActivityPostModelImplCopyWith<$Res>
    implements $ActivityPostModelCopyWith<$Res> {
  factory _$$ActivityPostModelImplCopyWith(_$ActivityPostModelImpl value,
          $Res Function(_$ActivityPostModelImpl) then) =
      __$$ActivityPostModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int id, String owner_id, DateTime created_at});
}

/// @nodoc
class __$$ActivityPostModelImplCopyWithImpl<$Res>
    extends _$ActivityPostModelCopyWithImpl<$Res, _$ActivityPostModelImpl>
    implements _$$ActivityPostModelImplCopyWith<$Res> {
  __$$ActivityPostModelImplCopyWithImpl(_$ActivityPostModelImpl _value,
      $Res Function(_$ActivityPostModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? owner_id = null,
    Object? created_at = null,
  }) {
    return _then(_$ActivityPostModelImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      owner_id: null == owner_id
          ? _value.owner_id
          : owner_id // ignore: cast_nullable_to_non_nullable
              as String,
      created_at: null == created_at
          ? _value.created_at
          : created_at // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ActivityPostModelImpl implements _ActivityPostModel {
  _$ActivityPostModelImpl(
      {required this.id, required this.owner_id, required this.created_at});

  factory _$ActivityPostModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$ActivityPostModelImplFromJson(json);

  @override
  final int id;
  @override
  final String owner_id;
  @override
  final DateTime created_at;

  @override
  String toString() {
    return 'ActivityPostModel(id: $id, owner_id: $owner_id, created_at: $created_at)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ActivityPostModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.owner_id, owner_id) ||
                other.owner_id == owner_id) &&
            (identical(other.created_at, created_at) ||
                other.created_at == created_at));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, owner_id, created_at);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ActivityPostModelImplCopyWith<_$ActivityPostModelImpl> get copyWith =>
      __$$ActivityPostModelImplCopyWithImpl<_$ActivityPostModelImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ActivityPostModelImplToJson(
      this,
    );
  }
}

abstract class _ActivityPostModel implements ActivityPostModel {
  factory _ActivityPostModel(
      {required final int id,
      required final String owner_id,
      required final DateTime created_at}) = _$ActivityPostModelImpl;

  factory _ActivityPostModel.fromJson(Map<String, dynamic> json) =
      _$ActivityPostModelImpl.fromJson;

  @override
  int get id;
  @override
  String get owner_id;
  @override
  DateTime get created_at;
  @override
  @JsonKey(ignore: true)
  _$$ActivityPostModelImplCopyWith<_$ActivityPostModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
