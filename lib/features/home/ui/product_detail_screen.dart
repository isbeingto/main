import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../generated/locale_keys.g.dart';
import '../../../routing/routes.dart';
import '../../../theme/app_colors.dart';
import '../../products/ui/view_model/order_view_model.dart';
import '../../products/ui/view_model/product_view_model.dart';

class ProductDetailScreen extends ConsumerWidget {
  const ProductDetailScreen({super.key, required this.productId});

  final String productId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final productAsync = ref.watch(productDetailViewModelProvider(productId));

    // Listen to order state
    ref.listen(orderViewModelProvider, (previous, next) {
      next.when(
        data: (_) {
          if (previous?.isLoading == true) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(LocaleKeys.orderSuccess.tr())),
            );
          }
        },
        error: (error, stack) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Order failed: $error')),
          );
        },
        loading: () {},
      );
    });

    return Scaffold(
      appBar: AppBar(
        title: Text(LocaleKeys.productDetail.tr()),
      ),
      body: productAsync.when(
        data: (product) {
          if (product == null) {
            return const Center(child: Text('Product not found'));
          }
          return Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Image
                      Container(
                        height: 300,
                        width: double.infinity,
                        color: AppColors.mono20,
                        child: product.imageUrl != null
                            ? Image.network(
                                product.imageUrl!,
                                fit: BoxFit.cover,
                              )
                            : const Icon(Icons.image_not_supported, size: 64, color: AppColors.mono40),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              (product as dynamic).title,
                              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              '¥${((product as dynamic).price as num).toStringAsFixed(2)}',
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: AppColors.rambutan100,
                              ),
                            ),
                            const SizedBox(height: 16),
                            Text(
                              ((product as dynamic).description ?? '') as String,
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                            const SizedBox(height: 16),
                            // Stock info
                            Row(
                              children: [
                                Icon(Icons.inventory_2_outlined, size: 16, color: AppColors.mono60),
                                const SizedBox(width: 4),
                                Text(
                                  '${LocaleKeys.stock.tr()}: ${(product as dynamic).stock}',
                                  style: TextStyle(color: AppColors.mono60),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              // Bottom Bar
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.05),
                      blurRadius: 10,
                      offset: const Offset(0, -5),
                    ),
                  ],
                ),
                child: SafeArea(
                  child: SizedBox(
                    width: double.infinity,
                    height: 48,
                    child: ElevatedButton(
                      onPressed: () {
                        _handleOrder(context, ref, product);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.blueberry100,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(24),
                        ),
                      ),
                      child: Consumer(
                        builder: (context, ref, child) {
                          final orderState = ref.watch(orderViewModelProvider);
                          return orderState.isLoading
                              ? const SizedBox(
                                  width: 24,
                                  height: 24,
                                  child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2),
                                )
                              : Text(LocaleKeys.orderNow.tr());
                        },
                      ),
                    ),
                  ),
                ),
              ),
            ],
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(child: Text('Error: $error')),
      ),
    );
  }

  void _handleOrder(BuildContext context, WidgetRef ref, dynamic productData) {
    final user = Supabase.instance.client.auth.currentUser;
    if (user == null) {
      // Redirect to login
      context.push(Routes.login);
      return;
    }

    // Create order
    final price = ((productData as dynamic).price as num).toDouble();
    ref.read(orderViewModelProvider.notifier).createOrder(
          userId: user.id,
          productId: productId,
          quantity: 1, // Default to 1 for now
          totalPrice: price,
        );
  }
}
