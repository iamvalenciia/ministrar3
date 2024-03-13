import 'package:freezed_annotation/freezed_annotation.dart';

part 'activity_help_model.freezed.dart';
part 'activity_help_model.g.dart';

@freezed
class ActivityHelpModel with _$ActivityHelpModel {
  factory ActivityHelpModel({
    required int id,
    int? post_id,
    String? helper_id,
    DateTime? created_at,
    bool? status,
  }) = _ActivityHelpModel;

  factory ActivityHelpModel.fromJson(Map<String, dynamic> json) =>
      _$ActivityHelpModelFromJson(json);
}
