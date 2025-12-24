import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../model/product_order.dart';
import '../../model/product.dart';
import '../../repository/product_repository.dart';

part 'order_view_model.g.dart';

@riverpod
class OrderViewModel extends _$OrderViewModel {
  @override
  FutureOr<void> build() {
    // initial state is void (idle)
  }

  Future<void> createOrder({
    required String userId,
    required String productId,
    required int quantity,
    required double totalPrice,
  }) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      await ref.read(productRepositoryProvider).createOrder(
        userId: userId,
        productId: productId,
        quantity: quantity,
        totalPrice: totalPrice,
      );
    });
  }
}

@riverpod
Future<List<ProductOrder>> myOrders(Ref ref, String userId) async {
  return ref.read(productRepositoryProvider).getMyOrders(userId);
}

@riverpod
Future<Product?> productByOrder(Ref ref, String productId) async {
  return ref.read(productRepositoryProvider).getProductByOrder(productId);
}
