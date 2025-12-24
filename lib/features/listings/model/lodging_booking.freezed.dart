// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'lodging_booking.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$LodgingBooking {
  String get id;
  @JsonKey(name: 'user_id')
  String get userId;
  @JsonKey(name: 'lodging_id')
  String get lodgingId;
  @JsonKey(name: 'start_date')
  DateTime get startDate;
  @JsonKey(name: 'end_date')
  DateTime get endDate;
  int get nights;
  @JsonKey(name: 'total_price')
  double get totalPrice;
  int get guests;
  String get status;
  String? get note;
  @JsonKey(name: 'created_at')
  DateTime? get createdAt;
  @JsonKey(name: 'updated_at')
  DateTime? get updatedAt;

  /// Create a copy of LodgingBooking
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $LodgingBookingCopyWith<LodgingBooking> get copyWith =>
      _$LodgingBookingCopyWithImpl<LodgingBooking>(
          this as LodgingBooking, _$identity);

  /// Serializes this LodgingBooking to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is LodgingBooking &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.lodgingId, lodgingId) ||
                other.lodgingId == lodgingId) &&
            (identical(other.startDate, startDate) ||
                other.startDate == startDate) &&
            (identical(other.endDate, endDate) || other.endDate == endDate) &&
            (identical(other.nights, nights) || other.nights == nights) &&
            (identical(other.totalPrice, totalPrice) ||
                other.totalPrice == totalPrice) &&
            (identical(other.guests, guests) || other.guests == guests) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.note, note) || other.note == note) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, userId, lodgingId, startDate,
      endDate, nights, totalPrice, guests, status, note, createdAt, updatedAt);

  @override
  String toString() {
    return 'LodgingBooking(id: $id, userId: $userId, lodgingId: $lodgingId, startDate: $startDate, endDate: $endDate, nights: $nights, totalPrice: $totalPrice, guests: $guests, status: $status, note: $note, createdAt: $createdAt, updatedAt: $updatedAt)';
  }
}

/// @nodoc
abstract mixin class $LodgingBookingCopyWith<$Res> {
  factory $LodgingBookingCopyWith(
          LodgingBooking value, $Res Function(LodgingBooking) _then) =
      _$LodgingBookingCopyWithImpl;
  @useResult
  $Res call(
      {String id,
      @JsonKey(name: 'user_id') String userId,
      @JsonKey(name: 'lodging_id') String lodgingId,
      @JsonKey(name: 'start_date') DateTime startDate,
      @JsonKey(name: 'end_date') DateTime endDate,
      int nights,
      @JsonKey(name: 'total_price') double totalPrice,
      int guests,
      String status,
      String? note,
      @JsonKey(name: 'created_at') DateTime? createdAt,
      @JsonKey(name: 'updated_at') DateTime? updatedAt});
}

/// @nodoc
class _$LodgingBookingCopyWithImpl<$Res>
    implements $LodgingBookingCopyWith<$Res> {
  _$LodgingBookingCopyWithImpl(this._self, this._then);

  final LodgingBooking _self;
  final $Res Function(LodgingBooking) _then;

  /// Create a copy of LodgingBooking
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? lodgingId = null,
    Object? startDate = null,
    Object? endDate = null,
    Object? nights = null,
    Object? totalPrice = null,
    Object? guests = null,
    Object? status = null,
    Object? note = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
  }) {
    return _then(_self.copyWith(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      userId: null == userId
          ? _self.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      lodgingId: null == lodgingId
          ? _self.lodgingId
          : lodgingId // ignore: cast_nullable_to_non_nullable
              as String,
      startDate: null == startDate
          ? _self.startDate
          : startDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      endDate: null == endDate
          ? _self.endDate
          : endDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      nights: null == nights
          ? _self.nights
          : nights // ignore: cast_nullable_to_non_nullable
              as int,
      totalPrice: null == totalPrice
          ? _self.totalPrice
          : totalPrice // ignore: cast_nullable_to_non_nullable
              as double,
      guests: null == guests
          ? _self.guests
          : guests // ignore: cast_nullable_to_non_nullable
              as int,
      status: null == status
          ? _self.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      note: freezed == note
          ? _self.note
          : note // ignore: cast_nullable_to_non_nullable
              as String?,
      createdAt: freezed == createdAt
          ? _self.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      updatedAt: freezed == updatedAt
          ? _self.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// Adds pattern-matching-related methods to [LodgingBooking].
extension LodgingBookingPatterns on LodgingBooking {
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
    TResult Function(_LodgingBooking value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _LodgingBooking() when $default != null:
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
    TResult Function(_LodgingBooking value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _LodgingBooking():
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
    TResult? Function(_LodgingBooking value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _LodgingBooking() when $default != null:
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
            @JsonKey(name: 'user_id') String userId,
            @JsonKey(name: 'lodging_id') String lodgingId,
            @JsonKey(name: 'start_date') DateTime startDate,
            @JsonKey(name: 'end_date') DateTime endDate,
            int nights,
            @JsonKey(name: 'total_price') double totalPrice,
            int guests,
            String status,
            String? note,
            @JsonKey(name: 'created_at') DateTime? createdAt,
            @JsonKey(name: 'updated_at') DateTime? updatedAt)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _LodgingBooking() when $default != null:
        return $default(
            _that.id,
            _that.userId,
            _that.lodgingId,
            _that.startDate,
            _that.endDate,
            _that.nights,
            _that.totalPrice,
            _that.guests,
            _that.status,
            _that.note,
            _that.createdAt,
            _that.updatedAt);
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
            @JsonKey(name: 'user_id') String userId,
            @JsonKey(name: 'lodging_id') String lodgingId,
            @JsonKey(name: 'start_date') DateTime startDate,
            @JsonKey(name: 'end_date') DateTime endDate,
            int nights,
            @JsonKey(name: 'total_price') double totalPrice,
            int guests,
            String status,
            String? note,
            @JsonKey(name: 'created_at') DateTime? createdAt,
            @JsonKey(name: 'updated_at') DateTime? updatedAt)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _LodgingBooking():
        return $default(
            _that.id,
            _that.userId,
            _that.lodgingId,
            _that.startDate,
            _that.endDate,
            _that.nights,
            _that.totalPrice,
            _that.guests,
            _that.status,
            _that.note,
            _that.createdAt,
            _that.updatedAt);
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
            @JsonKey(name: 'user_id') String userId,
            @JsonKey(name: 'lodging_id') String lodgingId,
            @JsonKey(name: 'start_date') DateTime startDate,
            @JsonKey(name: 'end_date') DateTime endDate,
            int nights,
            @JsonKey(name: 'total_price') double totalPrice,
            int guests,
            String status,
            String? note,
            @JsonKey(name: 'created_at') DateTime? createdAt,
            @JsonKey(name: 'updated_at') DateTime? updatedAt)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _LodgingBooking() when $default != null:
        return $default(
            _that.id,
            _that.userId,
            _that.lodgingId,
            _that.startDate,
            _that.endDate,
            _that.nights,
            _that.totalPrice,
            _that.guests,
            _that.status,
            _that.note,
            _that.createdAt,
            _that.updatedAt);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _LodgingBooking implements LodgingBooking {
  const _LodgingBooking(
      {required this.id,
      @JsonKey(name: 'user_id') required this.userId,
      @JsonKey(name: 'lodging_id') required this.lodgingId,
      @JsonKey(name: 'start_date') required this.startDate,
      @JsonKey(name: 'end_date') required this.endDate,
      required this.nights,
      @JsonKey(name: 'total_price') this.totalPrice = 0.0,
      this.guests = 1,
      this.status = 'pending',
      this.note = null,
      @JsonKey(name: 'created_at') this.createdAt = null,
      @JsonKey(name: 'updated_at') this.updatedAt = null});
  factory _LodgingBooking.fromJson(Map<String, dynamic> json) =>
      _$LodgingBookingFromJson(json);

  @override
  final String id;
  @override
  @JsonKey(name: 'user_id')
  final String userId;
  @override
  @JsonKey(name: 'lodging_id')
  final String lodgingId;
  @override
  @JsonKey(name: 'start_date')
  final DateTime startDate;
  @override
  @JsonKey(name: 'end_date')
  final DateTime endDate;
  @override
  final int nights;
  @override
  @JsonKey(name: 'total_price')
  final double totalPrice;
  @override
  @JsonKey()
  final int guests;
  @override
  @JsonKey()
  final String status;
  @override
  @JsonKey()
  final String? note;
  @override
  @JsonKey(name: 'created_at')
  final DateTime? createdAt;
  @override
  @JsonKey(name: 'updated_at')
  final DateTime? updatedAt;

  /// Create a copy of LodgingBooking
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$LodgingBookingCopyWith<_LodgingBooking> get copyWith =>
      __$LodgingBookingCopyWithImpl<_LodgingBooking>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$LodgingBookingToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _LodgingBooking &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.lodgingId, lodgingId) ||
                other.lodgingId == lodgingId) &&
            (identical(other.startDate, startDate) ||
                other.startDate == startDate) &&
            (identical(other.endDate, endDate) || other.endDate == endDate) &&
            (identical(other.nights, nights) || other.nights == nights) &&
            (identical(other.totalPrice, totalPrice) ||
                other.totalPrice == totalPrice) &&
            (identical(other.guests, guests) || other.guests == guests) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.note, note) || other.note == note) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, userId, lodgingId, startDate,
      endDate, nights, totalPrice, guests, status, note, createdAt, updatedAt);

  @override
  String toString() {
    return 'LodgingBooking(id: $id, userId: $userId, lodgingId: $lodgingId, startDate: $startDate, endDate: $endDate, nights: $nights, totalPrice: $totalPrice, guests: $guests, status: $status, note: $note, createdAt: $createdAt, updatedAt: $updatedAt)';
  }
}

/// @nodoc
abstract mixin class _$LodgingBookingCopyWith<$Res>
    implements $LodgingBookingCopyWith<$Res> {
  factory _$LodgingBookingCopyWith(
          _LodgingBooking value, $Res Function(_LodgingBooking) _then) =
      __$LodgingBookingCopyWithImpl;
  @override
  @useResult
  $Res call(
      {String id,
      @JsonKey(name: 'user_id') String userId,
      @JsonKey(name: 'lodging_id') String lodgingId,
      @JsonKey(name: 'start_date') DateTime startDate,
      @JsonKey(name: 'end_date') DateTime endDate,
      int nights,
      @JsonKey(name: 'total_price') double totalPrice,
      int guests,
      String status,
      String? note,
      @JsonKey(name: 'created_at') DateTime? createdAt,
      @JsonKey(name: 'updated_at') DateTime? updatedAt});
}

/// @nodoc
class __$LodgingBookingCopyWithImpl<$Res>
    implements _$LodgingBookingCopyWith<$Res> {
  __$LodgingBookingCopyWithImpl(this._self, this._then);

  final _LodgingBooking _self;
  final $Res Function(_LodgingBooking) _then;

  /// Create a copy of LodgingBooking
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? lodgingId = null,
    Object? startDate = null,
    Object? endDate = null,
    Object? nights = null,
    Object? totalPrice = null,
    Object? guests = null,
    Object? status = null,
    Object? note = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
  }) {
    return _then(_LodgingBooking(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      userId: null == userId
          ? _self.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      lodgingId: null == lodgingId
          ? _self.lodgingId
          : lodgingId // ignore: cast_nullable_to_non_nullable
              as String,
      startDate: null == startDate
          ? _self.startDate
          : startDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      endDate: null == endDate
          ? _self.endDate
          : endDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      nights: null == nights
          ? _self.nights
          : nights // ignore: cast_nullable_to_non_nullable
              as int,
      totalPrice: null == totalPrice
          ? _self.totalPrice
          : totalPrice // ignore: cast_nullable_to_non_nullable
              as double,
      guests: null == guests
          ? _self.guests
          : guests // ignore: cast_nullable_to_non_nullable
              as int,
      status: null == status
          ? _self.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      note: freezed == note
          ? _self.note
          : note // ignore: cast_nullable_to_non_nullable
              as String?,
      createdAt: freezed == createdAt
          ? _self.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      updatedAt: freezed == updatedAt
          ? _self.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

// dart format on
