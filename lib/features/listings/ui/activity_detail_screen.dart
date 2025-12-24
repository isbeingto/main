import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../../generated/locale_keys.g.dart';
import '../../../routing/routes.dart';
import '../../../theme/app_colors.dart';
import '../view_model/activity_view_model.dart';

class ActivityDetailScreen extends ConsumerStatefulWidget {
  final String activityId;

  const ActivityDetailScreen({
    super.key,
    required this.activityId,
  });

  @override
  ConsumerState<ActivityDetailScreen> createState() =>
      _ActivityDetailScreenState();
}

class _ActivityDetailScreenState extends ConsumerState<ActivityDetailScreen> {
  int _quantity = 1;
  final TextEditingController _noteController = TextEditingController();

  @override
  void dispose() {
    _noteController.dispose();
    super.dispose();
  }

  Future<void> _handleSignup() async {
    final user = Supabase.instance.client.auth.currentUser;

    if (user == null) {
      if (!mounted) return;
      final shouldNavigate = await showDialog<bool>(
        context: context,
        builder: (ctx) => AlertDialog(
          title: Text(LocaleKeys.loginRequired.tr()),
          content: Text(LocaleKeys.loginRequiredMessage.tr()),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(ctx).pop(false),
              child: Text(LocaleKeys.cancel.tr()),
            ),
            ElevatedButton(
              onPressed: () => Navigator.of(ctx).pop(true),
              child: Text(LocaleKeys.goToLogin.tr()),
            ),
          ],
        ),
      );

      if (shouldNavigate == true && mounted) {
        context.go(Routes.login);
      }
      return;
    }

    final activityAsync = ref.read(activityDetailProvider(widget.activityId));
    final activity = activityAsync.valueOrNull;

    if (activity == null) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(LocaleKeys.errorLoadingDetail.tr())),
      );
      return;
    }

    final totalPrice = (activity as dynamic).price * _quantity;

    await ref.read(activitySignupViewModelProvider.notifier).createSignup(
          userId: user.id,
          activityId: widget.activityId,
          qty: _quantity,
          totalPrice: totalPrice,
          note: _noteController.text.trim().isEmpty
              ? null
              : _noteController.text.trim(),
        );

    final signupState = ref.read(activitySignupViewModelProvider);

    if (!mounted) return;

    signupState.when(
      data: (_) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(LocaleKeys.signupSuccess.tr())),
        );
        context.pop();
      },
      loading: () {},
      error: (error, _) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(LocaleKeys.signupError.tr())),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final activityAsync = ref.watch(activityDetailProvider(widget.activityId));
    final signupState = ref.watch(activitySignupViewModelProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(LocaleKeys.activityDetail.tr()),
      ),
      body: activityAsync.when(
        data: (activity) {
          final price = (activity as dynamic).price ?? 0.0;
          final totalPrice = price * _quantity;

          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Activity Image
                if ((activity as dynamic).imageUrl != null)
                  Image.network(
                    (activity as dynamic).imageUrl!,
                    width: double.infinity,
                    height: 250,
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) => Container(
                      width: double.infinity,
                      height: 250,
                      color: AppColors.mono20,
                      child: const Icon(Icons.image, size: 80),
                    ),
                  ),

                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Title
                      Text(
                        (activity as dynamic).title ?? '',
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                      const SizedBox(height: 8),

                      // Time
                      if ((activity as dynamic).metadata?['time'] != null)
                        _buildInfoRow(
                          context,
                          icon: Icons.access_time,
                          label: LocaleKeys.activityTime.tr(),
                          value: (activity as dynamic).metadata!['time'],
                        ),

                      // Location
                      if ((activity as dynamic).location != null)
                        _buildInfoRow(
                          context,
                          icon: Icons.location_on,
                          label: LocaleKeys.activityLocation.tr(),
                          value: (activity as dynamic).location!,
                        ),

                      const SizedBox(height: 16),

                      // Description
                      Text(
                        LocaleKeys.activityIntro.tr(),
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        (activity as dynamic).description ?? '',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),

                      const SizedBox(height: 24),
                      const Divider(),
                      const SizedBox(height: 16),

                      // Fee
                      Row(
                        children: [
                          Text(
                            LocaleKeys.fee.tr(),
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                          const Spacer(),
                          Text(
                            '¥${price.toStringAsFixed(0)}',
                            style: Theme.of(context)
                                .textTheme
                                .headlineSmall
                                ?.copyWith(
                                  color: AppColors.blueberry100,
                                  fontWeight: FontWeight.bold,
                                ),
                          ),
                          Text(
                            LocaleKeys.perPerson.tr(),
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                        ],
                      ),

                      const SizedBox(height: 16),

                      // Quantity selector
                      Row(
                        children: [
                          Text(
                            LocaleKeys.quantity.tr(),
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                          const Spacer(),
                          IconButton(
                            onPressed: _quantity > 1
                                ? () => setState(() => _quantity--)
                                : null,
                            icon: const Icon(Icons.remove_circle_outline),
                          ),
                          Text(
                            '$_quantity',
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                          IconButton(
                            onPressed: () => setState(() => _quantity++),
                            icon: const Icon(Icons.add_circle_outline),
                          ),
                        ],
                      ),

                      const SizedBox(height: 16),

                      // Note input
                      TextField(
                        controller: _noteController,
                        decoration: InputDecoration(
                          labelText: LocaleKeys.addNote.tr(),
                          border: const OutlineInputBorder(),
                        ),
                        maxLines: 3,
                      ),

                      const SizedBox(height: 24),

                      // Total price
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: AppColors.mono20,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          children: [
                            Text(
                              LocaleKeys.totalPrice.tr(),
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                            const Spacer(),
                            Text(
                              '¥${totalPrice.toStringAsFixed(2)}',
                              style: Theme.of(context)
                                  .textTheme
                                  .headlineMedium
                                  ?.copyWith(
                                    color: AppColors.blueberry100,
                                    fontWeight: FontWeight.bold,
                                  ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 24),

                      // Sign up button
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: signupState.isLoading
                              ? null
                              : _handleSignup,
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 16),
                          ),
                          child: signupState.isLoading
                              ? const SizedBox(
                                  height: 20,
                                  width: 20,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                  ),
                                )
                              : Text(LocaleKeys.signupActivity.tr()),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, _) => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(LocaleKeys.errorLoadingDetail.tr()),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () => ref.refresh(
                    activityDetailProvider(widget.activityId)),
                child: Text(LocaleKeys.retry.tr()),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoRow(
    BuildContext context, {
    required IconData icon,
    required String label,
    required String value,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        children: [
          Icon(icon, size: 20, color: AppColors.mono60),
          const SizedBox(width: 8),
          Text(
            label,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: AppColors.mono60,
                ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              value,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ),
        ],
      ),
    );
  }
}
