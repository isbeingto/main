import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../extensions/build_context_extension.dart';
import '../../../features/listings/ui/listings_screen.dart';
import '../../../features/profile/ui/profile_wrapper.dart';
import '../../../theme/app_colors.dart';
import '../../../theme/app_theme.dart';

/// 2025年风格的现代主屏幕
/// 使用简洁的底部导航，带有微动画效果
class MainScreen extends ConsumerStatefulWidget {
  const MainScreen({super.key});

  @override
  ConsumerState createState() => _MainScreenState();
}

class _MainScreenState extends ConsumerState<MainScreen> {
  int _currentIndex = 0;
  late PageController _pageController;
  
  // 动态创建screens列表，而不是使用const
  final List<Widget> _screens = [
    const ListingsScreen(),
    const ProfileWrapper(),
  ];

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _onTabTapped(int index) {
    if (_currentIndex != index) {
      HapticFeedback.selectionClick();
      setState(() {
        _currentIndex = index;
      });
      _pageController.animateToPage(
        index,
        duration: AppTheme.durationNormal,
        curve: AppTheme.curveStandard,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = context.isDarkMode;
    
    return Scaffold(
      body: PageView(
        controller: _pageController,
        physics: const NeverScrollableScrollPhysics(),
        children: _screens,
      ),
      extendBody: true,
      bottomNavigationBar: _ModernBottomNavBar(
        currentIndex: _currentIndex,
        onTap: _onTabTapped,
        isDark: isDark,
      ),
    );
  }
}

/// 现代化底部导航栏
class _ModernBottomNavBar extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;
  final bool isDark;

  const _ModernBottomNavBar({
    required this.currentIndex,
    required this.onTap,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(
        AppTheme.spacing24,
        AppTheme.spacing12,
        AppTheme.spacing24,
        MediaQuery.of(context).padding.bottom + AppTheme.spacing12,
      ),
      decoration: BoxDecoration(
        color: isDark 
            ? AppColors.neutral80.withValues(alpha: 0.95)
            : AppColors.neutral0.withValues(alpha: 0.95),
        borderRadius: const BorderRadius.vertical(
          top: Radius.circular(AppTheme.radius2XL),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 20,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _NavItem(
            icon: Icons.home_rounded,
            iconOutlined: Icons.home_outlined,
            label: '首页',
            isSelected: currentIndex == 0,
            onTap: () => onTap(0),
            isDark: isDark,
          ),
          _NavItem(
            icon: Icons.person_rounded,
            iconOutlined: Icons.person_outline_rounded,
            label: '我的',
            isSelected: currentIndex == 1,
            onTap: () => onTap(1),
            isDark: isDark,
          ),
        ],
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  final IconData icon;
  final IconData iconOutlined;
  final String label;
  final bool isSelected;
  final VoidCallback onTap;
  final bool isDark;

  const _NavItem({
    required this.icon,
    required this.iconOutlined,
    required this.label,
    required this.isSelected,
    required this.onTap,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: AnimatedContainer(
        duration: AppTheme.durationFast,
        padding: const EdgeInsets.symmetric(
          horizontal: AppTheme.spacing20,
          vertical: AppTheme.spacing8,
        ),
        decoration: BoxDecoration(
          color: isSelected 
              ? AppColors.accent.withValues(alpha: 0.12)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(AppTheme.radiusFull),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            AnimatedSwitcher(
              duration: AppTheme.durationFast,
              child: Icon(
                isSelected ? icon : iconOutlined,
                key: ValueKey(isSelected),
                size: 24,
                color: isSelected 
                    ? AppColors.accent 
                    : (isDark ? AppColors.neutral40 : AppColors.neutral50),
              ),
            ),
            AnimatedSize(
              duration: AppTheme.durationFast,
              child: isSelected
                  ? Padding(
                      padding: const EdgeInsets.only(left: AppTheme.spacing8),
                      child: Text(
                        label,
                        style: AppTheme.label14.copyWith(
                          color: AppColors.accent,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    )
                  : const SizedBox.shrink(),
            ),
          ],
        ),
      ),
    );
  }
}
