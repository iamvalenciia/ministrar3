// ignore_for_file: non_constant_identifier_names

import 'package:freezed_annotation/freezed_annotation.dart';

part 'people_helping_in_my_hr.freezed.dart';
part 'people_helping_in_my_hr.g.dart';

@freezed
class PeopleHelpingInMyHelpRequest with _$PeopleHelpingInMyHelpRequest {
  factory PeopleHelpingInMyHelpRequest({
    int? activity_id, // Change this to String
    required String? activity_owner,
    bool? status,
    String? username,
    String? avatar_url,
  }) = _PeopleHelpingInMyHelpRequest;

  factory PeopleHelpingInMyHelpRequest.fromJson(Map<String, dynamic> json) =>
      _$PeopleHelpingInMyHelpRequestFromJson(json);
}
