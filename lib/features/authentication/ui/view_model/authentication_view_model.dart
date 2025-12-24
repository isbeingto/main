import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../constants/constants.dart';
import '../../../../features/profile/ui/view_model/profile_view_model.dart';
import '../../../../generated/locale_keys.g.dart';
import '../../repository/authentication_repository.dart';
import '../../ui/state/authentication_state.dart';

part 'authentication_view_model.g.dart';

@riverpod
class AuthenticationViewModel extends _$AuthenticationViewModel {
  late AuthenticationRepository _repository;

  @override
  FutureOr<AuthenticationState> build() async {
    _repository = ref.read(authenticationRepositoryProvider);
    return const AuthenticationState();
  }

  /// 使用邮箱和密码登录
  Future<void> signInWithPassword({
    required String email,
    required String password,
  }) async {
    state = const AsyncValue.loading();
    final result = await AsyncValue.guard(
      () => _repository.signInWithPassword(
        email: email,
        password: password,
      ),
    );
    handleResult(result);
  }

  /// 使用邮箱和密码注册
  Future<void> signUpWithPassword({
    required String email,
    required String password,
  }) async {
    state = const AsyncValue.loading();
    final result = await AsyncValue.guard(
      () => _repository.signUpWithPassword(
        email: email,
        password: password,
      ),
    );
    handleResult(result);
  }

  Future<void> signOut() async {
    state = const AsyncValue.loading();
    final result = await AsyncValue.guard(_repository.signOut);

    if (result is AsyncError) {
      state = AsyncError(result.error.toString(), StackTrace.current);
      return;
    }

    state = const AsyncData(AuthenticationState());
  }

  void handleResult(AsyncValue result) async {
    debugPrint(
        '${Constants.tag} [AuthenticationViewModel.handleResult] result: $result');
    if (result is AsyncError) {
      state = AsyncError(result.error.toString(), StackTrace.current);
      return;
    }

    final AuthResponse? authResponse = result.value;
    debugPrint(
        '${Constants.tag} [AuthenticationViewModel.handleResult] authResponse: ${authResponse?.user?.toJson()}');
    if (authResponse == null) {
      state = AsyncError(LocaleKeys.unexpectedErrorOccurred.tr(), StackTrace.current);
      return;
    }

    final session = authResponse.session;
    final currentUser = Supabase.instance.client.auth.currentUser;
    debugPrint(
      '${Constants.tag} [AuthenticationViewModel.handleResult] session=${session != null}, currentUser=${currentUser?.id}',
    );

    // Important: treat "user without session" as NOT signed-in.
    // This commonly happens when email confirmation is required.
    if (session == null || currentUser == null) {
      state = AsyncError(
        '登录未完成：未获得会话（session）。\n如果你刚注册/自动创建了账号，请先完成邮箱验证后再登录。',
        StackTrace.current,
      );
      return;
    }

    // Check if account exists and upsert profile
    final isExistAccount = await _repository.isExistAccount();
    if (!isExistAccount) {
      _repository.setIsExistAccount(true);
    }
    await upsertProfile(session.user);
    _repository.setIsLogin(true);

    state = AsyncData(
      AuthenticationState(
        authResponse: authResponse,
        isRegisterSuccessfully: !isExistAccount,
        isSignInSuccessfully: true,
      ),
    );
  }

  /// Upsert profile after successful authentication
  Future<void> upsertProfile(User user) async {
    String? name;
    String? avatar;
    final metaData = user.userMetadata;
    if (metaData != null) {
      name = metaData['full_name'];
      avatar = metaData['avatar_url'];
    }
    
    // Use upsert to create or update profile
    await ref.read(profileViewModelProvider.notifier).upsertProfile(
      userId: user.id,
      email: user.email,
      name: name,
      avatar: avatar,
    );
  }

  @Deprecated('Use upsertProfile instead')
  Future<void> updateProfile(User user) async {
    String? name;
    String? avatar;
    final metaData = user.userMetadata;
    if (metaData != null) {
      name = metaData['full_name'];
      avatar = metaData['avatar_url'];
    }
    ref.read(profileViewModelProvider.notifier).updateProfile(
      email: user.email,
      name: name,
      avatar: avatar,
    );
  }
}
