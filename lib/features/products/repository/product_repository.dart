import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../main.dart';
import '../model/product.dart';
import '../model/product_order.dart';

part 'product_repository.g.dart';

@riverpod
ProductRepository productRepository(Ref ref) {
  return ProductRepository();
}

class ProductRepository {
  const ProductRepository();

  Future<List<Product>> getProducts({String? category}) async {
    var builder = supabase
        .from('products')
        .select()
        .eq('is_active', true);
    
    if (category != null && category != 'all') {
      builder = builder.eq('category', category);
    }
    
    final data = await builder.order('created_at', ascending: false);
    return (data as List).map((e) => Product.fromJson(e)).toList();
  }

  Future<Product?> getProduct(String id) async {
    try {
      final data = await supabase
          .from('products')
          .select()
          .eq('id', id)
          .single();
      return Product.fromJson(data);
    } catch (e) {
      return null;
    }
  }

  Future<ProductOrder> createOrder({
    required String userId,
    required String productId,
    required int quantity,
    required double totalPrice,
  }) async {
    final data = await supabase
        .from('product_orders')
        .insert({
          'user_id': userId,
          'product_id': productId,
          'quantity': quantity,
          'total_price': totalPrice,
          'status': 'pending',
        })
        .select()
        .single();
    return ProductOrder.fromJson(data);
  }

  Future<List<ProductOrder>> getMyOrders(String userId) async {
    final data = await supabase
        .from('product_orders')
        .select()
        .eq('user_id', userId)
        .order('created_at', ascending: false);
    return (data as List).map((e) => ProductOrder.fromJson(e)).toList();
  }

  Future<Product?> getProductByOrder(String productId) async {
    try {
      final data = await supabase
          .from('products')
          .select()
          .eq('id', productId)
          .single();
      return Product.fromJson(data);
    } catch (e) {
      return null;
    }
  }
}
