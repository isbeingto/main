import 'package:supabase_flutter/supabase_flutter.dart';
import '../model/listing.dart';
import '../model/activity_signup.dart';

class ActivityRepository {
  final SupabaseClient _supabase;

  ActivityRepository(this._supabase);

  /// Fetch all activities (listings)
  Future<List<Listing>> fetchActivities() async {
    final response = await _supabase
        .from('listings')
        .select()
        .eq('is_active', true)
        .order('created_at', ascending: false);

    return (response as List)
        .map((json) => Listing.fromJson(json as Map<String, dynamic>))
        .toList();
  }

  /// Fetch activity detail by ID
  Future<Listing> fetchActivityDetail(String activityId) async {
    final response = await _supabase
        .from('listings')
        .select()
        .eq('id', activityId)
        .eq('is_active', true)
        .single();

    return Listing.fromJson(response);
  }

  /// Create a new activity signup
  Future<ActivitySignup> createSignup({
    required String userId,
    required String activityId,
    required int qty,
    required double totalPrice,
    String? note,
  }) async {
    final response = await _supabase.from('activity_signups').insert({
      'user_id': userId,
      'activity_id': activityId,
      'qty': qty,
      'total_price': totalPrice,
      'note': note,
      'status': 'confirmed',
    }).select().single();

    return ActivitySignup.fromJson(response);
  }

  /// Fetch user's activity signups
  Future<List<ActivitySignup>> fetchMySignups(String userId) async {
    final response = await _supabase
        .from('activity_signups')
        .select()
        .eq('user_id', userId)
        .order('created_at', ascending: false);

    return (response as List)
        .map((json) => ActivitySignup.fromJson(json as Map<String, dynamic>))
        .toList();
  }

  /// Fetch activity listing by activity signup
  Future<Listing?> fetchActivityBySignup(String activityId) async {
    try {
      final response = await _supabase
          .from('listings')
          .select()
          .eq('id', activityId)
          .single();

      return Listing.fromJson(response);
    } catch (e) {
      return null;
    }
  }
}
