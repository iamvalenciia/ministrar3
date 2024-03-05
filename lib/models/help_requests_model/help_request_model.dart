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
    bool? is_active,
    DateTime? inserted_at,
    DateTime? updated_at,
    double? lat,
    double? long,
    String? username,
    String? avatar_url,
    double? distance,
  }) = _HelpRequestModel;

  factory HelpRequestModel.fromJson(Map<String, dynamic> json) =>
      _$HelpRequestModelFromJson(json);
}
