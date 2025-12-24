import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../model/listing.dart';
import '../repository/listings_repository.dart';

part 'listings_view_model.g.dart';

@riverpod
class ListingsViewModel extends _$ListingsViewModel {
  @override
  Future<List<Listing>> build() async {
    return _fetchListings();
  }

  Future<List<Listing>> _fetchListings() async {
    final repository = ref.read(listingsRepositoryProvider);
    return repository.fetchListings();
  }

  Future<void> refresh() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() => _fetchListings());
  }
}

@riverpod
Future<Listing?> listingDetail(Ref ref, String id) async {
  final repository = ref.read(listingsRepositoryProvider);
  return repository.fetchListingDetail(id);
}
