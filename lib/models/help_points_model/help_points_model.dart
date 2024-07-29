// ignore_for_file: non_constant_identifier_names

import 'package:freezed_annotation/freezed_annotation.dart';

part 'help_points_model.freezed.dart';
part 'help_points_model.g.dart';

@freezed
class HelpPointsModel with _$HelpPointsModel {
  factory HelpPointsModel({
    int? id,
    String? user_id, // Change this to String
    int? points,
    DateTime? last_updated,
  }) = _HelpPointsModel;

  factory HelpPointsModel.fromJson(Map<String, dynamic> json) =>
      _$HelpPointsModelFromJson(json);
}
