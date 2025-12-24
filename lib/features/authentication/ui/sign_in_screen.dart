import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../extensions/build_context_extension.dart';
import '../../../features/authentication/ui/view_model/authentication_view_model.dart';
import '../../../features/common/ui/widgets/common_text_form_field.dart';
import '../../../features/common/ui/widgets/primary_button.dart';
import '../../../generated/locale_keys.g.dart';
import '../../../routing/routes.dart';
import '../../../theme/app_colors.dart';
import '../../../theme/app_theme.dart';
import '../../../utils/validator.dart';

/// 2025年风格的登录页面
class SignInScreen extends ConsumerStatefulWidget {
  const SignInScreen({super.key});

  @override
  ConsumerState createState() => _SignInScreenState();
}

class _SignInScreenState extends ConsumerState<SignInScreen>
    with SingleTickerProviderStateMixin {
  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;
  late AnimationController _animController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;
  bool _isEmailValid = false;
  bool _isPasswordValid = false;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _emailController.addListener(_validateForm);
    _passwordController.addListener(_validateForm);
    
    _animController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animController,
        curve: const Interval(0.0, 0.6, curve: Curves.easeOut),
      ),
    );
    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.1),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _animController,
        curve: const Interval(0.2, 1.0, curve: Curves.easeOut),
      ),
    );
    _animController.forward();
  }

  @override
  void dispose() {
    _emailController.removeListener(_validateForm);
    _passwordController.removeListener(_validateForm);
    _emailController.dispose();
    _passwordController.dispose();
    _animController.dispose();
    super.dispose();
  }

  void _validateForm() {
    setState(() {
      _isEmailValid = isValidEmail(_emailController.text);
      _isPasswordValid = _passwordController.text.length >= 6;
    });
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    ref.listen(authenticationViewModelProvider, (previous, next) {
      if (next.isLoading != previous?.isLoading) {
        setState(() {
          _isLoading = next.isLoading;
        });
      }

      if (next is AsyncError) {
        context.showErrorSnackBar(next.error.toString());
      }

      if (next is AsyncData) {
        if (next.value?.isSignInSuccessfully == true) {
          context.go(Routes.profile);
        }
      }
    });

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: isDark ? SystemUiOverlayStyle.light : SystemUiOverlayStyle.dark,
      child: Scaffold(
        backgroundColor: isDark ? AppColors.neutral90 : AppColors.neutral0,
        body: SafeArea(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppTheme.spacing24),
              child: AnimatedBuilder(
                animation: _animController,
                builder: (context, child) {
                  return FadeTransition(
                    opacity: _fadeAnimation,
                    child: SlideTransition(
                      position: _slideAnimation,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: AppTheme.spacing16),
                          // 返回按钮
                          GestureDetector(
                            onTap: () {
                              HapticFeedback.lightImpact();
                              Navigator.pop(context);
                            },
                            child: Container(
                              width: 44,
                              height: 44,
                              decoration: BoxDecoration(
                                color: isDark ? AppColors.neutral80 : AppColors.neutral5,
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                Icons.arrow_back_rounded,
                                color: isDark ? AppColors.neutral10 : AppColors.neutral80,
                                size: 22,
                              ),
                            ),
                          ),
                          const SizedBox(height: AppTheme.spacing32),
                          
                          // 欢迎图标
                          Container(
                            width: 72,
                            height: 72,
                            decoration: BoxDecoration(
                              gradient: AppColors.primaryGradient,
                              borderRadius: BorderRadius.circular(AppTheme.radiusXL),
                              boxShadow: [
                                BoxShadow(
                                  color: AppColors.accent.withValues(alpha: 0.3),
                                  blurRadius: 16,
                                  offset: const Offset(0, 6),
                                ),
                              ],
                            ),
                            child: const Icon(
                              Icons.waving_hand_rounded,
                              size: 32,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(height: AppTheme.spacing24),
                          
                          // 标题
                          Text(
                            '欢迎回来',
                            style: AppTheme.title32.copyWith(
                              color: isDark ? AppColors.neutral10 : AppColors.neutral90,
                            ),
                          ),
                          const SizedBox(height: AppTheme.spacing8),
                          Text(
                            '登录您的账户，探索理想民宿',
                            style: AppTheme.body16.copyWith(
                              color: AppColors.neutral50,
                            ),
                          ),
                          const SizedBox(height: AppTheme.spacing40),
                          
                          // 邮箱输入框
                          CommonTextFormField(
                            label: '邮箱地址',
                            controller: _emailController,
                            keyboardType: TextInputType.emailAddress,
                            hintText: 'example@email.com',
                            validator: notEmptyEmailValidator,
                          ),
                          const SizedBox(height: AppTheme.spacing20),
                          
                          // 密码输入框
                          CommonTextFormField(
                            label: LocaleKeys.password.tr(),
                            controller: _passwordController,
                            isPassword: true,
                            hintText: '请输入密码',
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return LocaleKeys.validatorRequiredField.tr();
                              }
                              if (value.length < 6) {
                                return LocaleKeys.validatorPasswordTooShort.tr();
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: AppTheme.spacing12),
                          
                          // 忘记密码
                          Align(
                            alignment: Alignment.centerRight,
                            child: GestureDetector(
                              onTap: () {
                                // TODO: 忘记密码功能
                              },
                              child: Text(
                                '忘记密码？',
                                style: AppTheme.label14.copyWith(
                                  color: AppColors.accent,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: AppTheme.spacing32),
                          
                          // 登录按钮
                          PrimaryButton(
                            isEnable: _isEmailValid && _isPasswordValid,
                            isLoading: _isLoading,
                            text: LocaleKeys.signIn.tr(),
                            onPressed: () {
                              ref
                                  .read(authenticationViewModelProvider.notifier)
                                  .signInWithPassword(
                                    email: _emailController.text,
                                    password: _passwordController.text,
                                  );
                            },
                          ),
                          const SizedBox(height: AppTheme.spacing24),
                          
                          // 分隔线
                          Row(
                            children: [
                              Expanded(
                                child: Container(
                                  height: 1,
                                  color: isDark ? AppColors.neutral70 : AppColors.neutral20,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: AppTheme.spacing16),
                                child: Text(
                                  '或',
                                  style: AppTheme.body14.copyWith(color: AppColors.neutral50),
                                ),
                              ),
                              Expanded(
                                child: Container(
                                  height: 1,
                                  color: isDark ? AppColors.neutral70 : AppColors.neutral20,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: AppTheme.spacing24),
                          
                          // 社交登录按钮
                          _SocialLoginButton(
                            icon: Icons.apple,
                            text: '使用 Apple 登录',
                            onTap: () {},
                            isDark: isDark,
                          ),
                          const SizedBox(height: AppTheme.spacing12),
                          _SocialLoginButton(
                            icon: Icons.g_mobiledata_rounded,
                            text: '使用 Google 登录',
                            onTap: () {},
                            isDark: isDark,
                            iconSize: 28,
                          ),
                          const SizedBox(height: AppTheme.spacing32),
                          
                          // 注册链接
                          Center(
                            child: GestureDetector(
                              onTap: () => context.push(Routes.register),
                              child: RichText(
                                text: TextSpan(
                                  style: AppTheme.body14.copyWith(
                                    color: AppColors.neutral50,
                                  ),
                                  children: [
                                    const TextSpan(text: '还没有账户？'),
                                    TextSpan(
                                      text: ' 立即注册',
                                      style: AppTheme.subtitle14.copyWith(
                                        color: AppColors.accent,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: AppTheme.spacing32),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _SocialLoginButton extends StatelessWidget {
  final IconData icon;
  final String text;
  final VoidCallback onTap;
  final bool isDark;
  final double iconSize;

  const _SocialLoginButton({
    required this.icon,
    required this.text,
    required this.onTap,
    required this.isDark,
    this.iconSize = 24,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        HapticFeedback.lightImpact();
        onTap();
      },
      child: Container(
        height: 56,
        decoration: BoxDecoration(
          color: isDark ? AppColors.neutral80 : AppColors.neutral5,
          borderRadius: BorderRadius.circular(AppTheme.radiusFull),
          border: Border.all(
            color: isDark ? AppColors.neutral70 : AppColors.neutral20,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: iconSize,
              color: isDark ? AppColors.neutral10 : AppColors.neutral80,
            ),
            const SizedBox(width: AppTheme.spacing12),
            Text(
              text,
              style: AppTheme.subtitle16.copyWith(
                color: isDark ? AppColors.neutral10 : AppColors.neutral80,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
