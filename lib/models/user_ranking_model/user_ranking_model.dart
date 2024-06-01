// ignore_for_file: non_constant_identifier_names

import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_ranking_model.freezed.dart';
part 'user_ranking_model.g.dart';

@freezed
class UserRanking with _$UserRanking {
  factory UserRanking({
    required int user_position,
    required String user_id,
    required String? username,
    required String? full_name,
    required int help_count,
    String? avatar_url, // Added avatar_url field
  }) = _UserRanking;

  factory UserRanking.fromJson(Map<String, dynamic> json) =>
      _$UserRankingFromJson(json);
}
