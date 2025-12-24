import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'guest_profile_screen.dart';
import 'profile_screen.dart';

/// 认证状态Provider - 监听Supabase认证状态变化
final authStateProvider = StreamProvider<AuthState>((ref) {
  return Supabase.instance.client.auth.onAuthStateChange;
});

/// 当前用户Provider - 使用autoDispose确保状态更新
final currentUserProvider = Provider.autoDispose<User?>((ref) {
  // 监听auth状态变化
  ref.watch(authStateProvider);
  // 直接返回当前用户
  return Supabase.instance.client.auth.currentUser;
});

/// Wrapper that shows either ProfileScreen or GuestProfileScreen
/// based on authentication state
class ProfileWrapper extends ConsumerWidget {
  const ProfileWrapper({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // 监听auth状态变化以触发重建
    final authState = ref.watch(authStateProvider);
    final session = Supabase.instance.client.auth.currentSession;
    final user = session?.user;
    
    debugPrint(
      'ProfileWrapper: authState=${authState.valueOrNull?.event}, session=${session != null}, user=${user?.email}',
    );
    
    if (session != null) {
      return const ProfileScreen();
    } else {
      return const GuestProfileScreen();
    }
  }
}
