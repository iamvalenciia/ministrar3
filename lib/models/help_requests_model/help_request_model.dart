// ignore_for_file: non_constant_identifier_names

import 'package:freezed_annotation/freezed_annotation.dart';

part 'help_request_model.freezed.dart';
part 'help_request_model.g.dart';

@unfreezed
class HelpRequestModel with _$HelpRequestModel {
  factory HelpRequestModel({
    required int hr_id,
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
    int? people_provide_help_count,
  }) = _HelpRequestModel;

  factory HelpRequestModel.fromJson(Map<String, dynamic> json) =>
      _$HelpRequestModelFromJson(json);
}
