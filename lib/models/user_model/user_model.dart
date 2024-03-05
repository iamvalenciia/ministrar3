import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_model.g.dart';
part 'user_model.freezed.dart';

/// The response of the `GET /api/activity` endpoint.
///
/// It is defined using `freezed` and `json_serializable`.
@unfreezed
class UserModel with _$UserModel {
  factory UserModel({
    String? username,
    String? full_name,
    String? avatar_url,
  }) = _UserModel;

  /// Convert a JSON object into an [UserModel] instance.
  /// This enables type-safe reading of the API response.
  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);
}
