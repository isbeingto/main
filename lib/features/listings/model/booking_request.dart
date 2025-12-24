// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

part 'booking_request.freezed.dart';
part 'booking_request.g.dart';

@freezed
abstract class BookingRequest with _$BookingRequest {
  const factory BookingRequest({
    @Default(null) String? id,
    @JsonKey(name: 'listing_id') required String listingId,
    @JsonKey(name: 'user_id') @Default(null) String? userId,
    @JsonKey(name: 'start_date') @Default(null) DateTime? startDate,
    @JsonKey(name: 'end_date') @Default(null) DateTime? endDate,
    @Default(1) int guests,
    @Default(null) String? note,
    @Default('pending') String status,
    @JsonKey(name: 'created_at') @Default(null) DateTime? createdAt,
    @JsonKey(name: 'updated_at') @Default(null) DateTime? updatedAt,
  }) = _BookingRequest;

  factory BookingRequest.fromJson(Map<String, dynamic> json) =>
      _$BookingRequestFromJson(json);
}
