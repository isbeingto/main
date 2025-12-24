// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'premium_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$PremiumState {
  List<Product> get products;
  int get selectedIndex;
  List<Package>? get availablePackages;
  bool? get isPurchaseSuccessfully;
  bool? get isRestoreSuccessfully;

  /// Create a copy of PremiumState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $PremiumStateCopyWith<PremiumState> get copyWith =>
      _$PremiumStateCopyWithImpl<PremiumState>(
          this as PremiumState, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is PremiumState &&
            const DeepCollectionEquality().equals(other.products, products) &&
            (identical(other.selectedIndex, selectedIndex) ||
                other.selectedIndex == selectedIndex) &&
            const DeepCollectionEquality()
                .equals(other.availablePackages, availablePackages) &&
            (identical(other.isPurchaseSuccessfully, isPurchaseSuccessfully) ||
                other.isPurchaseSuccessfully == isPurchaseSuccessfully) &&
            (identical(other.isRestoreSuccessfully, isRestoreSuccessfully) ||
                other.isRestoreSuccessfully == isRestoreSuccessfully));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(products),
      selectedIndex,
      const DeepCollectionEquality().hash(availablePackages),
      isPurchaseSuccessfully,
      isRestoreSuccessfully);

  @override
  String toString() {
    return 'PremiumState(products: $products, selectedIndex: $selectedIndex, availablePackages: $availablePackages, isPurchaseSuccessfully: $isPurchaseSuccessfully, isRestoreSuccessfully: $isRestoreSuccessfully)';
  }
}

/// @nodoc
abstract mixin class $PremiumStateCopyWith<$Res> {
  factory $PremiumStateCopyWith(
          PremiumState value, $Res Function(PremiumState) _then) =
      _$PremiumStateCopyWithImpl;
  @useResult
  $Res call(
      {List<Product> products,
      int selectedIndex,
      List<Package>? availablePackages,
      bool? isPurchaseSuccessfully,
      bool? isRestoreSuccessfully});
}

/// @nodoc
class _$PremiumStateCopyWithImpl<$Res> implements $PremiumStateCopyWith<$Res> {
  _$PremiumStateCopyWithImpl(this._self, this._then);

  final PremiumState _self;
  final $Res Function(PremiumState) _then;

  /// Create a copy of PremiumState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? products = null,
    Object? selectedIndex = null,
    Object? availablePackages = freezed,
    Object? isPurchaseSuccessfully = freezed,
    Object? isRestoreSuccessfully = freezed,
  }) {
    return _then(_self.copyWith(
      products: null == products
          ? _self.products
          : products // ignore: cast_nullable_to_non_nullable
              as List<Product>,
      selectedIndex: null == selectedIndex
          ? _self.selectedIndex
          : selectedIndex // ignore: cast_nullable_to_non_nullable
              as int,
      availablePackages: freezed == availablePackages
          ? _self.availablePackages
          : availablePackages // ignore: cast_nullable_to_non_nullable
              as List<Package>?,
      isPurchaseSuccessfully: freezed == isPurchaseSuccessfully
          ? _self.isPurchaseSuccessfully
          : isPurchaseSuccessfully // ignore: cast_nullable_to_non_nullable
              as bool?,
      isRestoreSuccessfully: freezed == isRestoreSuccessfully
          ? _self.isRestoreSuccessfully
          : isRestoreSuccessfully // ignore: cast_nullable_to_non_nullable
              as bool?,
    ));
  }
}

/// Adds pattern-matching-related methods to [PremiumState].
extension PremiumStatePatterns on PremiumState {
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
    TResult Function(_PremiumState value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _PremiumState() when $default != null:
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
    TResult Function(_PremiumState value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _PremiumState():
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
    TResult? Function(_PremiumState value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _PremiumState() when $default != null:
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
            List<Product> products,
            int selectedIndex,
            List<Package>? availablePackages,
            bool? isPurchaseSuccessfully,
            bool? isRestoreSuccessfully)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _PremiumState() when $default != null:
        return $default(
            _that.products,
            _that.selectedIndex,
            _that.availablePackages,
            _that.isPurchaseSuccessfully,
            _that.isRestoreSuccessfully);
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
            List<Product> products,
            int selectedIndex,
            List<Package>? availablePackages,
            bool? isPurchaseSuccessfully,
            bool? isRestoreSuccessfully)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _PremiumState():
        return $default(
            _that.products,
            _that.selectedIndex,
            _that.availablePackages,
            _that.isPurchaseSuccessfully,
            _that.isRestoreSuccessfully);
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
            List<Product> products,
            int selectedIndex,
            List<Package>? availablePackages,
            bool? isPurchaseSuccessfully,
            bool? isRestoreSuccessfully)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _PremiumState() when $default != null:
        return $default(
            _that.products,
            _that.selectedIndex,
            _that.availablePackages,
            _that.isPurchaseSuccessfully,
            _that.isRestoreSuccessfully);
      case _:
        return null;
    }
  }
}

/// @nodoc

class _PremiumState implements PremiumState {
  const _PremiumState(
      {required final List<Product> products,
      required this.selectedIndex,
      final List<Package>? availablePackages,
      this.isPurchaseSuccessfully,
      this.isRestoreSuccessfully})
      : _products = products,
        _availablePackages = availablePackages;

  final List<Product> _products;
  @override
  List<Product> get products {
    if (_products is EqualUnmodifiableListView) return _products;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_products);
  }

  @override
  final int selectedIndex;
  final List<Package>? _availablePackages;
  @override
  List<Package>? get availablePackages {
    final value = _availablePackages;
    if (value == null) return null;
    if (_availablePackages is EqualUnmodifiableListView)
      return _availablePackages;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  final bool? isPurchaseSuccessfully;
  @override
  final bool? isRestoreSuccessfully;

  /// Create a copy of PremiumState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$PremiumStateCopyWith<_PremiumState> get copyWith =>
      __$PremiumStateCopyWithImpl<_PremiumState>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _PremiumState &&
            const DeepCollectionEquality().equals(other._products, _products) &&
            (identical(other.selectedIndex, selectedIndex) ||
                other.selectedIndex == selectedIndex) &&
            const DeepCollectionEquality()
                .equals(other._availablePackages, _availablePackages) &&
            (identical(other.isPurchaseSuccessfully, isPurchaseSuccessfully) ||
                other.isPurchaseSuccessfully == isPurchaseSuccessfully) &&
            (identical(other.isRestoreSuccessfully, isRestoreSuccessfully) ||
                other.isRestoreSuccessfully == isRestoreSuccessfully));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_products),
      selectedIndex,
      const DeepCollectionEquality().hash(_availablePackages),
      isPurchaseSuccessfully,
      isRestoreSuccessfully);

  @override
  String toString() {
    return 'PremiumState(products: $products, selectedIndex: $selectedIndex, availablePackages: $availablePackages, isPurchaseSuccessfully: $isPurchaseSuccessfully, isRestoreSuccessfully: $isRestoreSuccessfully)';
  }
}

/// @nodoc
abstract mixin class _$PremiumStateCopyWith<$Res>
    implements $PremiumStateCopyWith<$Res> {
  factory _$PremiumStateCopyWith(
          _PremiumState value, $Res Function(_PremiumState) _then) =
      __$PremiumStateCopyWithImpl;
  @override
  @useResult
  $Res call(
      {List<Product> products,
      int selectedIndex,
      List<Package>? availablePackages,
      bool? isPurchaseSuccessfully,
      bool? isRestoreSuccessfully});
}

/// @nodoc
class __$PremiumStateCopyWithImpl<$Res>
    implements _$PremiumStateCopyWith<$Res> {
  __$PremiumStateCopyWithImpl(this._self, this._then);

  final _PremiumState _self;
  final $Res Function(_PremiumState) _then;

  /// Create a copy of PremiumState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? products = null,
    Object? selectedIndex = null,
    Object? availablePackages = freezed,
    Object? isPurchaseSuccessfully = freezed,
    Object? isRestoreSuccessfully = freezed,
  }) {
    return _then(_PremiumState(
      products: null == products
          ? _self._products
          : products // ignore: cast_nullable_to_non_nullable
              as List<Product>,
      selectedIndex: null == selectedIndex
          ? _self.selectedIndex
          : selectedIndex // ignore: cast_nullable_to_non_nullable
              as int,
      availablePackages: freezed == availablePackages
          ? _self._availablePackages
          : availablePackages // ignore: cast_nullable_to_non_nullable
              as List<Package>?,
      isPurchaseSuccessfully: freezed == isPurchaseSuccessfully
          ? _self.isPurchaseSuccessfully
          : isPurchaseSuccessfully // ignore: cast_nullable_to_non_nullable
              as bool?,
      isRestoreSuccessfully: freezed == isRestoreSuccessfully
          ? _self.isRestoreSuccessfully
          : isRestoreSuccessfully // ignore: cast_nullable_to_non_nullable
              as bool?,
    ));
  }
}

// dart format on
