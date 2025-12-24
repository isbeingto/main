// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'listing.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Listing {
  String get id;
  String get title;
  String? get description;
  String? get location;
  @JsonKey(name: 'price_per_night')
  double? get pricePerNight;
  @JsonKey(name: 'max_guests')
  int get maxGuests;
  int get bedrooms;
  int get bathrooms;
  List<String> get amenities;
  @JsonKey(name: 'host_id')
  String? get hostId;
  @JsonKey(name: 'is_active')
  bool get isActive;
  @JsonKey(name: 'created_at')
  DateTime? get createdAt;
  @JsonKey(name: 'updated_at')
  DateTime? get updatedAt; // Joined photos (optional)
  @JsonKey(name: 'listing_photos')
  List<ListingPhoto> get photos;

  /// Create a copy of Listing
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $ListingCopyWith<Listing> get copyWith =>
      _$ListingCopyWithImpl<Listing>(this as Listing, _$identity);

  /// Serializes this Listing to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is Listing &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.location, location) ||
                other.location == location) &&
            (identical(other.pricePerNight, pricePerNight) ||
                other.pricePerNight == pricePerNight) &&
            (identical(other.maxGuests, maxGuests) ||
                other.maxGuests == maxGuests) &&
            (identical(other.bedrooms, bedrooms) ||
                other.bedrooms == bedrooms) &&
            (identical(other.bathrooms, bathrooms) ||
                other.bathrooms == bathrooms) &&
            const DeepCollectionEquality().equals(other.amenities, amenities) &&
            (identical(other.hostId, hostId) || other.hostId == hostId) &&
            (identical(other.isActive, isActive) ||
                other.isActive == isActive) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt) &&
            const DeepCollectionEquality().equals(other.photos, photos));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      title,
      description,
      location,
      pricePerNight,
      maxGuests,
      bedrooms,
      bathrooms,
      const DeepCollectionEquality().hash(amenities),
      hostId,
      isActive,
      createdAt,
      updatedAt,
      const DeepCollectionEquality().hash(photos));

  @override
  String toString() {
    return 'Listing(id: $id, title: $title, description: $description, location: $location, pricePerNight: $pricePerNight, maxGuests: $maxGuests, bedrooms: $bedrooms, bathrooms: $bathrooms, amenities: $amenities, hostId: $hostId, isActive: $isActive, createdAt: $createdAt, updatedAt: $updatedAt, photos: $photos)';
  }
}

/// @nodoc
abstract mixin class $ListingCopyWith<$Res> {
  factory $ListingCopyWith(Listing value, $Res Function(Listing) _then) =
      _$ListingCopyWithImpl;
  @useResult
  $Res call(
      {String id,
      String title,
      String? description,
      String? location,
      @JsonKey(name: 'price_per_night') double? pricePerNight,
      @JsonKey(name: 'max_guests') int maxGuests,
      int bedrooms,
      int bathrooms,
      List<String> amenities,
      @JsonKey(name: 'host_id') String? hostId,
      @JsonKey(name: 'is_active') bool isActive,
      @JsonKey(name: 'created_at') DateTime? createdAt,
      @JsonKey(name: 'updated_at') DateTime? updatedAt,
      @JsonKey(name: 'listing_photos') List<ListingPhoto> photos});
}

/// @nodoc
class _$ListingCopyWithImpl<$Res> implements $ListingCopyWith<$Res> {
  _$ListingCopyWithImpl(this._self, this._then);

  final Listing _self;
  final $Res Function(Listing) _then;

  /// Create a copy of Listing
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? description = freezed,
    Object? location = freezed,
    Object? pricePerNight = freezed,
    Object? maxGuests = null,
    Object? bedrooms = null,
    Object? bathrooms = null,
    Object? amenities = null,
    Object? hostId = freezed,
    Object? isActive = null,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
    Object? photos = null,
  }) {
    return _then(_self.copyWith(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _self.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      description: freezed == description
          ? _self.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      location: freezed == location
          ? _self.location
          : location // ignore: cast_nullable_to_non_nullable
              as String?,
      pricePerNight: freezed == pricePerNight
          ? _self.pricePerNight
          : pricePerNight // ignore: cast_nullable_to_non_nullable
              as double?,
      maxGuests: null == maxGuests
          ? _self.maxGuests
          : maxGuests // ignore: cast_nullable_to_non_nullable
              as int,
      bedrooms: null == bedrooms
          ? _self.bedrooms
          : bedrooms // ignore: cast_nullable_to_non_nullable
              as int,
      bathrooms: null == bathrooms
          ? _self.bathrooms
          : bathrooms // ignore: cast_nullable_to_non_nullable
              as int,
      amenities: null == amenities
          ? _self.amenities
          : amenities // ignore: cast_nullable_to_non_nullable
              as List<String>,
      hostId: freezed == hostId
          ? _self.hostId
          : hostId // ignore: cast_nullable_to_non_nullable
              as String?,
      isActive: null == isActive
          ? _self.isActive
          : isActive // ignore: cast_nullable_to_non_nullable
              as bool,
      createdAt: freezed == createdAt
          ? _self.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      updatedAt: freezed == updatedAt
          ? _self.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      photos: null == photos
          ? _self.photos
          : photos // ignore: cast_nullable_to_non_nullable
              as List<ListingPhoto>,
    ));
  }
}

/// Adds pattern-matching-related methods to [Listing].
extension ListingPatterns on Listing {
  /// A variant of `map` that fallback to returning `orElse`.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case _:
  ///     return orElse();
  /// }
  /// ```

  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(_Listing value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _Listing() when $default != null:
        return $default(_that);
      case _:
        return orElse();
    }
  }

  /// A `switch`-like method, using callbacks.
  ///
  /// Callbacks receives the raw object, upcasted.
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case final Subclass2 value:
  ///     return ...;
  /// }
  /// ```

  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(_Listing value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Listing():
        return $default(_that);
      case _:
        throw StateError('Unexpected subclass');
    }
  }

  /// A variant of `map` that fallback to returning `null`.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case _:
  ///     return null;
  /// }
  /// ```

  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>(
    TResult? Function(_Listing value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Listing() when $default != null:
        return $default(_that);
      case _:
        return null;
    }
  }

  /// A variant of `when` that fallback to an `orElse` callback.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case _:
  ///     return orElse();
  /// }
  /// ```

  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(
            String id,
            String title,
            String? description,
            String? location,
            @JsonKey(name: 'price_per_night') double? pricePerNight,
            @JsonKey(name: 'max_guests') int maxGuests,
            int bedrooms,
            int bathrooms,
            List<String> amenities,
            @JsonKey(name: 'host_id') String? hostId,
            @JsonKey(name: 'is_active') bool isActive,
            @JsonKey(name: 'created_at') DateTime? createdAt,
            @JsonKey(name: 'updated_at') DateTime? updatedAt,
            @JsonKey(name: 'listing_photos') List<ListingPhoto> photos)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _Listing() when $default != null:
        return $default(
            _that.id,
            _that.title,
            _that.description,
            _that.location,
            _that.pricePerNight,
            _that.maxGuests,
            _that.bedrooms,
            _that.bathrooms,
            _that.amenities,
            _that.hostId,
            _that.isActive,
            _that.createdAt,
            _that.updatedAt,
            _that.photos);
      case _:
        return orElse();
    }
  }

  /// A `switch`-like method, using callbacks.
  ///
  /// As opposed to `map`, this offers destructuring.
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case Subclass2(:final field2):
  ///     return ...;
  /// }
  /// ```

  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(
            String id,
            String title,
            String? description,
            String? location,
            @JsonKey(name: 'price_per_night') double? pricePerNight,
            @JsonKey(name: 'max_guests') int maxGuests,
            int bedrooms,
            int bathrooms,
            List<String> amenities,
            @JsonKey(name: 'host_id') String? hostId,
            @JsonKey(name: 'is_active') bool isActive,
            @JsonKey(name: 'created_at') DateTime? createdAt,
            @JsonKey(name: 'updated_at') DateTime? updatedAt,
            @JsonKey(name: 'listing_photos') List<ListingPhoto> photos)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Listing():
        return $default(
            _that.id,
            _that.title,
            _that.description,
            _that.location,
            _that.pricePerNight,
            _that.maxGuests,
            _that.bedrooms,
            _that.bathrooms,
            _that.amenities,
            _that.hostId,
            _that.isActive,
            _that.createdAt,
            _that.updatedAt,
            _that.photos);
      case _:
        throw StateError('Unexpected subclass');
    }
  }

  /// A variant of `when` that fallback to returning `null`
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case _:
  ///     return null;
  /// }
  /// ```

  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult? Function(
            String id,
            String title,
            String? description,
            String? location,
            @JsonKey(name: 'price_per_night') double? pricePerNight,
            @JsonKey(name: 'max_guests') int maxGuests,
            int bedrooms,
            int bathrooms,
            List<String> amenities,
            @JsonKey(name: 'host_id') String? hostId,
            @JsonKey(name: 'is_active') bool isActive,
            @JsonKey(name: 'created_at') DateTime? createdAt,
            @JsonKey(name: 'updated_at') DateTime? updatedAt,
            @JsonKey(name: 'listing_photos') List<ListingPhoto> photos)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Listing() when $default != null:
        return $default(
            _that.id,
            _that.title,
            _that.description,
            _that.location,
            _that.pricePerNight,
            _that.maxGuests,
            _that.bedrooms,
            _that.bathrooms,
            _that.amenities,
            _that.hostId,
            _that.isActive,
            _that.createdAt,
            _that.updatedAt,
            _that.photos);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _Listing implements Listing {
  const _Listing(
      {required this.id,
      required this.title,
      this.description = null,
      this.location = null,
      @JsonKey(name: 'price_per_night') this.pricePerNight = null,
      @JsonKey(name: 'max_guests') this.maxGuests = 2,
      this.bedrooms = 1,
      this.bathrooms = 1,
      final List<String> amenities = const [],
      @JsonKey(name: 'host_id') this.hostId = null,
      @JsonKey(name: 'is_active') this.isActive = true,
      @JsonKey(name: 'created_at') this.createdAt = null,
      @JsonKey(name: 'updated_at') this.updatedAt = null,
      @JsonKey(name: 'listing_photos')
      final List<ListingPhoto> photos = const []})
      : _amenities = amenities,
        _photos = photos;
  factory _Listing.fromJson(Map<String, dynamic> json) =>
      _$ListingFromJson(json);

  @override
  final String id;
  @override
  final String title;
  @override
  @JsonKey()
  final String? description;
  @override
  @JsonKey()
  final String? location;
  @override
  @JsonKey(name: 'price_per_night')
  final double? pricePerNight;
  @override
  @JsonKey(name: 'max_guests')
  final int maxGuests;
  @override
  @JsonKey()
  final int bedrooms;
  @override
  @JsonKey()
  final int bathrooms;
  final List<String> _amenities;
  @override
  @JsonKey()
  List<String> get amenities {
    if (_amenities is EqualUnmodifiableListView) return _amenities;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_amenities);
  }

  @override
  @JsonKey(name: 'host_id')
  final String? hostId;
  @override
  @JsonKey(name: 'is_active')
  final bool isActive;
  @override
  @JsonKey(name: 'created_at')
  final DateTime? createdAt;
  @override
  @JsonKey(name: 'updated_at')
  final DateTime? updatedAt;
// Joined photos (optional)
  final List<ListingPhoto> _photos;
// Joined photos (optional)
  @override
  @JsonKey(name: 'listing_photos')
  List<ListingPhoto> get photos {
    if (_photos is EqualUnmodifiableListView) return _photos;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_photos);
  }

  /// Create a copy of Listing
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$ListingCopyWith<_Listing> get copyWith =>
      __$ListingCopyWithImpl<_Listing>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$ListingToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _Listing &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.location, location) ||
                other.location == location) &&
            (identical(other.pricePerNight, pricePerNight) ||
                other.pricePerNight == pricePerNight) &&
            (identical(other.maxGuests, maxGuests) ||
                other.maxGuests == maxGuests) &&
            (identical(other.bedrooms, bedrooms) ||
                other.bedrooms == bedrooms) &&
            (identical(other.bathrooms, bathrooms) ||
                other.bathrooms == bathrooms) &&
            const DeepCollectionEquality()
                .equals(other._amenities, _amenities) &&
            (identical(other.hostId, hostId) || other.hostId == hostId) &&
            (identical(other.isActive, isActive) ||
                other.isActive == isActive) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt) &&
            const DeepCollectionEquality().equals(other._photos, _photos));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      title,
      description,
      location,
      pricePerNight,
      maxGuests,
      bedrooms,
      bathrooms,
      const DeepCollectionEquality().hash(_amenities),
      hostId,
      isActive,
      createdAt,
      updatedAt,
      const DeepCollectionEquality().hash(_photos));

  @override
  String toString() {
    return 'Listing(id: $id, title: $title, description: $description, location: $location, pricePerNight: $pricePerNight, maxGuests: $maxGuests, bedrooms: $bedrooms, bathrooms: $bathrooms, amenities: $amenities, hostId: $hostId, isActive: $isActive, createdAt: $createdAt, updatedAt: $updatedAt, photos: $photos)';
  }
}

/// @nodoc
abstract mixin class _$ListingCopyWith<$Res> implements $ListingCopyWith<$Res> {
  factory _$ListingCopyWith(_Listing value, $Res Function(_Listing) _then) =
      __$ListingCopyWithImpl;
  @override
  @useResult
  $Res call(
      {String id,
      String title,
      String? description,
      String? location,
      @JsonKey(name: 'price_per_night') double? pricePerNight,
      @JsonKey(name: 'max_guests') int maxGuests,
      int bedrooms,
      int bathrooms,
      List<String> amenities,
      @JsonKey(name: 'host_id') String? hostId,
      @JsonKey(name: 'is_active') bool isActive,
      @JsonKey(name: 'created_at') DateTime? createdAt,
      @JsonKey(name: 'updated_at') DateTime? updatedAt,
      @JsonKey(name: 'listing_photos') List<ListingPhoto> photos});
}

/// @nodoc
class __$ListingCopyWithImpl<$Res> implements _$ListingCopyWith<$Res> {
  __$ListingCopyWithImpl(this._self, this._then);

  final _Listing _self;
  final $Res Function(_Listing) _then;

  /// Create a copy of Listing
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? description = freezed,
    Object? location = freezed,
    Object? pricePerNight = freezed,
    Object? maxGuests = null,
    Object? bedrooms = null,
    Object? bathrooms = null,
    Object? amenities = null,
    Object? hostId = freezed,
    Object? isActive = null,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
    Object? photos = null,
  }) {
    return _then(_Listing(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _self.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      description: freezed == description
          ? _self.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      location: freezed == location
          ? _self.location
          : location // ignore: cast_nullable_to_non_nullable
              as String?,
      pricePerNight: freezed == pricePerNight
          ? _self.pricePerNight
          : pricePerNight // ignore: cast_nullable_to_non_nullable
              as double?,
      maxGuests: null == maxGuests
          ? _self.maxGuests
          : maxGuests // ignore: cast_nullable_to_non_nullable
              as int,
      bedrooms: null == bedrooms
          ? _self.bedrooms
          : bedrooms // ignore: cast_nullable_to_non_nullable
              as int,
      bathrooms: null == bathrooms
          ? _self.bathrooms
          : bathrooms // ignore: cast_nullable_to_non_nullable
              as int,
      amenities: null == amenities
          ? _self._amenities
          : amenities // ignore: cast_nullable_to_non_nullable
              as List<String>,
      hostId: freezed == hostId
          ? _self.hostId
          : hostId // ignore: cast_nullable_to_non_nullable
              as String?,
      isActive: null == isActive
          ? _self.isActive
          : isActive // ignore: cast_nullable_to_non_nullable
              as bool,
      createdAt: freezed == createdAt
          ? _self.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      updatedAt: freezed == updatedAt
          ? _self.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      photos: null == photos
          ? _self._photos
          : photos // ignore: cast_nullable_to_non_nullable
              as List<ListingPhoto>,
    ));
  }
}

/// @nodoc
mixin _$ListingPhoto {
  String get id;
  @JsonKey(name: 'listing_id')
  String get listingId;
  @JsonKey(name: 'photo_url')
  String get photoUrl;
  String? get caption;
  @JsonKey(name: 'display_order')
  int get displayOrder;
  @JsonKey(name: 'created_at')
  DateTime? get createdAt;

  /// Create a copy of ListingPhoto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $ListingPhotoCopyWith<ListingPhoto> get copyWith =>
      _$ListingPhotoCopyWithImpl<ListingPhoto>(
          this as ListingPhoto, _$identity);

  /// Serializes this ListingPhoto to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is ListingPhoto &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.listingId, listingId) ||
                other.listingId == listingId) &&
            (identical(other.photoUrl, photoUrl) ||
                other.photoUrl == photoUrl) &&
            (identical(other.caption, caption) || other.caption == caption) &&
            (identical(other.displayOrder, displayOrder) ||
                other.displayOrder == displayOrder) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, id, listingId, photoUrl, caption, displayOrder, createdAt);

  @override
  String toString() {
    return 'ListingPhoto(id: $id, listingId: $listingId, photoUrl: $photoUrl, caption: $caption, displayOrder: $displayOrder, createdAt: $createdAt)';
  }
}

/// @nodoc
abstract mixin class $ListingPhotoCopyWith<$Res> {
  factory $ListingPhotoCopyWith(
          ListingPhoto value, $Res Function(ListingPhoto) _then) =
      _$ListingPhotoCopyWithImpl;
  @useResult
  $Res call(
      {String id,
      @JsonKey(name: 'listing_id') String listingId,
      @JsonKey(name: 'photo_url') String photoUrl,
      String? caption,
      @JsonKey(name: 'display_order') int displayOrder,
      @JsonKey(name: 'created_at') DateTime? createdAt});
}

/// @nodoc
class _$ListingPhotoCopyWithImpl<$Res> implements $ListingPhotoCopyWith<$Res> {
  _$ListingPhotoCopyWithImpl(this._self, this._then);

  final ListingPhoto _self;
  final $Res Function(ListingPhoto) _then;

  /// Create a copy of ListingPhoto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? listingId = null,
    Object? photoUrl = null,
    Object? caption = freezed,
    Object? displayOrder = null,
    Object? createdAt = freezed,
  }) {
    return _then(_self.copyWith(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      listingId: null == listingId
          ? _self.listingId
          : listingId // ignore: cast_nullable_to_non_nullable
              as String,
      photoUrl: null == photoUrl
          ? _self.photoUrl
          : photoUrl // ignore: cast_nullable_to_non_nullable
              as String,
      caption: freezed == caption
          ? _self.caption
          : caption // ignore: cast_nullable_to_non_nullable
              as String?,
      displayOrder: null == displayOrder
          ? _self.displayOrder
          : displayOrder // ignore: cast_nullable_to_non_nullable
              as int,
      createdAt: freezed == createdAt
          ? _self.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// Adds pattern-matching-related methods to [ListingPhoto].
extension ListingPhotoPatterns on ListingPhoto {
  /// A variant of `map` that fallback to returning `orElse`.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case _:
  ///     return orElse();
  /// }
  /// ```

  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(_ListingPhoto value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _ListingPhoto() when $default != null:
        return $default(_that);
      case _:
        return orElse();
    }
  }

  /// A `switch`-like method, using callbacks.
  ///
  /// Callbacks receives the raw object, upcasted.
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case final Subclass2 value:
  ///     return ...;
  /// }
  /// ```

  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(_ListingPhoto value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ListingPhoto():
        return $default(_that);
      case _:
        throw StateError('Unexpected subclass');
    }
  }

  /// A variant of `map` that fallback to returning `null`.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case _:
  ///     return null;
  /// }
  /// ```

  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>(
    TResult? Function(_ListingPhoto value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ListingPhoto() when $default != null:
        return $default(_that);
      case _:
        return null;
    }
  }

  /// A variant of `when` that fallback to an `orElse` callback.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case _:
  ///     return orElse();
  /// }
  /// ```

  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(
            String id,
            @JsonKey(name: 'listing_id') String listingId,
            @JsonKey(name: 'photo_url') String photoUrl,
            String? caption,
            @JsonKey(name: 'display_order') int displayOrder,
            @JsonKey(name: 'created_at') DateTime? createdAt)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _ListingPhoto() when $default != null:
        return $default(_that.id, _that.listingId, _that.photoUrl,
            _that.caption, _that.displayOrder, _that.createdAt);
      case _:
        return orElse();
    }
  }

  /// A `switch`-like method, using callbacks.
  ///
  /// As opposed to `map`, this offers destructuring.
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case Subclass2(:final field2):
  ///     return ...;
  /// }
  /// ```

  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(
            String id,
            @JsonKey(name: 'listing_id') String listingId,
            @JsonKey(name: 'photo_url') String photoUrl,
            String? caption,
            @JsonKey(name: 'display_order') int displayOrder,
            @JsonKey(name: 'created_at') DateTime? createdAt)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ListingPhoto():
        return $default(_that.id, _that.listingId, _that.photoUrl,
            _that.caption, _that.displayOrder, _that.createdAt);
      case _:
        throw StateError('Unexpected subclass');
    }
  }

  /// A variant of `when` that fallback to returning `null`
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case _:
  ///     return null;
  /// }
  /// ```

  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult? Function(
            String id,
            @JsonKey(name: 'listing_id') String listingId,
            @JsonKey(name: 'photo_url') String photoUrl,
            String? caption,
            @JsonKey(name: 'display_order') int displayOrder,
            @JsonKey(name: 'created_at') DateTime? createdAt)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ListingPhoto() when $default != null:
        return $default(_that.id, _that.listingId, _that.photoUrl,
            _that.caption, _that.displayOrder, _that.createdAt);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _ListingPhoto implements ListingPhoto {
  const _ListingPhoto(
      {required this.id,
      @JsonKey(name: 'listing_id') required this.listingId,
      @JsonKey(name: 'photo_url') required this.photoUrl,
      this.caption = null,
      @JsonKey(name: 'display_order') this.displayOrder = 0,
      @JsonKey(name: 'created_at') this.createdAt = null});
  factory _ListingPhoto.fromJson(Map<String, dynamic> json) =>
      _$ListingPhotoFromJson(json);

  @override
  final String id;
  @override
  @JsonKey(name: 'listing_id')
  final String listingId;
  @override
  @JsonKey(name: 'photo_url')
  final String photoUrl;
  @override
  @JsonKey()
  final String? caption;
  @override
  @JsonKey(name: 'display_order')
  final int displayOrder;
  @override
  @JsonKey(name: 'created_at')
  final DateTime? createdAt;

  /// Create a copy of ListingPhoto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$ListingPhotoCopyWith<_ListingPhoto> get copyWith =>
      __$ListingPhotoCopyWithImpl<_ListingPhoto>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$ListingPhotoToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _ListingPhoto &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.listingId, listingId) ||
                other.listingId == listingId) &&
            (identical(other.photoUrl, photoUrl) ||
                other.photoUrl == photoUrl) &&
            (identical(other.caption, caption) || other.caption == caption) &&
            (identical(other.displayOrder, displayOrder) ||
                other.displayOrder == displayOrder) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, id, listingId, photoUrl, caption, displayOrder, createdAt);

  @override
  String toString() {
    return 'ListingPhoto(id: $id, listingId: $listingId, photoUrl: $photoUrl, caption: $caption, displayOrder: $displayOrder, createdAt: $createdAt)';
  }
}

/// @nodoc
abstract mixin class _$ListingPhotoCopyWith<$Res>
    implements $ListingPhotoCopyWith<$Res> {
  factory _$ListingPhotoCopyWith(
          _ListingPhoto value, $Res Function(_ListingPhoto) _then) =
      __$ListingPhotoCopyWithImpl;
  @override
  @useResult
  $Res call(
      {String id,
      @JsonKey(name: 'listing_id') String listingId,
      @JsonKey(name: 'photo_url') String photoUrl,
      String? caption,
      @JsonKey(name: 'display_order') int displayOrder,
      @JsonKey(name: 'created_at') DateTime? createdAt});
}

/// @nodoc
class __$ListingPhotoCopyWithImpl<$Res>
    implements _$ListingPhotoCopyWith<$Res> {
  __$ListingPhotoCopyWithImpl(this._self, this._then);

  final _ListingPhoto _self;
  final $Res Function(_ListingPhoto) _then;

  /// Create a copy of ListingPhoto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? id = null,
    Object? listingId = null,
    Object? photoUrl = null,
    Object? caption = freezed,
    Object? displayOrder = null,
    Object? createdAt = freezed,
  }) {
    return _then(_ListingPhoto(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      listingId: null == listingId
          ? _self.listingId
          : listingId // ignore: cast_nullable_to_non_nullable
              as String,
      photoUrl: null == photoUrl
          ? _self.photoUrl
          : photoUrl // ignore: cast_nullable_to_non_nullable
              as String,
      caption: freezed == caption
          ? _self.caption
          : caption // ignore: cast_nullable_to_non_nullable
              as String?,
      displayOrder: null == displayOrder
          ? _self.displayOrder
          : displayOrder // ignore: cast_nullable_to_non_nullable
              as int,
      createdAt: freezed == createdAt
          ? _self.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

// dart format on
