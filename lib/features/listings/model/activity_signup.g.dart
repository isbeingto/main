// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'activity_signup.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ActivitySignup _$ActivitySignupFromJson(Map<String, dynamic> json) =>
    _ActivitySignup(
      id: json['id'] as String,
      userId: json['user_id'] as String,
      activityId: json['activity_id'] as String,
      qty: (json['qty'] as num).toInt(),
      totalPrice: (json['total_price'] as num).toDouble(),
      note: json['note'] as String?,
      status: json['status'] as String,
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
    );

Map<String, dynamic> _$ActivitySignupToJson(_ActivitySignup instance) =>
    <String, dynamic>{
      'id': instance.id,
      'user_id': instance.userId,
      'activity_id': instance.activityId,
      'qty': instance.qty,
      'total_price': instance.totalPrice,
      'note': instance.note,
      'status': instance.status,
      'created_at': instance.createdAt.toIso8601String(),
      'updated_at': instance.updatedAt.toIso8601String(),
    };
