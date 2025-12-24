// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'listings_view_model.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$listingDetailHash() => r'3fa6b72063e045b570f5942a4494cfcdd675316c';

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

/// See also [listingDetail].
@ProviderFor(listingDetail)
const listingDetailProvider = ListingDetailFamily();

/// See also [listingDetail].
class ListingDetailFamily extends Family<AsyncValue<Listing?>> {
  /// See also [listingDetail].
  const ListingDetailFamily();

  /// See also [listingDetail].
  ListingDetailProvider call(
    String id,
  ) {
    return ListingDetailProvider(
      id,
    );
  }

  @override
  ListingDetailProvider getProviderOverride(
    covariant ListingDetailProvider provider,
  ) {
    return call(
      provider.id,
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
  String? get name => r'listingDetailProvider';
}

/// See also [listingDetail].
class ListingDetailProvider extends AutoDisposeFutureProvider<Listing?> {
  /// See also [listingDetail].
  ListingDetailProvider(
    String id,
  ) : this._internal(
          (ref) => listingDetail(
            ref as ListingDetailRef,
            id,
          ),
          from: listingDetailProvider,
          name: r'listingDetailProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$listingDetailHash,
          dependencies: ListingDetailFamily._dependencies,
          allTransitiveDependencies:
              ListingDetailFamily._allTransitiveDependencies,
          id: id,
        );

  ListingDetailProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.id,
  }) : super.internal();

  final String id;

  @override
  Override overrideWith(
    FutureOr<Listing?> Function(ListingDetailRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: ListingDetailProvider._internal(
        (ref) => create(ref as ListingDetailRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        id: id,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<Listing?> createElement() {
    return _ListingDetailProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is ListingDetailProvider && other.id == id;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, id.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin ListingDetailRef on AutoDisposeFutureProviderRef<Listing?> {
  /// The parameter `id` of this provider.
  String get id;
}

class _ListingDetailProviderElement
    extends AutoDisposeFutureProviderElement<Listing?> with ListingDetailRef {
  _ListingDetailProviderElement(super.provider);

  @override
  String get id => (origin as ListingDetailProvider).id;
}

String _$listingsViewModelHash() => r'0a8b340457c3b6eeef889bc7e8ad62b37446920a';

/// See also [ListingsViewModel].
@ProviderFor(ListingsViewModel)
final listingsViewModelProvider =
    AutoDisposeAsyncNotifierProvider<ListingsViewModel, List<Listing>>.internal(
  ListingsViewModel.new,
  name: r'listingsViewModelProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$listingsViewModelHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$ListingsViewModel = AutoDisposeAsyncNotifier<List<Listing>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
