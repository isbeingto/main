import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ming_cute_icons/ming_cute_icons.dart';

import '../extensions/build_context_extension.dart';
import '../generated/locale_keys.g.dart';
import '../theme/app_colors.dart';

/// App shell with bottom navigation bar for main tabs
class AppShell extends StatelessWidget {
  const AppShell({
    super.key,
    required this.navigationShell,
  });

  final StatefulNavigationShell navigationShell;

  @override
  Widget build(BuildContext context) {
    final isDarkMode = context.isDarkMode;
    final selectedColor = AppColors.blueberry100;
    final unselectedColor = isDarkMode ? AppColors.mono40 : AppColors.mono60;
    final backgroundColor = context.secondaryWidgetColor;

    return Scaffold(
      body: navigationShell,
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 10,
              offset: const Offset(0, -2),
            ),
          ],
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _NavBarItem(
                  icon: MingCuteIcons.mgc_home_4_line,
                  activeIcon: MingCuteIcons.mgc_home_4_fill,
                  label: LocaleKeys.tabHome.tr(),
                  isSelected: navigationShell.currentIndex == 0,
                  selectedColor: selectedColor,
                  unselectedColor: unselectedColor,
                  onTap: () => _onTap(0),
                ),
                _NavBarItem(
                  icon: MingCuteIcons.mgc_building_2_line,
                  activeIcon: MingCuteIcons.mgc_building_2_fill,
                  label: LocaleKeys.tabLodging.tr(),
                  isSelected: navigationShell.currentIndex == 1,
                  selectedColor: selectedColor,
                  unselectedColor: unselectedColor,
                  onTap: () => _onTap(1),
                ),
                _NavBarItem(
                  icon: MingCuteIcons.mgc_calendar_2_line,
                  activeIcon: MingCuteIcons.mgc_calendar_2_fill,
                  label: LocaleKeys.tabActivity.tr(),
                  isSelected: navigationShell.currentIndex == 2,
                  selectedColor: selectedColor,
                  unselectedColor: unselectedColor,
                  onTap: () => _onTap(2),
                ),
                _NavBarItem(
                  icon: MingCuteIcons.mgc_user_3_line,
                  activeIcon: MingCuteIcons.mgc_user_3_fill,
                  label: LocaleKeys.tabProfile.tr(),
                  isSelected: navigationShell.currentIndex == 3,
                  selectedColor: selectedColor,
                  unselectedColor: unselectedColor,
                  onTap: () => _onTap(3),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _onTap(int index) {
    navigationShell.goBranch(
      index,
      // Go to initial location of the branch if tapping on the current branch
      initialLocation: index == navigationShell.currentIndex,
    );
  }
}

class _NavBarItem extends StatelessWidget {
  const _NavBarItem({
    required this.icon,
    required this.activeIcon,
    required this.label,
    required this.isSelected,
    required this.selectedColor,
    required this.unselectedColor,
    required this.onTap,
  });

  final IconData icon;
  final IconData activeIcon;
  final String label;
  final bool isSelected;
  final Color selectedColor;
  final Color unselectedColor;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final color = isSelected ? selectedColor : unselectedColor;
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              isSelected ? activeIcon : icon,
              color: color,
              size: 24,
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                fontSize: 11,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                color: color,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
