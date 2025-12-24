// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'booking_view_model.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$bookingViewModelHash() => r'4f08a3194b2764675f8ea65d0bb2567767ea93b4';

/// See also [BookingViewModel].
@ProviderFor(BookingViewModel)
final bookingViewModelProvider = AutoDisposeNotifierProvider<BookingViewModel,
    AsyncValue<BookingRequest?>>.internal(
  BookingViewModel.new,
  name: r'bookingViewModelProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$bookingViewModelHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$BookingViewModel = AutoDisposeNotifier<AsyncValue<BookingRequest?>>;
String _$lodgingBookingViewModelHash() =>
    r'975b2187e48b92457d36557db2aaaa91e33c7900';

/// See also [LodgingBookingViewModel].
@ProviderFor(LodgingBookingViewModel)
final lodgingBookingViewModelProvider =
    AutoDisposeAsyncNotifierProvider<LodgingBookingViewModel, void>.internal(
  LodgingBookingViewModel.new,
  name: r'lodgingBookingViewModelProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$lodgingBookingViewModelHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$LodgingBookingViewModel = AutoDisposeAsyncNotifier<void>;
String _$myBookingsViewModelHash() =>
    r'f1fa1b940b635c7868e0695ad1a3ccbca52b26ce';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

abstract class _$MyBookingsViewModel
    extends BuildlessAutoDisposeAsyncNotifier<List<LodgingBooking>> {
  late final String userId;

  FutureOr<List<LodgingBooking>> build(
    String userId,
  );
}

/// See also [MyBookingsViewModel].
@ProviderFor(MyBookingsViewModel)
const myBookingsViewModelProvider = MyBookingsViewModelFamily();

/// See also [MyBookingsViewModel].
class MyBookingsViewModelFamily
    extends Family<AsyncValue<List<LodgingBooking>>> {
  /// See also [MyBookingsViewModel].
  const MyBookingsViewModelFamily();

  /// See also [MyBookingsViewModel].
  MyBookingsViewModelProvider call(
    String userId,
  ) {
    return MyBookingsViewModelProvider(
      userId,
    );
  }

  @override
  MyBookingsViewModelProvider getProviderOverride(
    covariant MyBookingsViewModelProvider provider,
  ) {
    return call(
      provider.userId,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'myBookingsViewModelProvider';
}

/// See also [MyBookingsViewModel].
class MyBookingsViewModelProvider extends AutoDisposeAsyncNotifierProviderImpl<
    MyBookingsViewModel, List<LodgingBooking>> {
  /// See also [MyBookingsViewModel].
  MyBookingsViewModelProvider(
    String userId,
  ) : this._internal(
          () => MyBookingsViewModel()..userId = userId,
          from: myBookingsViewModelProvider,
          name: r'myBookingsViewModelProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$myBookingsViewModelHash,
          dependencies: MyBookingsViewModelFamily._dependencies,
          allTransitiveDependencies:
              MyBookingsViewModelFamily._allTransitiveDependencies,
          userId: userId,
        );

  MyBookingsViewModelProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.userId,
  }) : super.internal();

  final String userId;

  @override
  FutureOr<List<LodgingBooking>> runNotifierBuild(
    covariant MyBookingsViewModel notifier,
  ) {
    return notifier.build(
      userId,
    );
  }

  @override
  Override overrideWith(MyBookingsViewModel Function() create) {
    return ProviderOverride(
      origin: this,
      override: MyBookingsViewModelProvider._internal(
        () => create()..userId = userId,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        userId: userId,
      ),
    );
  }

  @override
  AutoDisposeAsyncNotifierProviderElement<MyBookingsViewModel,
      List<LodgingBooking>> createElement() {
    return _MyBookingsViewModelProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is MyBookingsViewModelProvider && other.userId == userId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, userId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin MyBookingsViewModelRef
    on AutoDisposeAsyncNotifierProviderRef<List<LodgingBooking>> {
  /// The parameter `userId` of this provider.
  String get userId;
}

class _MyBookingsViewModelProviderElement
    extends AutoDisposeAsyncNotifierProviderElement<MyBookingsViewModel,
        List<LodgingBooking>> with MyBookingsViewModelRef {
  _MyBookingsViewModelProviderElement(super.provider);

  @override
  String get userId => (origin as MyBookingsViewModelProvider).userId;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
