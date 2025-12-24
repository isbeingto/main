import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../model/listing.dart';
import '../repository/lodging_repository.dart';

part 'lodging_view_model.g.dart';

@riverpod
class LodgingViewModel extends _$LodgingViewModel {
  late LodgingRepository _repository;

  @override
  FutureOr<List<Listing>> build() async {
    _repository = ref.read(lodgingRepositoryProvider);
    return _repository.fetchLodgings();
  }

  Future<void> refresh() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() => _repository.fetchLodgings());
  }
}

@riverpod
class LodgingDetailViewModel extends _$LodgingDetailViewModel {
  late LodgingRepository _repository;

  @override
  FutureOr<Listing?> build(String id) async {
    _repository = ref.read(lodgingRepositoryProvider);
    return _repository.fetchLodgingDetail(id);
  }
}
