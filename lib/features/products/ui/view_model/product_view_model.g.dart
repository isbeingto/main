// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_view_model.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$productViewModelHash() => r'76ab939e26248530186f0668b84750b14bfb0dd3';

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

abstract class _$ProductViewModel
    extends BuildlessAutoDisposeAsyncNotifier<List<Product>> {
  late final String? category;

  FutureOr<List<Product>> build({
    String? category,
  });
}

/// See also [ProductViewModel].
@ProviderFor(ProductViewModel)
const productViewModelProvider = ProductViewModelFamily();

/// See also [ProductViewModel].
class ProductViewModelFamily extends Family<AsyncValue<List<Product>>> {
  /// See also [ProductViewModel].
  const ProductViewModelFamily();

  /// See also [ProductViewModel].
  ProductViewModelProvider call({
    String? category,
  }) {
    return ProductViewModelProvider(
      category: category,
    );
  }

  @override
  ProductViewModelProvider getProviderOverride(
    covariant ProductViewModelProvider provider,
  ) {
    return call(
      category: provider.category,
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
  String? get name => r'productViewModelProvider';
}

/// See also [ProductViewModel].
class ProductViewModelProvider extends AutoDisposeAsyncNotifierProviderImpl<
    ProductViewModel, List<Product>> {
  /// See also [ProductViewModel].
  ProductViewModelProvider({
    String? category,
  }) : this._internal(
          () => ProductViewModel()..category = category,
          from: productViewModelProvider,
          name: r'productViewModelProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$productViewModelHash,
          dependencies: ProductViewModelFamily._dependencies,
          allTransitiveDependencies:
              ProductViewModelFamily._allTransitiveDependencies,
          category: category,
        );

  ProductViewModelProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.category,
  }) : super.internal();

  final String? category;

  @override
  FutureOr<List<Product>> runNotifierBuild(
    covariant ProductViewModel notifier,
  ) {
    return notifier.build(
      category: category,
    );
  }

  @override
  Override overrideWith(ProductViewModel Function() create) {
    return ProviderOverride(
      origin: this,
      override: ProductViewModelProvider._internal(
        () => create()..category = category,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        category: category,
      ),
    );
  }

  @override
  AutoDisposeAsyncNotifierProviderElement<ProductViewModel, List<Product>>
      createElement() {
    return _ProductViewModelProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is ProductViewModelProvider && other.category == category;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, category.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin ProductViewModelRef
    on AutoDisposeAsyncNotifierProviderRef<List<Product>> {
  /// The parameter `category` of this provider.
  String? get category;
}

class _ProductViewModelProviderElement
    extends AutoDisposeAsyncNotifierProviderElement<ProductViewModel,
        List<Product>> with ProductViewModelRef {
  _ProductViewModelProviderElement(super.provider);

  @override
  String? get category => (origin as ProductViewModelProvider).category;
}

String _$productDetailViewModelHash() =>
    r'1358d9f873c9abd74440ce50ee25ace484d35c0b';

abstract class _$ProductDetailViewModel
    extends BuildlessAutoDisposeAsyncNotifier<Product?> {
  late final String id;

  FutureOr<Product?> build(
    String id,
  );
}

/// See also [ProductDetailViewModel].
@ProviderFor(ProductDetailViewModel)
const productDetailViewModelProvider = ProductDetailViewModelFamily();

/// See also [ProductDetailViewModel].
class ProductDetailViewModelFamily extends Family<AsyncValue<Product?>> {
  /// See also [ProductDetailViewModel].
  const ProductDetailViewModelFamily();

  /// See also [ProductDetailViewModel].
  ProductDetailViewModelProvider call(
    String id,
  ) {
    return ProductDetailViewModelProvider(
      id,
    );
  }

  @override
  ProductDetailViewModelProvider getProviderOverride(
    covariant ProductDetailViewModelProvider provider,
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
  String? get name => r'productDetailViewModelProvider';
}

/// See also [ProductDetailViewModel].
class ProductDetailViewModelProvider
    extends AutoDisposeAsyncNotifierProviderImpl<ProductDetailViewModel,
        Product?> {
  /// See also [ProductDetailViewModel].
  ProductDetailViewModelProvider(
    String id,
  ) : this._internal(
          () => ProductDetailViewModel()..id = id,
          from: productDetailViewModelProvider,
          name: r'productDetailViewModelProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$productDetailViewModelHash,
          dependencies: ProductDetailViewModelFamily._dependencies,
          allTransitiveDependencies:
              ProductDetailViewModelFamily._allTransitiveDependencies,
          id: id,
        );

  ProductDetailViewModelProvider._internal(
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
  FutureOr<Product?> runNotifierBuild(
    covariant ProductDetailViewModel notifier,
  ) {
    return notifier.build(
      id,
    );
  }

  @override
  Override overrideWith(ProductDetailViewModel Function() create) {
    return ProviderOverride(
      origin: this,
      override: ProductDetailViewModelProvider._internal(
        () => create()..id = id,
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
  AutoDisposeAsyncNotifierProviderElement<ProductDetailViewModel, Product?>
      createElement() {
    return _ProductDetailViewModelProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is ProductDetailViewModelProvider && other.id == id;
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
mixin ProductDetailViewModelRef
    on AutoDisposeAsyncNotifierProviderRef<Product?> {
  /// The parameter `id` of this provider.
  String get id;
}

class _ProductDetailViewModelProviderElement
    extends AutoDisposeAsyncNotifierProviderElement<ProductDetailViewModel,
        Product?> with ProductDetailViewModelRef {
  _ProductDetailViewModelProviderElement(super.provider);

  @override
  String get id => (origin as ProductDetailViewModelProvider).id;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
