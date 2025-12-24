// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

part 'listing.freezed.dart';
part 'listing.g.dart';

@freezed
abstract class Listing with _$Listing {
  const factory Listing({
    required String id,
    required String title,
    @Default(null) String? description,
    @Default(null) String? location,
    @JsonKey(name: 'price_per_night') @Default(null) double? pricePerNight,
    @JsonKey(name: 'max_guests') @Default(2) int maxGuests,
    @Default(1) int bedrooms,
    @Default(1) int bathrooms,
    @Default([]) List<String> amenities,
    @JsonKey(name: 'host_id') @Default(null) String? hostId,
    @JsonKey(name: 'is_active') @Default(true) bool isActive,
    @JsonKey(name: 'created_at') @Default(null) DateTime? createdAt,
    @JsonKey(name: 'updated_at') @Default(null) DateTime? updatedAt,
    // Joined photos (optional)
    @JsonKey(name: 'listing_photos') @Default([]) List<ListingPhoto> photos,
  }) = _Listing;

  factory Listing.fromJson(Map<String, dynamic> json) =>
      _$ListingFromJson(json);
}

@freezed
abstract class ListingPhoto with _$ListingPhoto {
  const factory ListingPhoto({
    required String id,
    @JsonKey(name: 'listing_id') required String listingId,
    @JsonKey(name: 'photo_url') required String photoUrl,
    @Default(null) String? caption,
    @JsonKey(name: 'display_order') @Default(0) int displayOrder,
    @JsonKey(name: 'created_at') @Default(null) DateTime? createdAt,
  }) = _ListingPhoto;

  factory ListingPhoto.fromJson(Map<String, dynamic> json) =>
      _$ListingPhotoFromJson(json);
}
