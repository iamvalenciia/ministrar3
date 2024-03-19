import 'package:freezed_annotation/freezed_annotation.dart';

part 'activity_model.freezed.dart';
part 'activity_model.g.dart';

@unfreezed
class Activitie with _$Activitie {
  factory Activitie({
    int? id,
    required String activity_owner,
    required DateTime inserted_at,
    required String post_owner,
    bool? status,
    DateTime? status_updated_at,
  }) = _Activitie;

  factory Activitie.fromJson(Map<String, dynamic> json) =>
      _$ActivitieFromJson(json);
}
