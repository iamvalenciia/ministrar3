// ignore_for_file: non_constant_identifier_names

import 'package:freezed_annotation/freezed_annotation.dart';

part 'help_request_model.freezed.dart';
part 'help_request_model.g.dart';

@unfreezed
class HelpRequestModel with _$HelpRequestModel {
  factory HelpRequestModel({
    required int id,
    String? user_id,
    String? category,
    String? content,
    DateTime? inserted_at,
    DateTime? receive_help_at,
    double? lat,
    double? long,
    String? username,
    String? avatar_url,
    double? distance, // this is not included in the database
  }) = _HelpRequestModel;

  factory HelpRequestModel.fromJson(Map<String, dynamic> json) =>
      _$HelpRequestModelFromJson(json);
}
