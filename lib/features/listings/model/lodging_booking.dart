// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

part 'lodging_booking.freezed.dart';
part 'lodging_booking.g.dart';

@freezed
abstract class LodgingBooking with _$LodgingBooking {
  const factory LodgingBooking({
    required String id,
    @JsonKey(name: 'user_id') required String userId,
    @JsonKey(name: 'lodging_id') required String lodgingId,
    @JsonKey(name: 'start_date') required DateTime startDate,
    @JsonKey(name: 'end_date') required DateTime endDate,
    required int nights,
    @JsonKey(name: 'total_price') @Default(0.0) double totalPrice,
    @Default(1) int guests,
    @Default('pending') String status,
    @Default(null) String? note,
    @JsonKey(name: 'created_at') @Default(null) DateTime? createdAt,
    @JsonKey(name: 'updated_at') @Default(null) DateTime? updatedAt,
  }) = _LodgingBooking;

  factory LodgingBooking.fromJson(Map<String, dynamic> json) =>
      _$LodgingBookingFromJson(json);
}
