import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../constants/constants.dart';
import '../../../main.dart';
import '../model/booking_request.dart';
import '../model/listing.dart';

part 'listings_repository.g.dart';

@riverpod
ListingsRepository listingsRepository(Ref ref) {
  return ListingsRepository();
}

class ListingsRepository {
  const ListingsRepository();

  /// Fetch all active listings with their photos
  Future<List<Listing>> fetchListings() async {
    try {
      final response = await supabase
          .from('listings')
          .select('*, listing_photos(*)')
          .eq('is_active', true)
          .order('created_at', ascending: false);

      debugPrint('${Constants.tag} [fetchListings] Response: $response');

      return (response as List)
          .map((json) => Listing.fromJson(json as Map<String, dynamic>))
          .toList();
    } catch (e) {
      debugPrint('${Constants.tag} [fetchListings] Error: $e');
      rethrow;
    }
  }

  /// Fetch a single listing by ID with its photos
  Future<Listing?> fetchListingDetail(String id) async {
    try {
      final response = await supabase
          .from('listings')
          .select('*, listing_photos(*)')
          .eq('id', id)
          .eq('is_active', true)
          .maybeSingle();

      debugPrint('${Constants.tag} [fetchListingDetail] Response: $response');

      if (response == null) return null;
      return Listing.fromJson(response);
    } catch (e) {
      debugPrint('${Constants.tag} [fetchListingDetail] Error: $e');
      rethrow;
    }
  }

  /// Create a booking request
  Future<BookingRequest> createBookingRequest({
    required String listingId,
    DateTime? startDate,
    DateTime? endDate,
    int guests = 1,
    String? note,
  }) async {
    try {
      final userId = supabase.auth.currentUser?.id;
      if (userId == null) {
        throw Exception('User not authenticated');
      }

      final data = {
        'listing_id': listingId,
        'user_id': userId,
        'guests': guests,
        if (startDate != null) 'start_date': startDate.toIso8601String().split('T')[0],
        if (endDate != null) 'end_date': endDate.toIso8601String().split('T')[0],
        if (note != null && note.isNotEmpty) 'note': note,
      };

      debugPrint('${Constants.tag} [createBookingRequest] Data: $data');

      final response = await supabase
          .from('booking_requests')
          .insert(data)
          .select()
          .single();

      debugPrint('${Constants.tag} [createBookingRequest] Response: $response');

      return BookingRequest.fromJson(response);
    } catch (e) {
      debugPrint('${Constants.tag} [createBookingRequest] Error: $e');
      rethrow;
    }
  }

  /// Check if user is authenticated
  bool get isAuthenticated => supabase.auth.currentUser != null;
}
