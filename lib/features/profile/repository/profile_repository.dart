import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:purchases_flutter/purchases_flutter.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../constants/constants.dart';
import '../../../features/profile/model/profile.dart';
import '../../../main.dart';
import '../../../utils/utils.dart';

part 'profile_repository.g.dart';

@Riverpod(keepAlive: true)
ProfileRepository profileRepository(Ref ref) {
  return ProfileRepository();
}

class ProfileRepository {
  const ProfileRepository();

  bool get _useLocalProfileStorage => false;

  Future<Profile?> get() async {
    if (_useLocalProfileStorage) {
      // TODO: temporary get profile from local
      final prefs = await SharedPreferences.getInstance();
      final profileStr = prefs.getString(Constants.profileKey);
      if (profileStr == null) return null;

      final profile = Profile.fromJson(jsonDecode(profileStr));
      return profile;
    }

    final userId = supabase.auth.currentUser?.id;
    if (userId == null) return null;

    final data = await supabase
        .from(Constants.supabaseProfileTable)
        .select()
        .eq('id', userId)
        .single();
    final result = Profile.fromJson(data);

    DateTime? expiryDatePremium;
    bool? isLifetimePremium;

    // Get purchase information
    final logInResult = await Purchases.logIn(userId);
    final activeEntitlements = logInResult.customerInfo.entitlements.active;
    if (activeEntitlements.containsKey(Constants.premium)) {
      final premiumEntitlement = activeEntitlements[Constants.premium];
      final date = premiumEntitlement?.expirationDate;
      if (date != null) {
        expiryDatePremium = DateTime.parse(date);
      } else {
        isLifetimePremium = true;
      }
    }

    return result.copyWith(
      expiryDatePremium: expiryDatePremium,
      isLifetimePremium: isLifetimePremium,
    );
  }

  /// Upsert profile - creates if not exists, updates if exists
  Future<Profile?> upsert({
    required String userId,
    String? email,
    String? name,
  }) async {
    if (_useLocalProfileStorage) {
      final prefs = await SharedPreferences.getInstance();
      final existing = prefs.getString(Constants.profileKey);
      final profile = existing != null
          ? Profile.fromJson(jsonDecode(existing))
          : Profile(id: userId, email: email, name: name);
      prefs.setString(Constants.profileKey, jsonEncode(profile.toJson()));
      return profile;
    }

    try {
      final data = await supabase
          .from(Constants.supabaseProfileTable)
          .upsert({
            'id': userId,
            'email': email,
            'name': name ?? email?.split('@').first,
            'updated_at': DateTime.now().toIso8601String(),
          }, onConflict: 'id')
          .select()
          .single();
      return Profile.fromJson(data);
    } catch (e) {
      // If upsert fails, try to get existing profile
      try {
        final data = await supabase
            .from(Constants.supabaseProfileTable)
            .select()
            .eq('id', userId)
            .single();
        return Profile.fromJson(data);
      } catch (_) {
        return null;
      }
    }
  }

  Future<void> update(Profile profile) async {
    if (_useLocalProfileStorage) {
      // TODO: temporary save profile to local
      final prefs = await SharedPreferences.getInstance();
      prefs.setString(Constants.profileKey, jsonEncode(profile.toJson()));
      return;
    }

    final userId = profile.id;
    if (userId == null) return;
    try {
      await supabase
          .from(Constants.supabaseProfileTable)
          .update({
            if (profile.email != null) 'email': profile.email,
            if (profile.name != null) 'name': profile.name,
            if (profile.job != null) 'job': profile.job,
            if (profile.avatar != null) 'avatar': profile.avatar,
            if (profile.diamond != null) 'diamond': profile.diamond,
            if (profile.expiryDatePremium != null)
              'expiry_date_premium':
                  profile.expiryDatePremium?.toIso8601String(),
            if (profile.isLifetimePremium != null)
              'is_lifetime_premium': profile.isLifetimePremium,
            'updated_at': DateTime.now().toIso8601String(),
          })
          .eq('id', userId)
          .select();
    } catch (e) {
      rethrow;
    }
  }

  Future<bool> isShowPremium() async {
    final prefs = await SharedPreferences.getInstance();
    final day = prefs.getString(Constants.lastDayShowPremiumKey);
    if (day == null) return true;
    return Utils.today().difference(DateTime.parse(day)).inDays >= 3;
  }

  Future<void> setIsShowPremium() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(
        Constants.lastDayShowPremiumKey, Utils.today().toIso8601String());
  }
}
