import 'package:flutter/material.dart';

import '/theme/app_colors.dart';
import '/theme/app_theme.dart';

/// 2025年风格的加载组件
class Loading extends StatelessWidget {
  final bool withBackground;
  
  const Loading({super.key, this.withBackground = true});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    final loader = Container(
      width: 80,
      height: 80,
      decoration: BoxDecoration(
        color: isDark ? AppColors.neutral80 : AppColors.neutral0,
        borderRadius: BorderRadius.circular(AppTheme.radiusXL),
        boxShadow: AppTheme.shadowLG,
      ),
      child: Center(
        child: SizedBox(
          width: 36,
          height: 36,
          child: CircularProgressIndicator(
            strokeWidth: 3,
            valueColor: AlwaysStoppedAnimation<Color>(AppColors.accent),
          ),
        ),
      ),
    );
    
    if (!withBackground) return loader;
    
    return Container(
      constraints: const BoxConstraints.expand(),
      color: (isDark ? Colors.black : Colors.black).withValues(alpha: 0.4),
      child: Center(child: loader),
    );
  }
}
