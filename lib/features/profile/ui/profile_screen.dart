import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '/constants/constants.dart';
import '/extensions/build_context_extension.dart';
import '/extensions/profile_extension.dart';
import '/generated/locale_keys.g.dart';
import '/routing/routes.dart';
import '/theme/app_colors.dart';
import '/theme/app_theme.dart';
import '/utils/global_loading.dart';
import '../../../../features/common/ui/widgets/common_dialog.dart';
import '../model/profile.dart';
import 'view_model/profile_view_model.dart';
import 'widgets/avatar.dart';
import 'widgets/premium_info.dart';
import 'widgets/upgrade_premium_button.dart';

/// 2025年风格的个人资料页面
/// 特点：简洁卡片布局、大头像设计、分组设置项
class ProfileScreen extends ConsumerStatefulWidget {
  const ProfileScreen({super.key});

  @override
  ConsumerState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends ConsumerState<ProfileScreen> {
  var _version = '';

  @override
  void initState() {
    super.initState();
    _getPackageInfo();
  }

  @override
  Widget build(BuildContext context) {
    final bool isIOS = !kIsWeb && defaultTargetPlatform == TargetPlatform.iOS;
    final profile = ref.watch(profileViewModelProvider.select((it) => it.value?.profile));
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? AppColors.neutral90 : AppColors.neutral5,
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          // 简洁的顶部
          SliverToBoxAdapter(
            child: SafeArea(
              bottom: false,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(
                  AppTheme.spacing20,
                  AppTheme.spacing16,
                  AppTheme.spacing20,
                  AppTheme.spacing8,
                ),
                child: Text(
                  LocaleKeys.tabProfile.tr(),
                  style: AppTheme.title28.copyWith(
                    color: isDark ? AppColors.neutral10 : AppColors.neutral90,
                  ),
                ),
              ),
            ),
          ),

          // 用户信息卡片
          SliverToBoxAdapter(
            child: _buildProfileCard(context, profile, isDark),
          ),

          // Premium 区域
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppTheme.spacing20),
              child: profile.isPremium
                  ? _buildPremiumActiveCard(context, profile, isDark)
                  : _buildUpgradePremiumCard(context, isDark),
            ),
          ),

          // 设置分组
          SliverToBoxAdapter(
            child: _buildSettingsSection(
              context,
              isDark,
              title: LocaleKeys.general.tr(),
              items: [
                _SettingItem(
                  icon: HugeIcons.strokeRoundedUser,
                  title: LocaleKeys.accountInformation.tr(),
                  onTap: () => context.push(Routes.accountInformation, extra: profile ?? Profile()),
                ),
                _SettingItem(
                  icon: HugeIcons.strokeRoundedIdea,
                  title: LocaleKeys.appearances.tr(),
                  onTap: () => context.push(Routes.appearances),
                ),
                _SettingItem(
                  icon: HugeIcons.strokeRoundedGlobe02,
                  title: LocaleKeys.language.tr(),
                  onTap: () => context.push(Routes.languages),
                ),
              ],
            ),
          ),

          // 我的订单
          SliverToBoxAdapter(
            child: _buildSettingsSection(
              context,
              isDark,
              title: '我的订单',
              items: [
                _SettingItem(
                  icon: HugeIcons.strokeRoundedShoppingBag03,
                  title: LocaleKeys.myOrders.tr(),
                  onTap: () => context.push(Routes.myOrders),
                ),
                _SettingItem(
                  icon: HugeIcons.strokeRoundedHome01,
                  title: LocaleKeys.myBookings.tr(),
                  onTap: () => context.push(Routes.myBookings),
                ),
                _SettingItem(
                  icon: HugeIcons.strokeRoundedCalendar03,
                  title: LocaleKeys.myActivitySignups.tr(),
                  onTap: () => context.push(Routes.myActivitySignups),
                ),
              ],
            ),
          ),

          // 更多信息
          SliverToBoxAdapter(
            child: _buildSettingsSection(
              context,
              isDark,
              title: LocaleKeys.preferences.tr(),
              items: [
                _SettingItem(
                  icon: HugeIcons.strokeRoundedNews,
                  title: LocaleKeys.termOfService.tr(),
                  onTap: () => context.tryLaunchUrl(Constants.termOfService),
                ),
                _SettingItem(
                  icon: HugeIcons.strokeRoundedShield01,
                  title: LocaleKeys.privacyPolicy.tr(),
                  onTap: () => context.tryLaunchUrl(Constants.privacyPolicy),
                ),
                _SettingItem(
                  icon: HugeIcons.strokeRoundedUserMultiple,
                  title: LocaleKeys.aboutUs.tr(),
                  onTap: () => context.tryLaunchUrl(Constants.aboutUs),
                ),
                _SettingItem(
                  icon: HugeIcons.strokeRoundedStar,
                  title: LocaleKeys.rateUs.tr(),
                  onTap: () => context.tryLaunchUrl(
                    isIOS ? Constants.appStore : Constants.playStore,
                  ),
                ),
                _SettingItem(
                  icon: HugeIcons.strokeRoundedSettingError04,
                  title: LocaleKeys.reportAProblem.tr(),
                  onTap: () => context.tryLaunchUrl(Constants.facebookPage),
                ),
              ],
            ),
          ),

          // 危险操作
          SliverToBoxAdapter(
            child: _buildDangerSection(context, isDark),
          ),

          // 版本号
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: AppTheme.spacing24),
              child: Center(
                child: Text(
                  'Version $_version',
                  style: AppTheme.body12.copyWith(
                    color: AppColors.neutral40,
                  ),
                ),
              ),
            ),
          ),

          // 底部安全区
          SliverToBoxAdapter(
            child: SizedBox(height: MediaQuery.of(context).padding.bottom + 80),
          ),
        ],
      ),
    );
  }

  Widget _buildProfileCard(BuildContext context, Profile? profile, bool isDark) {
    return Container(
      margin: const EdgeInsets.all(AppTheme.spacing20),
      padding: const EdgeInsets.all(AppTheme.spacing20),
      decoration: BoxDecoration(
        color: isDark ? AppColors.neutral80 : AppColors.neutral0,
        borderRadius: BorderRadius.circular(AppTheme.radiusXL),
        boxShadow: AppTheme.shadowMD,
      ),
      child: Row(
        children: [
          // 头像
          Container(
            width: 72,
            height: 72,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: AppColors.primaryGradient,
              boxShadow: [
                BoxShadow(
                  color: AppColors.accent.withValues(alpha: 0.3),
                  blurRadius: 12,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Avatar(url: profile?.avatar),
          ),
          const SizedBox(width: AppTheme.spacing16),
          // 用户信息
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  profile?.name ?? Constants.defaultName,
                  style: AppTheme.title20.copyWith(
                    color: isDark ? AppColors.neutral10 : AppColors.neutral90,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  profile?.email ?? '点击编辑个人资料',
                  style: AppTheme.body14.copyWith(
                    color: AppColors.neutral50,
                  ),
                ),
              ],
            ),
          ),
          // 编辑按钮
          GestureDetector(
            onTap: () {
              HapticFeedback.lightImpact();
              context.push(Routes.accountInformation, extra: profile ?? Profile());
            },
            child: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: isDark ? AppColors.neutral70 : AppColors.neutral5,
                borderRadius: BorderRadius.circular(AppTheme.radiusMD),
              ),
              child: Icon(
                Icons.edit_rounded,
                size: 20,
                color: isDark ? AppColors.neutral30 : AppColors.neutral60,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPremiumActiveCard(BuildContext context, Profile? profile, bool isDark) {
    return Container(
      margin: const EdgeInsets.only(bottom: AppTheme.spacing16),
      padding: const EdgeInsets.all(AppTheme.spacing20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppColors.premiumGold,
            AppColors.premiumGold.withValues(alpha: 0.8),
          ],
        ),
        borderRadius: BorderRadius.circular(AppTheme.radiusXL),
        boxShadow: [
          BoxShadow(
            color: AppColors.premiumGold.withValues(alpha: 0.3),
            blurRadius: 16,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(AppTheme.radiusMD),
            ),
            child: const Icon(
              Icons.workspace_premium_rounded,
              color: Colors.white,
              size: 28,
            ),
          ),
          const SizedBox(width: AppTheme.spacing16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Premium 会员',
                  style: AppTheme.title16.copyWith(color: Colors.white),
                ),
                const SizedBox(height: 2),
                Text(
                  '有效期至 ${profile?.expiryDatePremium ?? ''}',
                  style: AppTheme.body12.copyWith(
                    color: Colors.white.withValues(alpha: 0.8),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildUpgradePremiumCard(BuildContext context, bool isDark) {
    return GestureDetector(
      onTap: () {
        HapticFeedback.mediumImpact();
        context.push(Routes.premium);
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: AppTheme.spacing16),
        padding: const EdgeInsets.all(AppTheme.spacing20),
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
        child: Row(
          children: [
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(AppTheme.radiusMD),
              ),
              child: const Icon(
                Icons.auto_awesome_rounded,
                color: Colors.white,
                size: 28,
              ),
            ),
            const SizedBox(width: AppTheme.spacing16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '升级 Premium',
                    style: AppTheme.title16.copyWith(color: Colors.white),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    '解锁全部功能，享受更多特权',
                    style: AppTheme.body12.copyWith(
                      color: Colors.white.withValues(alpha: 0.8),
                    ),
                  ),
                ],
              ),
            ),
            Icon(
              Icons.arrow_forward_ios_rounded,
              size: 18,
              color: Colors.white.withValues(alpha: 0.8),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSettingsSection(
    BuildContext context,
    bool isDark, {
    required String title,
    required List<_SettingItem> items,
  }) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(
        AppTheme.spacing20,
        AppTheme.spacing8,
        AppTheme.spacing20,
        AppTheme.spacing16,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(
              left: AppTheme.spacing4,
              bottom: AppTheme.spacing12,
            ),
            child: Text(
              title,
              style: AppTheme.label12.copyWith(
                color: AppColors.neutral50,
                letterSpacing: 0.5,
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: isDark ? AppColors.neutral80 : AppColors.neutral0,
              borderRadius: BorderRadius.circular(AppTheme.radiusLG),
              boxShadow: AppTheme.shadowSM,
            ),
            child: Column(
              children: items.asMap().entries.map((entry) {
                final index = entry.key;
                final item = entry.value;
                final isFirst = index == 0;
                final isLast = index == items.length - 1;

                return Column(
                  children: [
                    _ModernSettingTile(
                      icon: item.icon,
                      title: item.title,
                      subtitle: item.subtitle,
                      trailing: item.trailing,
                      onTap: item.onTap,
                      isDark: isDark,
                      borderRadius: BorderRadius.vertical(
                        top: isFirst ? const Radius.circular(AppTheme.radiusLG) : Radius.zero,
                        bottom: isLast ? const Radius.circular(AppTheme.radiusLG) : Radius.zero,
                      ),
                    ),
                    if (!isLast)
                      Padding(
                        padding: const EdgeInsets.only(left: 56),
                        child: Divider(
                          height: 1,
                          color: isDark ? AppColors.neutral70 : AppColors.neutral10,
                        ),
                      ),
                  ],
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDangerSection(BuildContext context, bool isDark) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(
        AppTheme.spacing20,
        AppTheme.spacing8,
        AppTheme.spacing20,
        AppTheme.spacing8,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(
              left: AppTheme.spacing4,
              bottom: AppTheme.spacing12,
            ),
            child: Text(
              LocaleKeys.dangerousZone.tr(),
              style: AppTheme.label12.copyWith(
                color: AppColors.error,
                letterSpacing: 0.5,
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: isDark ? AppColors.neutral80 : AppColors.neutral0,
              borderRadius: BorderRadius.circular(AppTheme.radiusLG),
              border: Border.all(
                color: AppColors.error.withValues(alpha: 0.2),
              ),
            ),
            child: Column(
              children: [
                _ModernSettingTile(
                  icon: HugeIcons.strokeRoundedLogout01,
                  title: LocaleKeys.logOut.tr(),
                  iconColor: AppColors.error,
                  titleColor: AppColors.error,
                  onTap: () => _signOut(context),
                  isDark: isDark,
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(AppTheme.radiusLG),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 56),
                  child: Divider(
                    height: 1,
                    color: isDark ? AppColors.neutral70 : AppColors.neutral10,
                  ),
                ),
                _ModernSettingTile(
                  icon: HugeIcons.strokeRoundedDelete01,
                  title: LocaleKeys.deleteAccount.tr(),
                  iconColor: AppColors.error,
                  titleColor: AppColors.error,
                  onTap: () => _deleteAccount(context),
                  isDark: isDark,
                  borderRadius: const BorderRadius.vertical(
                    bottom: Radius.circular(AppTheme.radiusLG),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _getPackageInfo() {
    PackageInfo.fromPlatform().then((info) {
      setState(() {
        _version = info.version;
      });
    }).catchError((error) {
      debugPrint(
          '${Constants.tag} [_ProfileScreenState._getPackageInfo] Error: $error');
    });
  }

  void _signOut(BuildContext context) {
    showDialog(
      context: context,
      builder: (dialogContext) => CommonDialog(
        title: LocaleKeys.logOutTitle.tr(),
        content: LocaleKeys.logOutMessage.tr(),
        primaryButtonLabel: LocaleKeys.logOut.tr(),
        primaryButtonBackground: AppColors.error,
        secondaryButtonLabel: LocaleKeys.cancel.tr(),
        primaryButtonAction: () async {
          try {
            Global.showLoading(context);
            await ref.read(profileViewModelProvider.notifier).signOut();
          } on AuthException catch (error) {
            if (context.mounted) {
              context.showErrorSnackBar(error.message);
            }
          } catch (error) {
            if (context.mounted) {
              context.showErrorSnackBar(LocaleKeys.unexpectedErrorOccurred.tr());
            }
          } finally {
            if (context.mounted) {
              Global.hideLoading();
              context.pushReplacement(Routes.register);
            }
          }
        },
      ),
    );
  }

  void _deleteAccount(BuildContext context) {
    showDialog(
      context: context,
      builder: (dialogContext) => CommonDialog(
        title: LocaleKeys.deleteAccountTitle.tr(),
        content: LocaleKeys.deleteAccountMessage.tr(),
        primaryButtonLabel: LocaleKeys.deleteAccount.tr(),
        primaryButtonBackground: AppColors.error,
        secondaryButtonLabel: LocaleKeys.cancel.tr(),
        primaryButtonAction: () async {
          try {
            Global.showLoading(context);
            await ref.read(profileViewModelProvider.notifier).signOut();
          } on AuthException catch (error) {
            if (context.mounted) {
              context.showErrorSnackBar(error.message);
            }
          } catch (error) {
            if (context.mounted) {
              context.showErrorSnackBar(LocaleKeys.unexpectedErrorOccurred.tr());
            }
          } finally {
            if (context.mounted) {
              Global.hideLoading();
              context.pushReplacement(Routes.register);
            }
          }
        },
      ),
    );
  }
}

/// 设置项数据模型
class _SettingItem {
  final IconData icon;
  final String title;
  final String? subtitle;
  final Widget? trailing;
  final VoidCallback? onTap;

  _SettingItem({
    required this.icon,
    required this.title,
    this.subtitle,
    this.trailing,
    this.onTap,
  });
}

/// 现代化设置项组件
class _ModernSettingTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String? subtitle;
  final Widget? trailing;
  final VoidCallback? onTap;
  final bool isDark;
  final BorderRadius borderRadius;
  final Color? iconColor;
  final Color? titleColor;

  const _ModernSettingTile({
    required this.icon,
    required this.title,
    this.subtitle,
    this.trailing,
    this.onTap,
    required this.isDark,
    this.borderRadius = BorderRadius.zero,
    this.iconColor,
    this.titleColor,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {
          HapticFeedback.selectionClick();
          onTap?.call();
        },
        borderRadius: borderRadius,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppTheme.spacing16,
            vertical: AppTheme.spacing12,
          ),
          child: Row(
            children: [
              Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  color: (iconColor ?? AppColors.accent).withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(AppTheme.radiusSM),
                ),
                child: Icon(
                  icon,
                  size: 20,
                  color: iconColor ?? AppColors.accent,
                ),
              ),
              const SizedBox(width: AppTheme.spacing12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: AppTheme.body16.copyWith(
                        color: titleColor ?? (isDark ? AppColors.neutral10 : AppColors.neutral90),
                      ),
                    ),
                    if (subtitle != null) ...[
                      const SizedBox(height: 2),
                      Text(
                        subtitle!,
                        style: AppTheme.body12.copyWith(
                          color: AppColors.neutral50,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
              trailing ??
                  Icon(
                    Icons.arrow_forward_ios_rounded,
                    size: 16,
                    color: isDark ? AppColors.neutral50 : AppColors.neutral40,
                  ),
            ],
          ),
        ),
      ),
    );
  }
}
