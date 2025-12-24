// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'lodging_booking.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_LodgingBooking _$LodgingBookingFromJson(Map<String, dynamic> json) =>
    _LodgingBooking(
      id: json['id'] as String,
      userId: json['user_id'] as String,
      lodgingId: json['lodging_id'] as String,
      startDate: DateTime.parse(json['start_date'] as String),
      endDate: DateTime.parse(json['end_date'] as String),
      nights: (json['nights'] as num).toInt(),
      totalPrice: (json['total_price'] as num?)?.toDouble() ?? 0.0,
      guests: (json['guests'] as num?)?.toInt() ?? 1,
      status: json['status'] as String? ?? 'pending',
      note: json['note'] as String? ?? null,
      createdAt: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
      updatedAt: json['updated_at'] == null
          ? null
          : DateTime.parse(json['updated_at'] as String),
    );

Map<String, dynamic> _$LodgingBookingToJson(_LodgingBooking instance) =>
    <String, dynamic>{
      'id': instance.id,
      'user_id': instance.userId,
      'lodging_id': instance.lodgingId,
      'start_date': instance.startDate.toIso8601String(),
      'end_date': instance.endDate.toIso8601String(),
      'nights': instance.nights,
      'total_price': instance.totalPrice,
      'guests': instance.guests,
      'status': instance.status,
      'note': instance.note,
      'created_at': instance.createdAt?.toIso8601String(),
      'updated_at': instance.updatedAt?.toIso8601String(),
    };
