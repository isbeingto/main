// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'lodging_view_model.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$lodgingViewModelHash() => r'1bacc82557e81d5096722256723292777b9eda1a';

/// See also [LodgingViewModel].
@ProviderFor(LodgingViewModel)
final lodgingViewModelProvider =
    AutoDisposeAsyncNotifierProvider<LodgingViewModel, List<Listing>>.internal(
  LodgingViewModel.new,
  name: r'lodgingViewModelProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$lodgingViewModelHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$LodgingViewModel = AutoDisposeAsyncNotifier<List<Listing>>;
String _$lodgingDetailViewModelHash() =>
    r'4a957c546dfc66f3dc8082e058c4779e4c10b106';

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

abstract class _$LodgingDetailViewModel
    extends BuildlessAutoDisposeAsyncNotifier<Listing?> {
  late final String id;

  FutureOr<Listing?> build(
    String id,
  );
}

/// See also [LodgingDetailViewModel].
@ProviderFor(LodgingDetailViewModel)
const lodgingDetailViewModelProvider = LodgingDetailViewModelFamily();

/// See also [LodgingDetailViewModel].
class LodgingDetailViewModelFamily extends Family<AsyncValue<Listing?>> {
  /// See also [LodgingDetailViewModel].
  const LodgingDetailViewModelFamily();

  /// See also [LodgingDetailViewModel].
  LodgingDetailViewModelProvider call(
    String id,
  ) {
    return LodgingDetailViewModelProvider(
      id,
    );
  }

  @override
  LodgingDetailViewModelProvider getProviderOverride(
    covariant LodgingDetailViewModelProvider provider,
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
  String? get name => r'lodgingDetailViewModelProvider';
}

/// See also [LodgingDetailViewModel].
class LodgingDetailViewModelProvider
    extends AutoDisposeAsyncNotifierProviderImpl<LodgingDetailViewModel,
        Listing?> {
  /// See also [LodgingDetailViewModel].
  LodgingDetailViewModelProvider(
    String id,
  ) : this._internal(
          () => LodgingDetailViewModel()..id = id,
          from: lodgingDetailViewModelProvider,
          name: r'lodgingDetailViewModelProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$lodgingDetailViewModelHash,
          dependencies: LodgingDetailViewModelFamily._dependencies,
          allTransitiveDependencies:
              LodgingDetailViewModelFamily._allTransitiveDependencies,
          id: id,
        );

  LodgingDetailViewModelProvider._internal(
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
  FutureOr<Listing?> runNotifierBuild(
    covariant LodgingDetailViewModel notifier,
  ) {
    return notifier.build(
      id,
    );
  }

  @override
  Override overrideWith(LodgingDetailViewModel Function() create) {
    return ProviderOverride(
      origin: this,
      override: LodgingDetailViewModelProvider._internal(
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
  AutoDisposeAsyncNotifierProviderElement<LodgingDetailViewModel, Listing?>
      createElement() {
    return _LodgingDetailViewModelProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is LodgingDetailViewModelProvider && other.id == id;
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
mixin LodgingDetailViewModelRef
    on AutoDisposeAsyncNotifierProviderRef<Listing?> {
  /// The parameter `id` of this provider.
  String get id;
}

class _LodgingDetailViewModelProviderElement
    extends AutoDisposeAsyncNotifierProviderElement<LodgingDetailViewModel,
        Listing?> with LodgingDetailViewModelRef {
  _LodgingDetailViewModelProviderElement(super.provider);

  @override
  String get id => (origin as LodgingDetailViewModelProvider).id;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
