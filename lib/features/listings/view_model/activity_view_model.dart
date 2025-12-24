import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../model/listing.dart';
import '../model/activity_signup.dart';
import '../repository/activity_repository.dart';

// Provider for ActivityRepository
final activityRepositoryProvider = Provider<ActivityRepository>((ref) {
  return ActivityRepository(Supabase.instance.client);
});

// Provider for fetching activities
final activitiesProvider = FutureProvider<List<Listing>>((ref) async {
  final repository = ref.watch(activityRepositoryProvider);
  return await repository.fetchActivities();
});

// Provider for fetching activity detail by ID
final activityDetailProvider =
    FutureProvider.family<Listing, String>((ref, activityId) async {
  final repository = ref.watch(activityRepositoryProvider);
  return await repository.fetchActivityDetail(activityId);
});

// StateNotifier for activity signup state
class ActivitySignupViewModel extends StateNotifier<AsyncValue<void>> {
  final ActivityRepository _repository;

  ActivitySignupViewModel(this._repository) : super(const AsyncValue.data(null));

  Future<void> createSignup({
    required String userId,
    required String activityId,
    required int qty,
    required double totalPrice,
    String? note,
  }) async {
    state = const AsyncValue.loading();
    try {
      await _repository.createSignup(
        userId: userId,
        activityId: activityId,
        qty: qty,
        totalPrice: totalPrice,
        note: note,
      );
      state = const AsyncValue.data(null);
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
    }
  }
}

// Provider for ActivitySignupViewModel
final activitySignupViewModelProvider =
    StateNotifierProvider<ActivitySignupViewModel, AsyncValue<void>>((ref) {
  final repository = ref.watch(activityRepositoryProvider);
  return ActivitySignupViewModel(repository);
});

// Provider for fetching user's activity signups
final myActivitySignupsProvider =
    FutureProvider.family<List<ActivitySignup>, String>((ref, userId) async {
  final repository = ref.watch(activityRepositoryProvider);
  return await repository.fetchMySignups(userId);
});

// Provider for fetching activity by signup
final activityBySignupProvider =
    FutureProvider.family<Listing?, String>((ref, activityId) async {
  final repository = ref.watch(activityRepositoryProvider);
  return await repository.fetchActivityBySignup(activityId);
});
