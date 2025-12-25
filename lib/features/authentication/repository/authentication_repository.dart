import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:purchases_flutter/purchases_flutter.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '/constants/constants.dart';
import '/environment/env.dart';
import '/generated/locale_keys.g.dart';
import '/main.dart';

part 'authentication_repository.g.dart';

@Riverpod(keepAlive: true)
AuthenticationRepository authenticationRepository(Ref ref) {
  return AuthenticationRepository();
}

class AuthenticationRepository {
  const AuthenticationRepository();

  bool get _useFakeAuth => false;

  // 测试账号配置
  static const String testEmail = 'test@farm.app';
  static const String testPassword = '123456';

  /// 使用邮箱和密码登录
  Future<AuthResponse> signInWithPassword({
    required String email,
    required String password,
  }) async {
    if (_useFakeAuth) {
      // TODO: fake data
      return AuthResponse(
        user: User(
          id: '',
          appMetadata: {},
          userMetadata: {},
          aud: '',
          createdAt: '',
          email: email,
        ),
      );
    }

    // 测试账号：使用固定密码登录
    if (email.toLowerCase() == testEmail && password == testPassword) {
      debugPrint('🧪 Test account login with password: $testEmail');
      try {
        // 只尝试登录：不要在登录流程里自动创建账号。
        // 若项目开启邮箱验证，signUp 会触发发送确认邮件；
        // 邮件服务未配置时会直接 500（你截图里的错误）。
        return await supabase.auth.signInWithPassword(
          email: email,
          password: password,
        );
      } on AuthException catch (error) {
        throw Exception(
          '测试账号登录失败：${error.message}\n'
          '请在 Supabase 控制台预先创建并确认该账号，或在开发环境关闭邮箱确认。',
        );
      } catch (e) {
        throw Exception(
          '测试账号登录失败：$e\n'
          '请在 Supabase 控制台预先创建并确认该账号，或在开发环境关闭邮箱确认。',
        );
      }
    }

    try {
      final result = await supabase.auth.signInWithPassword(
        email: email,
        password: password,
      );
      return result;
    } on AuthException catch (error) {
      throw Exception(error.message);
    } catch (error) {
      throw Exception(LocaleKeys.unexpectedErrorOccurred.tr());
    }
  }

  /// 使用邮箱和密码注册
  Future<AuthResponse> signUpWithPassword({
    required String email,
    required String password,
  }) async {
    if (_useFakeAuth) {
      // TODO: fake data
      return AuthResponse(
        user: User(
          id: '',
          appMetadata: {},
          userMetadata: {},
          aud: '',
          createdAt: '',
          email: email,
        ),
      );
    }

    // 测试账号：使用固定密码注册
    if (email.toLowerCase() == testEmail && password == testPassword) {
      debugPrint('🧪 Test account signup with password: $testEmail');
      try {
        // 尝试使用密码注册
        final result = await supabase.auth.signUp(
          email: email,
          password: password,
        );
        return result;
      } catch (e) {
        // 如果账号已存在，使用密码登录
        debugPrint('🧪 Test account already exists, logging in...');
        final result = await supabase.auth.signInWithPassword(
          email: email,
          password: password,
        );
        return result;
      }
    }

    try {
      final result = await supabase.auth.signUp(
        email: email,
        password: password,
      );
      return result;
    } on AuthException catch (error) {
      final msg = error.message;

      // AuthRetryableFetchException is a subtype of AuthException.
      if (error is AuthRetryableFetchException &&
          msg.contains('Error sending confirmation email')) {
        throw Exception(
          '注册失败：Supabase 发送确认邮件失败。\n'
          '请检查 Supabase 项目的 SMTP/Email Provider 配置，或在开发环境关闭邮箱确认。',
        );
      }

      throw Exception(msg);
    } catch (error) {
      throw Exception(LocaleKeys.unexpectedErrorOccurred.tr());
    }
  }

  /// RevenueCat 是否已配置（main.dart 中可能被注释掉）
  static const bool _revenueCatConfigured = false;

  Future<void> signOut() async {
    if (_useFakeAuth) {
      // TODO: fake data
      return;
    }

    try {
      await supabase.auth.signOut();
      // 只有在 RevenueCat 已配置时才调用 logOut
      if (_revenueCatConfigured) {
        try {
          Purchases.logOut();
        } catch (e) {
          debugPrint('${Constants.tag} [AuthenticationRepository.signOut] RevenueCat logOut error (ignored): $e');
        }
      }
    } on AuthException catch (error) {
      throw Exception(error.message);
    } catch (error) {
      throw Exception(LocaleKeys.unexpectedErrorOccurred.tr());
    }
  }

  Future<bool> isLogin() async {
    if (_useFakeAuth) {
      // TODO: fake data, remove this when integrating real auth
      final prefs = await SharedPreferences.getInstance();
      return prefs.getBool(Constants.isLoginKey) ?? false;
    }

    // Prefer session over user to avoid treating "user-only" responses
    // (e.g. signUp with email confirmation required) as logged-in.
    return supabase.auth.currentSession != null;
  }

  // TODO: remove this when integrating real auth
  Future<void> setIsLogin(bool value) async {
    if (_useFakeAuth) {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool(Constants.isLoginKey, value);
    }
  }

  Future<bool> isExistAccount() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(Constants.isExistAccountKey) ?? false;
  }

  Future<void> setIsExistAccount(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(Constants.isExistAccountKey, value);
  }
  // END TODO
}
