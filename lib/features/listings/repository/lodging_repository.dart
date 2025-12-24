import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../constants/constants.dart';
import '../../../main.dart';
import '../model/listing.dart';
import '../model/lodging_booking.dart';

part 'lodging_repository.g.dart';

@riverpod
LodgingRepository lodgingRepository(Ref ref) {
  return LodgingRepository();
}

class LodgingRepository {
  const LodgingRepository();

  /// Fetch all active lodgings
  Future<List<Listing>> fetchLodgings() async {
    try {
      final response = await supabase
          .from('listings')
          .select('*, listing_photos(*)')
          .eq('is_active', true)
          .order('created_at', ascending: false);

      debugPrint('${Constants.tag} [fetchLodgings] Response: $response');

      return (response as List)
          .map((json) => Listing.fromJson(json as Map<String, dynamic>))
          .toList();
    } catch (e) {
      debugPrint('${Constants.tag} [fetchLodgings] Error: $e');
      rethrow;
    }
  }

  /// Fetch a single lodging by ID
  Future<Listing?> fetchLodgingDetail(String id) async {
    try {
      final response = await supabase
          .from('listings')
          .select('*, listing_photos(*)')
          .eq('id', id)
          .eq('is_active', true)
          .maybeSingle();

      debugPrint('${Constants.tag} [fetchLodgingDetail] Response: $response');

      if (response == null) return null;
      return Listing.fromJson(response);
    } catch (e) {
      debugPrint('${Constants.tag} [fetchLodgingDetail] Error: $e');
      rethrow;
    }
  }

  /// Create a lodging booking
  Future<LodgingBooking> createBooking({
    required String userId,
    required String lodgingId,
    required DateTime startDate,
    required DateTime endDate,
    required int nights,
    required double totalPrice,
    int guests = 1,
    String? note,
  }) async {
    try {
      final data = {
        'user_id': userId,
        'lodging_id': lodgingId,
        'start_date': startDate.toIso8601String().split('T')[0],
        'end_date': endDate.toIso8601String().split('T')[0],
        'nights': nights,
        'total_price': totalPrice,
        'guests': guests,
        'status': 'pending',
        if (note != null && note.isNotEmpty) 'note': note,
      };

      debugPrint('${Constants.tag} [createBooking] Data: $data');

      final response = await supabase
          .from('lodging_bookings')
          .insert(data)
          .select()
          .single();

      debugPrint('${Constants.tag} [createBooking] Response: $response');

      return LodgingBooking.fromJson(response);
    } catch (e) {
      debugPrint('${Constants.tag} [createBooking] Error: $e');
      rethrow;
    }
  }

  /// Fetch user's bookings
  Future<List<LodgingBooking>> fetchMyBookings(String userId) async {
    try {
      final response = await supabase
          .from('lodging_bookings')
          .select()
          .eq('user_id', userId)
          .order('created_at', ascending: false);

      debugPrint('${Constants.tag} [fetchMyBookings] Response: $response');

      return (response as List)
          .map((json) => LodgingBooking.fromJson(json as Map<String, dynamic>))
          .toList();
    } catch (e) {
      debugPrint('${Constants.tag} [fetchMyBookings] Error: $e');
      rethrow;
    }
  }
}
