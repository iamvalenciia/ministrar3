// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'help_request_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

HelpRequestModel _$HelpRequestModelFromJson(Map<String, dynamic> json) {
  return _HelpRequestModel.fromJson(json);
}

/// @nodoc
mixin _$HelpRequestModel {
  int get hr_id => throw _privateConstructorUsedError;
  set hr_id(int value) => throw _privateConstructorUsedError;
  String get help_request_owner_id => throw _privateConstructorUsedError;
  set help_request_owner_id(String value) => throw _privateConstructorUsedError;
  String? get category => throw _privateConstructorUsedError;
  set category(String? value) => throw _privateConstructorUsedError;
  String? get content => throw _privateConstructorUsedError;
  set content(String? value) => throw _privateConstructorUsedError;
  DateTime? get inserted_at => throw _privateConstructorUsedError;
  set inserted_at(DateTime? value) => throw _privateConstructorUsedError;
  DateTime? get receive_help_at => throw _privateConstructorUsedError;
  set receive_help_at(DateTime? value) => throw _privateConstructorUsedError;
  double? get lat => throw _privateConstructorUsedError;
  set lat(double? value) => throw _privateConstructorUsedError;
  double? get long => throw _privateConstructorUsedError;
  set long(double? value) => throw _privateConstructorUsedError;
  String? get username => throw _privateConstructorUsedError;
  set username(String? value) => throw _privateConstructorUsedError;
  String? get avatar_url => throw _privateConstructorUsedError;
  set avatar_url(String? value) => throw _privateConstructorUsedError;
  bool? get location_sharing_enabled => throw _privateConstructorUsedError;
  set location_sharing_enabled(bool? value) =>
      throw _privateConstructorUsedError;
  String? get phone_number => throw _privateConstructorUsedError;
  set phone_number(String? value) => throw _privateConstructorUsedError;
  String? get x_username => throw _privateConstructorUsedError;
  set x_username(String? value) => throw _privateConstructorUsedError;
  String? get instagram_username => throw _privateConstructorUsedError;
  set instagram_username(String? value) => throw _privateConstructorUsedError;
  int? get people_helping_count => throw _privateConstructorUsedError;
  set people_helping_count(int? value) => throw _privateConstructorUsedError;
  int? get people_provide_help_count => throw _privateConstructorUsedError;
  set people_provide_help_count(int? value) =>
      throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $HelpRequestModelCopyWith<HelpRequestModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $HelpRequestModelCopyWith<$Res> {
  factory $HelpRequestModelCopyWith(
          HelpRequestModel value, $Res Function(HelpRequestModel) then) =
      _$HelpRequestModelCopyWithImpl<$Res, HelpRequestModel>;
  @useResult
  $Res call(
      {int hr_id,
      String help_request_owner_id,
      String? category,
      String? content,
      DateTime? inserted_at,
      DateTime? receive_help_at,
      double? lat,
      double? long,
      String? username,
      String? avatar_url,
      bool? location_sharing_enabled,
      String? phone_number,
      String? x_username,
      String? instagram_username,
      int? people_helping_count,
      int? people_provide_help_count});
}

/// @nodoc
class _$HelpRequestModelCopyWithImpl<$Res, $Val extends HelpRequestModel>
    implements $HelpRequestModelCopyWith<$Res> {
  _$HelpRequestModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? hr_id = null,
    Object? help_request_owner_id = null,
    Object? category = freezed,
    Object? content = freezed,
    Object? inserted_at = freezed,
    Object? receive_help_at = freezed,
    Object? lat = freezed,
    Object? long = freezed,
    Object? username = freezed,
    Object? avatar_url = freezed,
    Object? location_sharing_enabled = freezed,
    Object? phone_number = freezed,
    Object? x_username = freezed,
    Object? instagram_username = freezed,
    Object? people_helping_count = freezed,
    Object? people_provide_help_count = freezed,
  }) {
    return _then(_value.copyWith(
      hr_id: null == hr_id
          ? _value.hr_id
          : hr_id // ignore: cast_nullable_to_non_nullable
              as int,
      help_request_owner_id: null == help_request_owner_id
          ? _value.help_request_owner_id
          : help_request_owner_id // ignore: cast_nullable_to_non_nullable
              as String,
      category: freezed == category
          ? _value.category
          : category // ignore: cast_nullable_to_non_nullable
              as String?,
      content: freezed == content
          ? _value.content
          : content // ignore: cast_nullable_to_non_nullable
              as String?,
      inserted_at: freezed == inserted_at
          ? _value.inserted_at
          : inserted_at // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      receive_help_at: freezed == receive_help_at
          ? _value.receive_help_at
          : receive_help_at // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      lat: freezed == lat
          ? _value.lat
          : lat // ignore: cast_nullable_to_non_nullable
              as double?,
      long: freezed == long
          ? _value.long
          : long // ignore: cast_nullable_to_non_nullable
              as double?,
      username: freezed == username
          ? _value.username
          : username // ignore: cast_nullable_to_non_nullable
              as String?,
      avatar_url: freezed == avatar_url
          ? _value.avatar_url
          : avatar_url // ignore: cast_nullable_to_non_nullable
              as String?,
      location_sharing_enabled: freezed == location_sharing_enabled
          ? _value.location_sharing_enabled
          : location_sharing_enabled // ignore: cast_nullable_to_non_nullable
              as bool?,
      phone_number: freezed == phone_number
          ? _value.phone_number
          : phone_number // ignore: cast_nullable_to_non_nullable
              as String?,
      x_username: freezed == x_username
          ? _value.x_username
          : x_username // ignore: cast_nullable_to_non_nullable
              as String?,
      instagram_username: freezed == instagram_username
          ? _value.instagram_username
          : instagram_username // ignore: cast_nullable_to_non_nullable
              as String?,
      people_helping_count: freezed == people_helping_count
          ? _value.people_helping_count
          : people_helping_count // ignore: cast_nullable_to_non_nullable
              as int?,
      people_provide_help_count: freezed == people_provide_help_count
          ? _value.people_provide_help_count
          : people_provide_help_count // ignore: cast_nullable_to_non_nullable
              as int?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$HelpRequestModelImplCopyWith<$Res>
    implements $HelpRequestModelCopyWith<$Res> {
  factory _$$HelpRequestModelImplCopyWith(_$HelpRequestModelImpl value,
          $Res Function(_$HelpRequestModelImpl) then) =
      __$$HelpRequestModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int hr_id,
      String help_request_owner_id,
      String? category,
      String? content,
      DateTime? inserted_at,
      DateTime? receive_help_at,
      double? lat,
      double? long,
      String? username,
      String? avatar_url,
      bool? location_sharing_enabled,
      String? phone_number,
      String? x_username,
      String? instagram_username,
      int? people_helping_count,
      int? people_provide_help_count});
}

/// @nodoc
class __$$HelpRequestModelImplCopyWithImpl<$Res>
    extends _$HelpRequestModelCopyWithImpl<$Res, _$HelpRequestModelImpl>
    implements _$$HelpRequestModelImplCopyWith<$Res> {
  __$$HelpRequestModelImplCopyWithImpl(_$HelpRequestModelImpl _value,
      $Res Function(_$HelpRequestModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? hr_id = null,
    Object? help_request_owner_id = null,
    Object? category = freezed,
    Object? content = freezed,
    Object? inserted_at = freezed,
    Object? receive_help_at = freezed,
    Object? lat = freezed,
    Object? long = freezed,
    Object? username = freezed,
    Object? avatar_url = freezed,
    Object? location_sharing_enabled = freezed,
    Object? phone_number = freezed,
    Object? x_username = freezed,
    Object? instagram_username = freezed,
    Object? people_helping_count = freezed,
    Object? people_provide_help_count = freezed,
  }) {
    return _then(_$HelpRequestModelImpl(
      hr_id: null == hr_id
          ? _value.hr_id
          : hr_id // ignore: cast_nullable_to_non_nullable
              as int,
      help_request_owner_id: null == help_request_owner_id
          ? _value.help_request_owner_id
          : help_request_owner_id // ignore: cast_nullable_to_non_nullable
              as String,
      category: freezed == category
          ? _value.category
          : category // ignore: cast_nullable_to_non_nullable
              as String?,
      content: freezed == content
          ? _value.content
          : content // ignore: cast_nullable_to_non_nullable
              as String?,
      inserted_at: freezed == inserted_at
          ? _value.inserted_at
          : inserted_at // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      receive_help_at: freezed == receive_help_at
          ? _value.receive_help_at
          : receive_help_at // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      lat: freezed == lat
          ? _value.lat
          : lat // ignore: cast_nullable_to_non_nullable
              as double?,
      long: freezed == long
          ? _value.long
          : long // ignore: cast_nullable_to_non_nullable
              as double?,
      username: freezed == username
          ? _value.username
          : username // ignore: cast_nullable_to_non_nullable
              as String?,
      avatar_url: freezed == avatar_url
          ? _value.avatar_url
          : avatar_url // ignore: cast_nullable_to_non_nullable
              as String?,
      location_sharing_enabled: freezed == location_sharing_enabled
          ? _value.location_sharing_enabled
          : location_sharing_enabled // ignore: cast_nullable_to_non_nullable
              as bool?,
      phone_number: freezed == phone_number
          ? _value.phone_number
          : phone_number // ignore: cast_nullable_to_non_nullable
              as String?,
      x_username: freezed == x_username
          ? _value.x_username
          : x_username // ignore: cast_nullable_to_non_nullable
              as String?,
      instagram_username: freezed == instagram_username
          ? _value.instagram_username
          : instagram_username // ignore: cast_nullable_to_non_nullable
              as String?,
      people_helping_count: freezed == people_helping_count
          ? _value.people_helping_count
          : people_helping_count // ignore: cast_nullable_to_non_nullable
              as int?,
      people_provide_help_count: freezed == people_provide_help_count
          ? _value.people_provide_help_count
          : people_provide_help_count // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$HelpRequestModelImpl implements _HelpRequestModel {
  _$HelpRequestModelImpl(
      {required this.hr_id,
      required this.help_request_owner_id,
      this.category,
      this.content,
      this.inserted_at,
      this.receive_help_at,
      this.lat,
      this.long,
      this.username,
      this.avatar_url,
      this.location_sharing_enabled,
      this.phone_number,
      this.x_username,
      this.instagram_username,
      this.people_helping_count,
      this.people_provide_help_count});

  factory _$HelpRequestModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$HelpRequestModelImplFromJson(json);

  @override
  int hr_id;
  @override
  String help_request_owner_id;
  @override
  String? category;
  @override
  String? content;
  @override
  DateTime? inserted_at;
  @override
  DateTime? receive_help_at;
  @override
  double? lat;
  @override
  double? long;
  @override
  String? username;
  @override
  String? avatar_url;
  @override
  bool? location_sharing_enabled;
  @override
  String? phone_number;
  @override
  String? x_username;
  @override
  String? instagram_username;
  @override
  int? people_helping_count;
  @override
  int? people_provide_help_count;

  @override
  String toString() {
    return 'HelpRequestModel(hr_id: $hr_id, help_request_owner_id: $help_request_owner_id, category: $category, content: $content, inserted_at: $inserted_at, receive_help_at: $receive_help_at, lat: $lat, long: $long, username: $username, avatar_url: $avatar_url, location_sharing_enabled: $location_sharing_enabled, phone_number: $phone_number, x_username: $x_username, instagram_username: $instagram_username, people_helping_count: $people_helping_count, people_provide_help_count: $people_provide_help_count)';
  }

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$HelpRequestModelImplCopyWith<_$HelpRequestModelImpl> get copyWith =>
      __$$HelpRequestModelImplCopyWithImpl<_$HelpRequestModelImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$HelpRequestModelImplToJson(
      this,
    );
  }
}

abstract class _HelpRequestModel implements HelpRequestModel {
  factory _HelpRequestModel(
      {required int hr_id,
      required String help_request_owner_id,
      String? category,
      String? content,
      DateTime? inserted_at,
      DateTime? receive_help_at,
      double? lat,
      double? long,
      String? username,
      String? avatar_url,
      bool? location_sharing_enabled,
      String? phone_number,
      String? x_username,
      String? instagram_username,
      int? people_helping_count,
      int? people_provide_help_count}) = _$HelpRequestModelImpl;

  factory _HelpRequestModel.fromJson(Map<String, dynamic> json) =
      _$HelpRequestModelImpl.fromJson;

  @override
  int get hr_id;
  set hr_id(int value);
  @override
  String get help_request_owner_id;
  set help_request_owner_id(String value);
  @override
  String? get category;
  set category(String? value);
  @override
  String? get content;
  set content(String? value);
  @override
  DateTime? get inserted_at;
  set inserted_at(DateTime? value);
  @override
  DateTime? get receive_help_at;
  set receive_help_at(DateTime? value);
  @override
  double? get lat;
  set lat(double? value);
  @override
  double? get long;
  set long(double? value);
  @override
  String? get username;
  set username(String? value);
  @override
  String? get avatar_url;
  set avatar_url(String? value);
  @override
  bool? get location_sharing_enabled;
  set location_sharing_enabled(bool? value);
  @override
  String? get phone_number;
  set phone_number(String? value);
  @override
  String? get x_username;
  set x_username(String? value);
  @override
  String? get instagram_username;
  set instagram_username(String? value);
  @override
  int? get people_helping_count;
  set people_helping_count(int? value);
  @override
  int? get people_provide_help_count;
  set people_provide_help_count(int? value);
  @override
  @JsonKey(ignore: true)
  _$$HelpRequestModelImplCopyWith<_$HelpRequestModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
