import 'package:freezed_annotation/freezed_annotation.dart';

part 'help_requests_model.freezed.dart';
part 'help_requests_model.g.dart';

@freezed
class HelpRequestsModel with _$HelpRequestsModel {
  factory HelpRequestsModel({
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
  }) = _HelpRequestsModel;

  factory HelpRequestsModel.fromJson(Map<String, dynamic> json) =>
      _$HelpRequestsModelFromJson(json);
}
