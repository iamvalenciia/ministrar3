// ignore_for_file: non_constant_identifier_names

import 'package:freezed_annotation/freezed_annotation.dart';

part 'activity_model.freezed.dart';
part 'activity_model.g.dart';

@freezed
class Activity with _$Activity {
  factory Activity({
    int? activity_id,
    required String activity_owner,
    required DateTime inserted_at,
    required String post_owner,
    String? activity_type, // Change this to String
    bool? status,
    DateTime? status_updated_at,
  }) = _Activity;

  factory Activity.fromJson(Map<String, dynamic> json) =>
      _$ActivityFromJson(json);
}
