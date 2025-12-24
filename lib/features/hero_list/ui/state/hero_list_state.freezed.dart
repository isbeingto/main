// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'hero_list_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$HeroListState {
  List<Hero> get heroes;
  bool get isLoading;
  String? get errorMessage;

  /// Create a copy of HeroListState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $HeroListStateCopyWith<HeroListState> get copyWith =>
      _$HeroListStateCopyWithImpl<HeroListState>(
          this as HeroListState, _$identity);

  /// Serializes this HeroListState to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is HeroListState &&
            const DeepCollectionEquality().equals(other.heroes, heroes) &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading) &&
            (identical(other.errorMessage, errorMessage) ||
                other.errorMessage == errorMessage));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType,
      const DeepCollectionEquality().hash(heroes), isLoading, errorMessage);

  @override
  String toString() {
    return 'HeroListState(heroes: $heroes, isLoading: $isLoading, errorMessage: $errorMessage)';
  }
}

/// @nodoc
abstract mixin class $HeroListStateCopyWith<$Res> {
  factory $HeroListStateCopyWith(
          HeroListState value, $Res Function(HeroListState) _then) =
      _$HeroListStateCopyWithImpl;
  @useResult
  $Res call({List<Hero> heroes, bool isLoading, String? errorMessage});
}

/// @nodoc
class _$HeroListStateCopyWithImpl<$Res>
    implements $HeroListStateCopyWith<$Res> {
  _$HeroListStateCopyWithImpl(this._self, this._then);

  final HeroListState _self;
  final $Res Function(HeroListState) _then;

  /// Create a copy of HeroListState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? heroes = null,
    Object? isLoading = null,
    Object? errorMessage = freezed,
  }) {
    return _then(_self.copyWith(
      heroes: null == heroes
          ? _self.heroes
          : heroes // ignore: cast_nullable_to_non_nullable
              as List<Hero>,
      isLoading: null == isLoading
          ? _self.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      errorMessage: freezed == errorMessage
          ? _self.errorMessage
          : errorMessage // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// Adds pattern-matching-related methods to [HeroListState].
extension HeroListStatePatterns on HeroListState {
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
    TResult Function(_HeroListState value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _HeroListState() when $default != null:
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
    TResult Function(_HeroListState value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _HeroListState():
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
    TResult? Function(_HeroListState value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _HeroListState() when $default != null:
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
    TResult Function(List<Hero> heroes, bool isLoading, String? errorMessage)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _HeroListState() when $default != null:
        return $default(_that.heroes, _that.isLoading, _that.errorMessage);
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
    TResult Function(List<Hero> heroes, bool isLoading, String? errorMessage)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _HeroListState():
        return $default(_that.heroes, _that.isLoading, _that.errorMessage);
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
    TResult? Function(List<Hero> heroes, bool isLoading, String? errorMessage)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _HeroListState() when $default != null:
        return $default(_that.heroes, _that.isLoading, _that.errorMessage);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _HeroListState implements HeroListState {
  const _HeroListState(
      {final List<Hero> heroes = const [],
      this.isLoading = false,
      this.errorMessage})
      : _heroes = heroes;
  factory _HeroListState.fromJson(Map<String, dynamic> json) =>
      _$HeroListStateFromJson(json);

  final List<Hero> _heroes;
  @override
  @JsonKey()
  List<Hero> get heroes {
    if (_heroes is EqualUnmodifiableListView) return _heroes;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_heroes);
  }

  @override
  @JsonKey()
  final bool isLoading;
  @override
  final String? errorMessage;

  /// Create a copy of HeroListState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$HeroListStateCopyWith<_HeroListState> get copyWith =>
      __$HeroListStateCopyWithImpl<_HeroListState>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$HeroListStateToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _HeroListState &&
            const DeepCollectionEquality().equals(other._heroes, _heroes) &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading) &&
            (identical(other.errorMessage, errorMessage) ||
                other.errorMessage == errorMessage));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType,
      const DeepCollectionEquality().hash(_heroes), isLoading, errorMessage);

  @override
  String toString() {
    return 'HeroListState(heroes: $heroes, isLoading: $isLoading, errorMessage: $errorMessage)';
  }
}

/// @nodoc
abstract mixin class _$HeroListStateCopyWith<$Res>
    implements $HeroListStateCopyWith<$Res> {
  factory _$HeroListStateCopyWith(
          _HeroListState value, $Res Function(_HeroListState) _then) =
      __$HeroListStateCopyWithImpl;
  @override
  @useResult
  $Res call({List<Hero> heroes, bool isLoading, String? errorMessage});
}

/// @nodoc
class __$HeroListStateCopyWithImpl<$Res>
    implements _$HeroListStateCopyWith<$Res> {
  __$HeroListStateCopyWithImpl(this._self, this._then);

  final _HeroListState _self;
  final $Res Function(_HeroListState) _then;

  /// Create a copy of HeroListState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? heroes = null,
    Object? isLoading = null,
    Object? errorMessage = freezed,
  }) {
    return _then(_HeroListState(
      heroes: null == heroes
          ? _self._heroes
          : heroes // ignore: cast_nullable_to_non_nullable
              as List<Hero>,
      isLoading: null == isLoading
          ? _self.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      errorMessage: freezed == errorMessage
          ? _self.errorMessage
          : errorMessage // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

// dart format on
