import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../../generated/locale_keys.g.dart';
import '../../../theme/app_colors.dart';
import '../view_model/activity_view_model.dart';
import '../model/activity_signup.dart';

class MyActivitySignupsScreen extends ConsumerWidget {
  const MyActivitySignupsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = Supabase.instance.client.auth.currentUser;

    if (user == null) {
      return Scaffold(
        appBar: AppBar(
          title: Text(LocaleKeys.myActivitySignups.tr()),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.login, size: 64, color: Colors.grey),
              const SizedBox(height: 16),
              Text(
                LocaleKeys.loginRequiredForProfile.tr(),
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ],
          ),
        ),
      );
    }

    final signupsAsync = ref.watch(myActivitySignupsProvider(user.id));

    return Scaffold(
      appBar: AppBar(
        title: Text(LocaleKeys.myActivitySignups.tr()),
      ),
      body: signupsAsync.when(
        data: (signups) {
          if (signups.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.event_busy, size: 64, color: Colors.grey),
                  const SizedBox(height: 16),
                  Text(
                    LocaleKeys.noData.tr(),
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ],
              ),
            );
          }

          return RefreshIndicator(
            onRefresh: () async {
              ref.invalidate(myActivitySignupsProvider(user.id));
            },
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: signups.length,
              itemBuilder: (context, index) {
                final signup = signups[index];
                return _SignupCard(signup: signup);
              },
            ),
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, _) => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(LocaleKeys.unexpectedErrorOccurred.tr()),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  ref.invalidate(myActivitySignupsProvider(user.id));
                },
                child: Text(LocaleKeys.retry.tr()),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SignupCard extends ConsumerWidget {
  final ActivitySignup signup;

  const _SignupCard({required this.signup});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final activityAsync = ref.watch(activityBySignupProvider(signup.activityId));

    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Activity title
            activityAsync.when(
              data: (activity) {
                if (activity == null) {
                  return Text(
                    LocaleKeys.noData.tr(),
                    style: Theme.of(context).textTheme.titleMedium,
                  );
                }
                return Row(
                  children: [
                    if ((activity as dynamic).imageUrl != null)
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.network(
                          (activity as dynamic).imageUrl!,
                          width: 60,
                          height: 60,
                          fit: BoxFit.cover,
                          errorBuilder: (_, __, ___) => Container(
                            width: 60,
                            height: 60,
                            color: AppColors.mono20,
                            child: const Icon(Icons.image),
                          ),
                        ),
                      ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            (activity as dynamic).title ?? '',
                            style: Theme.of(context).textTheme.titleMedium,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          if ((activity as dynamic).location != null)
                            Text(
                              (activity as dynamic).location!,
                              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                    color: AppColors.mono60,
                                  ),
                            ),
                        ],
                      ),
                    ),
                  ],
                );
              },
              loading: () => const SizedBox(
                height: 20,
                width: 20,
                child: CircularProgressIndicator(strokeWidth: 2),
              ),
              error: (_, __) => Text(LocaleKeys.errorLoadingDetail.tr()),
            ),

            const SizedBox(height: 12),
            const Divider(),
            const SizedBox(height: 8),

            // Quantity
            _buildInfoRow(
              context,
              label: LocaleKeys.quantity.tr(),
              value: '${signup.qty}',
            ),

            // Total price
            _buildInfoRow(
              context,
              label: LocaleKeys.totalPrice.tr(),
              value: '¥${signup.totalPrice.toStringAsFixed(2)}',
            ),

            // Status
            Row(
              children: [
                Text(
                  LocaleKeys.signupStatus.tr(),
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                const SizedBox(width: 8),
                _buildStatusBadge(context, signup.status),
              ],
            ),

            // Note
            if (signup.note != null && signup.note!.isNotEmpty) ...[
              const SizedBox(height: 8),
              Text(
                '${LocaleKeys.note.tr()}: ${signup.note}',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: AppColors.mono60,
                    ),
              ),
            ],

            // Created date
            const SizedBox(height: 8),
            Text(
              DateFormat('yyyy-MM-dd HH:mm').format(signup.createdAt),
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: AppColors.mono60,
                  ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(BuildContext context,
      {required String label, required String value}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Row(
        children: [
          Text(
            label,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          const SizedBox(width: 8),
          Text(
            value,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatusBadge(BuildContext context, String status) {
    Color badgeColor;
    String statusText;

    switch (status) {
      case 'pending':
        badgeColor = Colors.orange;
        statusText = LocaleKeys.statusPending.tr();
        break;
      case 'confirmed':
        badgeColor = Colors.green;
        statusText = LocaleKeys.statusConfirmed.tr();
        break;
      case 'cancelled':
        badgeColor = Colors.red;
        statusText = LocaleKeys.statusCancelled.tr();
        break;
      default:
        badgeColor = Colors.grey;
        statusText = status;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: badgeColor.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(4),
        border: Border.all(color: badgeColor),
      ),
      child: Text(
        statusText,
        style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: badgeColor,
              fontWeight: FontWeight.w600,
            ),
      ),
    );
  }
}
