// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

part 'activity_signup.freezed.dart';
part 'activity_signup.g.dart';

@freezed
abstract class ActivitySignup with _$ActivitySignup {
  const factory ActivitySignup({
    required String id,
    @JsonKey(name: 'user_id') required String userId,
    @JsonKey(name: 'activity_id') required String activityId,
    required int qty,
    @JsonKey(name: 'total_price') required double totalPrice,
    String? note,
    required String status,
    @JsonKey(name: 'created_at') required DateTime createdAt,
    @JsonKey(name: 'updated_at') required DateTime updatedAt,
  }) = _ActivitySignup;

  factory ActivitySignup.fromJson(Map<String, dynamic> json) =>
      _$ActivitySignupFromJson(json);
}
