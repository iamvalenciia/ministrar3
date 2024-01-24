import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_id.freezed.dart';
part 'user_id.g.dart';

/// The response of the `GET /api/activity` endpoint.
///
/// It is defined using `freezed` and `json_serializable`.
@freezed
class UserId with _$UserId {
  factory UserId({
    required String id,
  }) = _UserId;

  /// Convert a JSON object into an [UserId] instance.
  /// This enables type-safe reading of the API response.
  factory UserId.fromJson(Map<String, dynamic> json) => _$UserIdFromJson(json);
}
