import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../generated/locale_keys.g.dart';
import '../../../theme/app_colors.dart';
import '../model/lodging_booking.dart';
import '../view_model/booking_view_model.dart';

class MyBookingsScreen extends ConsumerWidget {
  const MyBookingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = Supabase.instance.client.auth.currentUser;

    if (user == null) {
      return Scaffold(
        appBar: AppBar(
          title: Text(LocaleKeys.myBookings.tr()),
        ),
        body: Center(
          child: Text(LocaleKeys.loginRequired.tr()),
        ),
      );
    }

    final bookingsAsync = ref.watch(myBookingsViewModelProvider(user.id));

    return Scaffold(
      appBar: AppBar(
        title: Text(LocaleKeys.myBookings.tr()),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              ref.read(myBookingsViewModelProvider(user.id).notifier).refresh();
            },
          ),
        ],
      ),
      body: bookingsAsync.when(
        data: (bookings) {
          if (bookings.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.book_outlined, size: 64, color: AppColors.mono40),
                  const SizedBox(height: 16),
                  Text(
                    LocaleKeys.noData.tr(),
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          color: AppColors.mono60,
                        ),
                  ),
                ],
              ),
            );
          }

          return RefreshIndicator(
            onRefresh: () => ref.read(myBookingsViewModelProvider(user.id).notifier).refresh(),
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: bookings.length,
              itemBuilder: (context, index) {
                return _BookingCard(booking: bookings[index]);
              },
            ),
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.error_outline, size: 64, color: AppColors.rambutan100),
              const SizedBox(height: 16),
              Text('Error: $error'),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () => ref.read(myBookingsViewModelProvider(user.id).notifier).refresh(),
                child: Text(LocaleKeys.retry.tr()),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _BookingCard extends StatelessWidget {
  const _BookingCard({required this.booking});

  final LodgingBooking booking;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Status Badge
            Row(
              children: [
                _StatusBadge(status: booking.status),
                const Spacer(),
                Text(
                  DateFormat.yMMMd().format(booking.createdAt ?? DateTime.now()),
                  style: TextStyle(
                    color: AppColors.mono60,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),

            // Date Range
            Row(
              children: [
                const Icon(Icons.calendar_today_outlined, size: 16, color: AppColors.mono60),
                const SizedBox(width: 8),
                Text(
                  '${DateFormat.MMMd().format(booking.startDate)} - ${DateFormat.MMMd().format(booking.endDate)}',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ],
            ),
            const SizedBox(height: 8),

            // Nights and Guests
            Row(
              children: [
                _InfoItem(
                  icon: Icons.nightlight_outlined,
                  text: '${booking.nights} ${LocaleKeys.nights.tr()}',
                ),
                const SizedBox(width: 16),
                _InfoItem(
                  icon: Icons.people_outline,
                  text: '${booking.guests} ${LocaleKeys.guests.tr()}',
                ),
              ],
            ),
            const SizedBox(height: 12),

            // Total Price
            Row(
              children: [
                Text(
                  LocaleKeys.totalPrice.tr(),
                  style: TextStyle(
                    color: AppColors.mono60,
                    fontSize: 14,
                  ),
                ),
                const Spacer(),
                Text(
                  '¥${booking.totalPrice.toStringAsFixed(2)}',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: AppColors.rambutan100,
                  ),
                ),
              ],
            ),

            // Note
            if (booking.note != null && booking.note!.isNotEmpty) ...[
              const SizedBox(height: 12),
              const Divider(),
              const SizedBox(height: 8),
              Text(
                LocaleKeys.note.tr(),
                style: TextStyle(
                  color: AppColors.mono60,
                  fontSize: 12,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                booking.note!,
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class _StatusBadge extends StatelessWidget {
  const _StatusBadge({required this.status});

  final String status;

  @override
  Widget build(BuildContext context) {
    Color color;
    String text;

    switch (status) {
      case 'confirmed':
        color = Colors.green;
        text = LocaleKeys.statusConfirmed.tr();
        break;
      case 'cancelled':
        color = Colors.red;
        text = LocaleKeys.statusCancelled.tr();
        break;
      case 'completed':
        color = Colors.blue;
        text = LocaleKeys.statusCompleted.tr();
        break;
      default:
        color = Colors.orange;
        text = LocaleKeys.statusPending.tr();
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: color,
          fontSize: 12,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}

class _InfoItem extends StatelessWidget {
  const _InfoItem({required this.icon, required this.text});

  final IconData icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 16, color: AppColors.mono60),
        const SizedBox(width: 4),
        Text(
          text,
          style: TextStyle(color: AppColors.mono60, fontSize: 14),
        ),
      ],
    );
  }
}
