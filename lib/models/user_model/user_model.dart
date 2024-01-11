import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_model.freezed.dart';
part 'user_model.g.dart';

/// The response of the `GET /api/activity` endpoint.
///
/// It is defined using `freezed` and `json_serializable`.
@freezed
class User with _$User {
  factory User({
    required String id,
    String? updated_at,
    String? username,
    String? full_name,
    String? avatar_url,
  }) = _User;

  /// Convert a JSON object into an [User] instance.
  /// This enables type-safe reading of the API response.
  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
}
