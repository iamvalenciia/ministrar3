// ignore_for_file: non_constant_identifier_names

import 'package:freezed_annotation/freezed_annotation.dart';

part 'activity_model.freezed.dart';
part 'activity_model.g.dart';

@freezed
class Activity with _$Activity {
  factory Activity({
    int? activity_id,
    String? activity_type, // Change this to String
    required String? activity_owner,
    required DateTime? inserted_at,
    bool? status,
    DateTime? status_updated_at,
    String? help_request_owner_id,
  }) = _Activity;

  factory Activity.fromJson(Map<String, dynamic> json) =>
      _$ActivityFromJson(json);
}
