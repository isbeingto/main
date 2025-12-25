import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../constants/assets.dart';
import '../../../constants/constants.dart';
import '../../../extensions/build_context_extension.dart';
import '../../../generated/locale_keys.g.dart';
import '../../../main.dart';
import '../../../routing/routes.dart';
import '../../../theme/app_theme.dart';
import '../../../utils/global_loading.dart';
import '../../../utils/validator.dart';
import '../../common/ui/widgets/common_text_form_field.dart';
import '../../common/ui/widgets/primary_button.dart';
import 'view_model/authentication_view_model.dart';
import 'widgets/sign_in_agreement.dart';

class RegisterScreen extends ConsumerStatefulWidget {
  const RegisterScreen({super.key});

  @override
  ConsumerState<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends ConsumerState<RegisterScreen> {
  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;
  late final TextEditingController _confirmPasswordController;
  late final StreamSubscription<AuthState> _authSubscription;
  bool _isEmailValid = false;
  bool _isPasswordValid = false;
  bool _isPasswordsMatch = false;

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _confirmPasswordController = TextEditingController();
    _emailController.addListener(_validateForm);
    _passwordController.addListener(_validateForm);
    _confirmPasswordController.addListener(_validateForm);

    _authSubscription =
        supabase.auth.onAuthStateChange.listen(_onAuthStateChange);
  }

  @override
  void dispose() {
    _emailController.removeListener(_validateForm);
    _passwordController.removeListener(_validateForm);
    _confirmPasswordController.removeListener(_validateForm);
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _authSubscription.cancel();
    super.dispose();
  }

  void _onAuthStateChange(AuthState data) async {
    final AuthChangeEvent event = data.event;
    final Session? session = data.session;
    debugPrint(
        '${Constants.tag} [RegisterScreen._onAuthStateChange] Auth change: $event, session: $session');

    if (event == AuthChangeEvent.signedIn && session != null) {
      // 只有在当前页面是 RegisterScreen 时才执行跳转，避免重复跳转
      if (mounted && GoRouterState.of(context).uri.toString() == Routes.register) {
        try {
          await ref
              .read(authenticationViewModelProvider.notifier)
              .upsertProfile(session.user);
        } catch (e) {
          debugPrint('${Constants.tag} [RegisterScreen._onAuthStateChange] upsertProfile error: $e');
          // 继续跳转，profile 问题不应阻止导航
        }
        if (mounted) {
          context.go(Routes.home);
        }
      }
    }
  }

  void _validateForm() {
    setState(() {
      _isEmailValid = isValidEmail(_emailController.text);
      _isPasswordValid = _passwordController.text.length >= 6;
      _isPasswordsMatch = _passwordController.text.isNotEmpty &&
          _passwordController.text == _confirmPasswordController.text;
    });
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(authenticationViewModelProvider, (previous, next) {
      if (next.isLoading != previous?.isLoading) {
        if (next.isLoading) {
          Global.showLoading(context);
        } else {
          Global.hideLoading();
        }
      }

      if (next is AsyncError) {
        context.showErrorSnackBar(next.error.toString());
      }

      if (next is AsyncData) {
        debugPrint(
            '${Constants.tag} [RegisterScreen.build] isRegisterSuccessfully = ${next.value?.isRegisterSuccessfully}, isSignInSuccessfully = ${next.value?.isSignInSuccessfully}');
        if (next.value?.isRegisterSuccessfully == true) {
          if (mounted && GoRouterState.of(context).uri.toString() == Routes.register) {
            context.pushReplacement(Routes.onboarding);
          }
        } else if (next.value?.isSignInSuccessfully == true) {
          if (mounted && GoRouterState.of(context).uri.toString() == Routes.register) {
            context.pushReplacement(Routes.home);
          }
        }
      }
    });

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 220,
                child: SvgPicture.asset(
                  Assets.welcome,
                  fit: BoxFit.fitWidth,
                  alignment: Alignment.bottomCenter,
                  semanticsLabel: 'Welcome',
                ),
              ),
              Text(
                'register'.tr(),
                style: AppTheme.title32,
              ),
              const SizedBox(height: 24),
              CommonTextFormField(
                label: 'Email',
                controller: _emailController,
                validator: notEmptyEmailValidator,
              ),
              const SizedBox(height: 16),
              CommonTextFormField(
                label: LocaleKeys.password.tr(),
                controller: _passwordController,
                isPassword: true,
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
              const SizedBox(height: 16),
              CommonTextFormField(
                label: LocaleKeys.confirmPassword.tr(),
                controller: _confirmPasswordController,
                isPassword: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return LocaleKeys.validatorRequiredField.tr();
                  }
                  if (value != _passwordController.text) {
                    return LocaleKeys.validatorPasswordNotMatch.tr();
                  }
                  return null;
                },
              ),
              const SizedBox(height: 32),
              PrimaryButton(
                isEnable: _isEmailValid && _isPasswordValid && _isPasswordsMatch,
                text: 'register'.tr(),
                onPressed: () {
                  ref
                      .read(authenticationViewModelProvider.notifier)
                      .signUpWithPassword(
                        email: _emailController.text,
                        password: _passwordController.text,
                      );
                },
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    LocaleKeys.alreadyHaveAccount.tr(),
                    style: AppTheme.body14,
                  ),
                  const SizedBox(width: 4),
                  TextButton(
                    onPressed: () {
                      context.push(Routes.login);
                    },
                    child: Text(
                      LocaleKeys.signIn.tr(),
                      style: AppTheme.title14,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              const SignInAgreement(),
              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }
}
