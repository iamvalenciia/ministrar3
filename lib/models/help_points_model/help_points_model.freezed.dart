// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'help_points_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

HelpPointsModel _$HelpPointsModelFromJson(Map<String, dynamic> json) {
  return _HelpPointsModel.fromJson(json);
}

/// @nodoc
mixin _$HelpPointsModel {
  int? get id => throw _privateConstructorUsedError;
  String? get user_id =>
      throw _privateConstructorUsedError; // Change this to String
  int? get points => throw _privateConstructorUsedError;
  DateTime? get last_updated => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $HelpPointsModelCopyWith<HelpPointsModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $HelpPointsModelCopyWith<$Res> {
  factory $HelpPointsModelCopyWith(
          HelpPointsModel value, $Res Function(HelpPointsModel) then) =
      _$HelpPointsModelCopyWithImpl<$Res, HelpPointsModel>;
  @useResult
  $Res call({int? id, String? user_id, int? points, DateTime? last_updated});
}

/// @nodoc
class _$HelpPointsModelCopyWithImpl<$Res, $Val extends HelpPointsModel>
    implements $HelpPointsModelCopyWith<$Res> {
  _$HelpPointsModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? user_id = freezed,
    Object? points = freezed,
    Object? last_updated = freezed,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      user_id: freezed == user_id
          ? _value.user_id
          : user_id // ignore: cast_nullable_to_non_nullable
              as String?,
      points: freezed == points
          ? _value.points
          : points // ignore: cast_nullable_to_non_nullable
              as int?,
      last_updated: freezed == last_updated
          ? _value.last_updated
          : last_updated // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$HelpPointsModelImplCopyWith<$Res>
    implements $HelpPointsModelCopyWith<$Res> {
  factory _$$HelpPointsModelImplCopyWith(_$HelpPointsModelImpl value,
          $Res Function(_$HelpPointsModelImpl) then) =
      __$$HelpPointsModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int? id, String? user_id, int? points, DateTime? last_updated});
}

/// @nodoc
class __$$HelpPointsModelImplCopyWithImpl<$Res>
    extends _$HelpPointsModelCopyWithImpl<$Res, _$HelpPointsModelImpl>
    implements _$$HelpPointsModelImplCopyWith<$Res> {
  __$$HelpPointsModelImplCopyWithImpl(
      _$HelpPointsModelImpl _value, $Res Function(_$HelpPointsModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? user_id = freezed,
    Object? points = freezed,
    Object? last_updated = freezed,
  }) {
    return _then(_$HelpPointsModelImpl(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      user_id: freezed == user_id
          ? _value.user_id
          : user_id // ignore: cast_nullable_to_non_nullable
              as String?,
      points: freezed == points
          ? _value.points
          : points // ignore: cast_nullable_to_non_nullable
              as int?,
      last_updated: freezed == last_updated
          ? _value.last_updated
          : last_updated // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$HelpPointsModelImpl implements _HelpPointsModel {
  _$HelpPointsModelImpl(
      {this.id, this.user_id, this.points, this.last_updated});

  factory _$HelpPointsModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$HelpPointsModelImplFromJson(json);

  @override
  final int? id;
  @override
  final String? user_id;
// Change this to String
  @override
  final int? points;
  @override
  final DateTime? last_updated;

  @override
  String toString() {
    return 'HelpPointsModel(id: $id, user_id: $user_id, points: $points, last_updated: $last_updated)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$HelpPointsModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.user_id, user_id) || other.user_id == user_id) &&
            (identical(other.points, points) || other.points == points) &&
            (identical(other.last_updated, last_updated) ||
                other.last_updated == last_updated));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, id, user_id, points, last_updated);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$HelpPointsModelImplCopyWith<_$HelpPointsModelImpl> get copyWith =>
      __$$HelpPointsModelImplCopyWithImpl<_$HelpPointsModelImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$HelpPointsModelImplToJson(
      this,
    );
  }
}

abstract class _HelpPointsModel implements HelpPointsModel {
  factory _HelpPointsModel(
      {final int? id,
      final String? user_id,
      final int? points,
      final DateTime? last_updated}) = _$HelpPointsModelImpl;

  factory _HelpPointsModel.fromJson(Map<String, dynamic> json) =
      _$HelpPointsModelImpl.fromJson;

  @override
  int? get id;
  @override
  String? get user_id;
  @override // Change this to String
  int? get points;
  @override
  DateTime? get last_updated;
  @override
  @JsonKey(ignore: true)
  _$$HelpPointsModelImplCopyWith<_$HelpPointsModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
