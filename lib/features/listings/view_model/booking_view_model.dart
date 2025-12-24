import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../model/booking_request.dart';
import '../model/lodging_booking.dart';
import '../repository/listings_repository.dart';
import '../repository/lodging_repository.dart';

part 'booking_view_model.g.dart';

@riverpod
class BookingViewModel extends _$BookingViewModel {
  @override
  AsyncValue<BookingRequest?> build() {
    return const AsyncData(null);
  }

  Future<bool> createBookingRequest({
    required String listingId,
    DateTime? startDate,
    DateTime? endDate,
    int guests = 1,
    String? note,
  }) async {
    state = const AsyncLoading();

    try {
      final repository = ref.read(listingsRepositoryProvider);
      final result = await repository.createBookingRequest(
        listingId: listingId,
        startDate: startDate,
        endDate: endDate,
        guests: guests,
        note: note,
      );
      state = AsyncData(result);
      return true;
    } catch (e, st) {
      state = AsyncError(e, st);
      return false;
    }
  }

  bool get isAuthenticated {
    final repository = ref.read(listingsRepositoryProvider);
    return repository.isAuthenticated;
  }
}

@riverpod
class LodgingBookingViewModel extends _$LodgingBookingViewModel {
  @override
  FutureOr<void> build() {
    // initial state is void (idle)
  }

  Future<void> createBooking({
    required String userId,
    required String lodgingId,
    required DateTime startDate,
    required DateTime endDate,
    required int nights,
    required double totalPrice,
    int guests = 1,
    String? note,
  }) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      await ref.read(lodgingRepositoryProvider).createBooking(
        userId: userId,
        lodgingId: lodgingId,
        startDate: startDate,
        endDate: endDate,
        nights: nights,
        totalPrice: totalPrice,
        guests: guests,
        note: note,
      );
    });
  }
}

@riverpod
class MyBookingsViewModel extends _$MyBookingsViewModel {
  late LodgingRepository _repository;

  @override
  FutureOr<List<LodgingBooking>> build(String userId) async {
    _repository = ref.read(lodgingRepositoryProvider);
    return _repository.fetchMyBookings(userId);
  }

  Future<void> refresh() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() => _repository.fetchMyBookings(userId));
  }
}
