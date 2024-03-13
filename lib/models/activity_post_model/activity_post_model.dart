import 'package:freezed_annotation/freezed_annotation.dart';

part 'activity_post_model.freezed.dart';
part 'activity_post_model.g.dart';

@freezed
class ActivityPostModel with _$ActivityPostModel {
  factory ActivityPostModel({
    required int id,
    required String owner_id,
    required DateTime created_at,
  }) = _ActivityPostModel;

  factory ActivityPostModel.fromJson(Map<String, dynamic> json) =>
      _$ActivityPostModelFromJson(json);
}
