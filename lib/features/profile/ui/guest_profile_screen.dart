import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:hugeicons/hugeicons.dart';

import '../../../constants/constants.dart';
import '../../../generated/locale_keys.g.dart';
import '../../../routing/routes.dart';
import '../../../theme/app_colors.dart';
import '../../../theme/app_theme.dart';
import '../../../extensions/build_context_extension.dart';

/// 2025年风格的访客个人资料页面
class GuestProfileScreen extends ConsumerWidget {
  const GuestProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    return Scaffold(
      backgroundColor: isDark ? AppColors.neutral90 : AppColors.neutral5,
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          // 顶部标题
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

          // 登录引导卡片
          SliverToBoxAdapter(
            child: _buildLoginCard(context, isDark),
          ),

          // 通用设置
          SliverToBoxAdapter(
            child: _buildSettingsSection(
              context,
              isDark,
              title: LocaleKeys.general.tr(),
              items: [
                _GuestSettingItem(
                  icon: HugeIcons.strokeRoundedIdea,
                  title: LocaleKeys.appearances.tr(),
                  onTap: () => context.push(Routes.appearances),
                ),
                _GuestSettingItem(
                  icon: HugeIcons.strokeRoundedGlobe02,
                  title: LocaleKeys.language.tr(),
                  onTap: () => context.push(Routes.languages),
                ),
              ],
            ),
          ),

          // 关于我们
          SliverToBoxAdapter(
            child: _buildSettingsSection(
              context,
              isDark,
              title: LocaleKeys.preferences.tr(),
              items: [
                _GuestSettingItem(
                  icon: HugeIcons.strokeRoundedNews,
                  title: LocaleKeys.termOfService.tr(),
                  onTap: () => context.tryLaunchUrl(Constants.termOfService),
                ),
                _GuestSettingItem(
                  icon: HugeIcons.strokeRoundedShield01,
                  title: LocaleKeys.privacyPolicy.tr(),
                  onTap: () => context.tryLaunchUrl(Constants.privacyPolicy),
                ),
                _GuestSettingItem(
                  icon: HugeIcons.strokeRoundedUserMultiple,
                  title: LocaleKeys.aboutUs.tr(),
                  onTap: () => context.tryLaunchUrl(Constants.aboutUs),
                ),
                _GuestSettingItem(
                  icon: HugeIcons.strokeRoundedSettingError04,
                  title: LocaleKeys.reportAProblem.tr(),
                  onTap: () => context.tryLaunchUrl(Constants.facebookPage),
                ),
              ],
            ),
          ),

          // 底部安全区
          SliverToBoxAdapter(
            child: SizedBox(height: MediaQuery.of(context).padding.bottom + 100),
          ),
        ],
      ),
    );
  }

  Widget _buildLoginCard(BuildContext context, bool isDark) {
    return GestureDetector(
      onTap: () {
        HapticFeedback.mediumImpact();
        context.push(Routes.login);
      },
      child: Container(
        margin: const EdgeInsets.all(AppTheme.spacing20),
        padding: const EdgeInsets.all(AppTheme.spacing24),
        decoration: BoxDecoration(
          gradient: AppColors.primaryGradient,
          borderRadius: BorderRadius.circular(AppTheme.radius2XL),
          boxShadow: [
            BoxShadow(
              color: AppColors.accent.withValues(alpha: 0.3),
              blurRadius: 20,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Row(
          children: [
            // 头像占位
            Container(
              width: 64,
              height: 64,
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.2),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.person_rounded,
                size: 32,
                color: Colors.white,
              ),
            ),
            const SizedBox(width: AppTheme.spacing16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    LocaleKeys.signIn.tr(),
                    style: AppTheme.title20.copyWith(
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '登录以体验更多功能',
                    style: AppTheme.body14.copyWith(
                      color: Colors.white.withValues(alpha: 0.8),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(AppTheme.radiusMD),
              ),
              child: const Icon(
                Icons.arrow_forward_rounded,
                color: Colors.white,
                size: 22,
              ),
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
    required List<_GuestSettingItem> items,
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
                final isLast = index == items.length - 1;

                return Column(
                  children: [
                    Material(
                      color: Colors.transparent,
                      child: InkWell(
                        onTap: () {
                          HapticFeedback.selectionClick();
                          item.onTap();
                        },
                        borderRadius: BorderRadius.vertical(
                          top: index == 0 ? const Radius.circular(AppTheme.radiusLG) : Radius.zero,
                          bottom: isLast ? const Radius.circular(AppTheme.radiusLG) : Radius.zero,
                        ),
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
                                  color: AppColors.accent.withValues(alpha: 0.1),
                                  borderRadius: BorderRadius.circular(AppTheme.radiusSM),
                                ),
                                child: Icon(
                                  item.icon,
                                  size: 20,
                                  color: AppColors.accent,
                                ),
                              ),
                              const SizedBox(width: AppTheme.spacing12),
                              Expanded(
                                child: Text(
                                  item.title,
                                  style: AppTheme.body16.copyWith(
                                    color: isDark ? AppColors.neutral10 : AppColors.neutral90,
                                  ),
                                ),
                              ),
                              Icon(
                                Icons.arrow_forward_ios_rounded,
                                size: 16,
                                color: isDark ? AppColors.neutral50 : AppColors.neutral40,
                              ),
                            ],
                          ),
                        ),
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
}

class _GuestSettingItem {
  final IconData icon;
  final String title;
  final VoidCallback onTap;

  _GuestSettingItem({
    required this.icon,
    required this.title,
    required this.onTap,
  });
}
