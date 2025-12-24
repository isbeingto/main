// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'listing.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Listing _$ListingFromJson(Map<String, dynamic> json) => _Listing(
      id: json['id'] as String,
      title: json['title'] as String,
      description: json['description'] as String? ?? null,
      location: json['location'] as String? ?? null,
      pricePerNight: (json['price_per_night'] as num?)?.toDouble() ?? null,
      maxGuests: (json['max_guests'] as num?)?.toInt() ?? 2,
      bedrooms: (json['bedrooms'] as num?)?.toInt() ?? 1,
      bathrooms: (json['bathrooms'] as num?)?.toInt() ?? 1,
      amenities: (json['amenities'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      hostId: json['host_id'] as String? ?? null,
      isActive: json['is_active'] as bool? ?? true,
      createdAt: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
      updatedAt: json['updated_at'] == null
          ? null
          : DateTime.parse(json['updated_at'] as String),
      photos: (json['listing_photos'] as List<dynamic>?)
              ?.map((e) => ListingPhoto.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$ListingToJson(_Listing instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'location': instance.location,
      'price_per_night': instance.pricePerNight,
      'max_guests': instance.maxGuests,
      'bedrooms': instance.bedrooms,
      'bathrooms': instance.bathrooms,
      'amenities': instance.amenities,
      'host_id': instance.hostId,
      'is_active': instance.isActive,
      'created_at': instance.createdAt?.toIso8601String(),
      'updated_at': instance.updatedAt?.toIso8601String(),
      'listing_photos': instance.photos,
    };

_ListingPhoto _$ListingPhotoFromJson(Map<String, dynamic> json) =>
    _ListingPhoto(
      id: json['id'] as String,
      listingId: json['listing_id'] as String,
      photoUrl: json['photo_url'] as String,
      caption: json['caption'] as String? ?? null,
      displayOrder: (json['display_order'] as num?)?.toInt() ?? 0,
      createdAt: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
    );

Map<String, dynamic> _$ListingPhotoToJson(_ListingPhoto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'listing_id': instance.listingId,
      'photo_url': instance.photoUrl,
      'caption': instance.caption,
      'display_order': instance.displayOrder,
      'created_at': instance.createdAt?.toIso8601String(),
    };
