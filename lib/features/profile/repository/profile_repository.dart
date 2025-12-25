import 'dart:convert';

import 'package:flutter/foundation.dart';
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
  
  /// RevenueCat 是否已配置（main.dart 中可能被注释掉）
  /// 设置为 false 来完全跳过 RevenueCat 调用，避免崩溃
  static const bool _revenueCatConfigured = false;

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

    // 使用 maybeSingle() 替代 single()，避免没有记录时抛异常导致崩溃
    Profile? result;
    try {
      final data = await supabase
          .from(Constants.supabaseProfileTable)
          .select()
          .eq('id', userId)
          .maybeSingle();
      
      if (data != null) {
        result = Profile.fromJson(data);
      } else {
        // Profile 不存在，返回一个基础 Profile 而不是崩溃
        debugPrint('${Constants.tag} [ProfileRepository.get] Profile not found for user $userId, returning basic profile');
        final email = supabase.auth.currentUser?.email;
        return Profile(
          id: userId,
          email: email,
          name: email?.split('@').first,
        );
      }
    } catch (e) {
      debugPrint('${Constants.tag} [ProfileRepository.get] Error fetching profile: $e');
      // 发生错误时返回基础 Profile 而不是崩溃
      final email = supabase.auth.currentUser?.email;
      return Profile(
        id: userId,
        email: email,
        name: email?.split('@').first,
      );
    }

    DateTime? expiryDatePremium;
    bool? isLifetimePremium;

    // Get purchase information - 只有在 RevenueCat 已配置时才调用
    // 如果 _revenueCatConfigured 为 false，跳过 RevenueCat 调用避免 Fatal error
    if (_revenueCatConfigured) {
      try {
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
      } catch (e) {
        debugPrint('${Constants.tag} [ProfileRepository.get] RevenueCat error (ignored): $e');
        // RevenueCat 错误不应该导致崩溃，忽略继续
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
          .maybeSingle();
      
      if (data != null) {
        return Profile.fromJson(data);
      }
      // upsert 成功但没返回数据，返回基础 Profile
      return Profile(id: userId, email: email, name: name ?? email?.split('@').first);
    } catch (e) {
      debugPrint('${Constants.tag} [ProfileRepository.upsert] Error: $e');
      // If upsert fails, try to get existing profile
      try {
        final data = await supabase
            .from(Constants.supabaseProfileTable)
            .select()
            .eq('id', userId)
            .maybeSingle();
        if (data != null) {
          return Profile.fromJson(data);
        }
      } catch (_) {
        // 忽略
      }
      // 返回基础 Profile 而不是 null，避免下游崩溃
      return Profile(id: userId, email: email, name: name ?? email?.split('@').first);
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
