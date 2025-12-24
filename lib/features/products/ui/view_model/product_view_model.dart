import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../model/product.dart';
import '../../repository/product_repository.dart';

part 'product_view_model.g.dart';

@riverpod
class ProductViewModel extends _$ProductViewModel {
  late ProductRepository _repository;

  @override
  FutureOr<List<Product>> build({String? category}) async {
    _repository = ref.read(productRepositoryProvider);
    return _repository.getProducts(category: category);
  }

  Future<void> refresh() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() => _repository.getProducts(category: category));
  }
}

@riverpod
class ProductDetailViewModel extends _$ProductDetailViewModel {
  late ProductRepository _repository;

  @override
  FutureOr<Product?> build(String id) async {
    _repository = ref.read(productRepositoryProvider);
    return _repository.getProduct(id);
  }
}
