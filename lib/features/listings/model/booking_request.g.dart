// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'booking_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_BookingRequest _$BookingRequestFromJson(Map<String, dynamic> json) =>
    _BookingRequest(
      id: json['id'] as String? ?? null,
      listingId: json['listing_id'] as String,
      userId: json['user_id'] as String? ?? null,
      startDate: json['start_date'] == null
          ? null
          : DateTime.parse(json['start_date'] as String),
      endDate: json['end_date'] == null
          ? null
          : DateTime.parse(json['end_date'] as String),
      guests: (json['guests'] as num?)?.toInt() ?? 1,
      note: json['note'] as String? ?? null,
      status: json['status'] as String? ?? 'pending',
      createdAt: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
      updatedAt: json['updated_at'] == null
          ? null
          : DateTime.parse(json['updated_at'] as String),
    );

Map<String, dynamic> _$BookingRequestToJson(_BookingRequest instance) =>
    <String, dynamic>{
      'id': instance.id,
      'listing_id': instance.listingId,
      'user_id': instance.userId,
      'start_date': instance.startDate?.toIso8601String(),
      'end_date': instance.endDate?.toIso8601String(),
      'guests': instance.guests,
      'note': instance.note,
      'status': instance.status,
      'created_at': instance.createdAt?.toIso8601String(),
      'updated_at': instance.updatedAt?.toIso8601String(),
    };
