// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_view_model.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$myOrdersHash() => r'6c7a8638a1eb3427d82cd09534937125572f186a';

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

/// See also [myOrders].
@ProviderFor(myOrders)
const myOrdersProvider = MyOrdersFamily();

/// See also [myOrders].
class MyOrdersFamily extends Family<AsyncValue<List<ProductOrder>>> {
  /// See also [myOrders].
  const MyOrdersFamily();

  /// See also [myOrders].
  MyOrdersProvider call(
    String userId,
  ) {
    return MyOrdersProvider(
      userId,
    );
  }

  @override
  MyOrdersProvider getProviderOverride(
    covariant MyOrdersProvider provider,
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
  String? get name => r'myOrdersProvider';
}

/// See also [myOrders].
class MyOrdersProvider extends AutoDisposeFutureProvider<List<ProductOrder>> {
  /// See also [myOrders].
  MyOrdersProvider(
    String userId,
  ) : this._internal(
          (ref) => myOrders(
            ref as MyOrdersRef,
            userId,
          ),
          from: myOrdersProvider,
          name: r'myOrdersProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$myOrdersHash,
          dependencies: MyOrdersFamily._dependencies,
          allTransitiveDependencies: MyOrdersFamily._allTransitiveDependencies,
          userId: userId,
        );

  MyOrdersProvider._internal(
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
  Override overrideWith(
    FutureOr<List<ProductOrder>> Function(MyOrdersRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: MyOrdersProvider._internal(
        (ref) => create(ref as MyOrdersRef),
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
  AutoDisposeFutureProviderElement<List<ProductOrder>> createElement() {
    return _MyOrdersProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is MyOrdersProvider && other.userId == userId;
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
mixin MyOrdersRef on AutoDisposeFutureProviderRef<List<ProductOrder>> {
  /// The parameter `userId` of this provider.
  String get userId;
}

class _MyOrdersProviderElement
    extends AutoDisposeFutureProviderElement<List<ProductOrder>>
    with MyOrdersRef {
  _MyOrdersProviderElement(super.provider);

  @override
  String get userId => (origin as MyOrdersProvider).userId;
}

String _$productByOrderHash() => r'354d24fcb9632281b6655c8e8c44886a828c14e8';

/// See also [productByOrder].
@ProviderFor(productByOrder)
const productByOrderProvider = ProductByOrderFamily();

/// See also [productByOrder].
class ProductByOrderFamily extends Family<AsyncValue<Product?>> {
  /// See also [productByOrder].
  const ProductByOrderFamily();

  /// See also [productByOrder].
  ProductByOrderProvider call(
    String productId,
  ) {
    return ProductByOrderProvider(
      productId,
    );
  }

  @override
  ProductByOrderProvider getProviderOverride(
    covariant ProductByOrderProvider provider,
  ) {
    return call(
      provider.productId,
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
  String? get name => r'productByOrderProvider';
}

/// See also [productByOrder].
class ProductByOrderProvider extends AutoDisposeFutureProvider<Product?> {
  /// See also [productByOrder].
  ProductByOrderProvider(
    String productId,
  ) : this._internal(
          (ref) => productByOrder(
            ref as ProductByOrderRef,
            productId,
          ),
          from: productByOrderProvider,
          name: r'productByOrderProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$productByOrderHash,
          dependencies: ProductByOrderFamily._dependencies,
          allTransitiveDependencies:
              ProductByOrderFamily._allTransitiveDependencies,
          productId: productId,
        );

  ProductByOrderProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.productId,
  }) : super.internal();

  final String productId;

  @override
  Override overrideWith(
    FutureOr<Product?> Function(ProductByOrderRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: ProductByOrderProvider._internal(
        (ref) => create(ref as ProductByOrderRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        productId: productId,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<Product?> createElement() {
    return _ProductByOrderProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is ProductByOrderProvider && other.productId == productId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, productId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin ProductByOrderRef on AutoDisposeFutureProviderRef<Product?> {
  /// The parameter `productId` of this provider.
  String get productId;
}

class _ProductByOrderProviderElement
    extends AutoDisposeFutureProviderElement<Product?> with ProductByOrderRef {
  _ProductByOrderProviderElement(super.provider);

  @override
  String get productId => (origin as ProductByOrderProvider).productId;
}

String _$orderViewModelHash() => r'16290967bbd5213f630d963afd2ffcf5555facf3';

/// See also [OrderViewModel].
@ProviderFor(OrderViewModel)
final orderViewModelProvider =
    AutoDisposeAsyncNotifierProvider<OrderViewModel, void>.internal(
  OrderViewModel.new,
  name: r'orderViewModelProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$orderViewModelHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$OrderViewModel = AutoDisposeAsyncNotifier<void>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
