import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../generated/locale_keys.g.dart';
import '../../../routing/routes.dart';
import '../../../theme/app_colors.dart';
import '../view_model/booking_view_model.dart';
import '../view_model/lodging_view_model.dart';

class LodgingDetailScreen extends ConsumerStatefulWidget {
  const LodgingDetailScreen({super.key, required this.lodgingId});

  final String lodgingId;

  @override
  ConsumerState<LodgingDetailScreen> createState() => _LodgingDetailScreenState();
}

class _LodgingDetailScreenState extends ConsumerState<LodgingDetailScreen> {
  DateTimeRange? _selectedDateRange;
  int _guests = 1;
  final _noteController = TextEditingController();

  @override
  void dispose() {
    _noteController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final lodgingAsync = ref.watch(lodgingDetailViewModelProvider(widget.lodgingId));

    // Listen to booking state
    ref.listen(lodgingBookingViewModelProvider, (previous, next) {
      next.when(
        data: (_) {
          if (previous?.isLoading == true) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(LocaleKeys.bookingSuccess.tr())),
            );
            // Navigate back or to bookings screen
            context.pop();
          }
        },
        error: (error, stack) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('${LocaleKeys.bookingError.tr()}: $error')),
          );
        },
        loading: () {},
      );
    });

    return Scaffold(
      appBar: AppBar(
        title: Text(LocaleKeys.lodgingDetail.tr()),
      ),
      body: lodgingAsync.when(
        data: (lodging) {
          if (lodging == null) {
            return Center(child: Text(LocaleKeys.errorLoadingDetail.tr()));
          }

          final photoUrl = (lodging as dynamic).photos.isNotEmpty ? (lodging as dynamic).photos.first.photoUrl : null;

          return Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Image
                      if (photoUrl != null)
                        CachedNetworkImage(
                          imageUrl: photoUrl,
                          height: 250,
                          width: double.infinity,
                          fit: BoxFit.cover,
                          placeholder: (context, url) => Container(
                            color: AppColors.mono20,
                            child: const Center(child: CircularProgressIndicator()),
                          ),
                          errorWidget: (context, url, error) => Container(
                            color: AppColors.mono20,
                            child: const Icon(Icons.home_work_outlined, size: 64),
                          ),
                        )
                      else
                        Container(
                          height: 250,
                          color: AppColors.mono20,
                          child: const Center(
                            child: Icon(Icons.home_work_outlined, size: 64),
                          ),
                        ),
                      Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Title and Price
                            Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    (lodging as dynamic).title,
                                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                                          fontWeight: FontWeight.bold,
                                        ),
                                  ),
                                ),
                                if ((lodging as dynamic).pricePerNight != null)
                                  Text(
                                    '¥${((lodging as dynamic).pricePerNight as num).toStringAsFixed(0)}',
                                    style: TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold,
                                      color: AppColors.rambutan100,
                                    ),
                                  ),
                              ],
                            ),
                            if (lodging.pricePerNight != null)
                              Text(
                                LocaleKeys.perNight.tr(),
                                style: TextStyle(color: AppColors.mono60),
                              ),
                            const SizedBox(height: 16),

                            // Location
                            if ((lodging as dynamic).location != null)
                              Row(
                                children: [
                                  const Icon(Icons.location_on_outlined, size: 16, color: AppColors.mono60),
                                  const SizedBox(width: 4),
                                  Text(
                                    (lodging as dynamic).location!,
                                    style: TextStyle(color: AppColors.mono60),
                                  ),
                                ],
                              ),
                            const SizedBox(height: 16),

                            // Info chips
                            Wrap(
                              spacing: 8,
                              runSpacing: 8,
                              children: [
                                _InfoChip(
                                  icon: Icons.people_outline,
                                  label: '${(lodging as dynamic).maxGuests} ${LocaleKeys.guests.tr()}',
                                ),
                                _InfoChip(
                                  icon: Icons.bed_outlined,
                                  label: '${(lodging as dynamic).bedrooms} ${LocaleKeys.bedrooms.tr()}',
                                ),
                                _InfoChip(
                                  icon: Icons.bathtub_outlined,
                                  label: '${(lodging as dynamic).bathrooms} ${LocaleKeys.bathrooms.tr()}',
                                ),
                              ],
                            ),
                            const SizedBox(height: 24),

                            // Description
                            if ((lodging as dynamic).description != null) ...[
                              Text(
                                LocaleKeys.description.tr(),
                                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                      fontWeight: FontWeight.bold,
                                    ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                (lodging as dynamic).description!,
                                style: Theme.of(context).textTheme.bodyMedium,
                              ),
                              const SizedBox(height: 24),
                            ],

                            // Amenities
                            if (((lodging as dynamic).amenities as List).isNotEmpty) ...[
                              Text(
                                LocaleKeys.amenities.tr(),
                                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                      fontWeight: FontWeight.bold,
                                    ),
                              ),
                              const SizedBox(height: 8),
                              Wrap(
                                spacing: 8,
                                runSpacing: 8,
                                children: ((lodging as dynamic).amenities as List).map<Widget>((amenity) {
                                  return Chip(
                                    label: Text(amenity.toString()),
                                    backgroundColor: AppColors.mono20,
                                  );
                                }).toList(),
                              ),
                              const SizedBox(height: 24),
                            ],

                            // Date Range Picker
                            Text(
                              LocaleKeys.selectDateRange.tr(),
                              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                            ),
                            const SizedBox(height: 8),
                            InkWell(
                              onTap: () => _selectDateRange(context),
                              child: Container(
                                padding: const EdgeInsets.all(16),
                                decoration: BoxDecoration(
                                  border: Border.all(color: AppColors.mono40),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Row(
                                  children: [
                                    const Icon(Icons.calendar_today_outlined),
                                    const SizedBox(width: 12),
                                    Expanded(
                                      child: Text(
                                        _selectedDateRange == null
                                            ? LocaleKeys.selectDate.tr()
                                            : '${DateFormat.MMMd().format(_selectedDateRange!.start)} - ${DateFormat.MMMd().format(_selectedDateRange!.end)}',
                                      ),
                                    ),
                                    if (_selectedDateRange != null)
                                      Text(
                                        '${_selectedDateRange!.duration.inDays} ${LocaleKeys.nights.tr()}',
                                        style: TextStyle(
                                          color: AppColors.blueberry100,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(height: 16),

                            // Guest Count
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  LocaleKeys.guestCount.tr(),
                                  style: Theme.of(context).textTheme.titleMedium,
                                ),
                                Row(
                                  children: [
                                    IconButton(
                                      onPressed: _guests > 1
                                          ? () => setState(() => _guests--)
                                          : null,
                                      icon: const Icon(Icons.remove_circle_outline),
                                    ),
                                    Text(
                                      '$_guests',
                                      style: Theme.of(context).textTheme.titleMedium,
                                    ),
                                    IconButton(
                                      onPressed: _guests < (lodging as dynamic).maxGuests
                                          ? () => setState(() => _guests++)
                                          : null,
                                      icon: const Icon(Icons.add_circle_outline),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            const SizedBox(height: 16),

                            // Note
                            TextField(
                              controller: _noteController,
                              decoration: InputDecoration(
                                labelText: LocaleKeys.note.tr(),
                                hintText: LocaleKeys.notePlaceholder.tr(),
                                border: const OutlineInputBorder(),
                              ),
                              maxLines: 3,
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
                      onPressed: () => _handleBooking(context, ((lodging as dynamic).pricePerNight ?? 0) as double),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.blueberry100,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(24),
                        ),
                      ),
                      child: Consumer(
                        builder: (context, ref, child) {
                          final bookingState = ref.watch(lodgingBookingViewModelProvider);
                          return bookingState.isLoading
                              ? const SizedBox(
                                  width: 24,
                                  height: 24,
                                  child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2),
                                )
                              : Text(LocaleKeys.bookLodging.tr());
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

  Future<void> _selectDateRange(BuildContext context) async {
    final now = DateTime.now();
    final result = await showDateRangePicker(
      context: context,
      firstDate: now,
      lastDate: now.add(const Duration(days: 365)),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: AppColors.blueberry100,
            ),
          ),
          child: child!,
        );
      },
    );

    if (result != null) {
      setState(() {
        _selectedDateRange = result;
      });
    }
  }

  void _handleBooking(BuildContext context, double pricePerNight) {
    final user = Supabase.instance.client.auth.currentUser;
    if (user == null) {
      context.push(Routes.login);
      return;
    }

    if (_selectedDateRange == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(LocaleKeys.dateRangeRequired.tr())),
      );
      return;
    }

    final nights = _selectedDateRange!.duration.inDays;
    final totalPrice = nights * pricePerNight;

    ref.read(lodgingBookingViewModelProvider.notifier).createBooking(
          userId: user.id,
          lodgingId: widget.lodgingId,
          startDate: _selectedDateRange!.start,
          endDate: _selectedDateRange!.end,
          nights: nights,
          totalPrice: totalPrice,
          guests: _guests,
          note: _noteController.text.isEmpty ? null : _noteController.text,
        );
  }
}

class _InfoChip extends StatelessWidget {
  const _InfoChip({required this.icon, required this.label});

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: AppColors.mono20,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 16, color: AppColors.mono80),
          const SizedBox(width: 4),
          Text(label, style: TextStyle(color: AppColors.mono80)),
        ],
      ),
    );
  }
}
