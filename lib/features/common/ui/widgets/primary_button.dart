import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '/theme/app_colors.dart';
import '/theme/app_theme.dart';

/// 2025年风格的主要按钮
class PrimaryButton extends StatelessWidget {
  final String text;
  final Function() onPressed;
  final Widget? icon;
  final Color? textColor;
  final Color? backgroundColor;
  final double verticalPadding;
  final bool isEnable;
  final bool isLoading;

  const PrimaryButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.icon,
    this.textColor,
    this.backgroundColor,
    this.verticalPadding = 14,
    this.isEnable = true,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    return GestureDetector(
      onTap: (isEnable && !isLoading) 
          ? () {
              HapticFeedback.mediumImpact();
              onPressed();
            }
          : null,
      child: AnimatedContainer(
        duration: AppTheme.durationFast,
        height: 56,
        decoration: BoxDecoration(
          gradient: (isEnable && !isLoading) 
              ? AppColors.primaryGradient 
              : null,
          color: (isEnable && !isLoading) 
              ? null 
              : (isDark ? AppColors.neutral70 : AppColors.neutral20),
          borderRadius: BorderRadius.circular(AppTheme.radiusFull),
          boxShadow: (isEnable && !isLoading)
              ? [
                  BoxShadow(
                    color: AppColors.accent.withValues(alpha: 0.3),
                    blurRadius: 12,
                    offset: const Offset(0, 4),
                  ),
                ]
              : null,
        ),
        child: Container(
          width: double.infinity,
          alignment: Alignment.center,
          child: isLoading
              ? SizedBox(
                  width: 24,
                  height: 24,
                  child: CircularProgressIndicator(
                    strokeWidth: 2.5,
                    valueColor: AlwaysStoppedAnimation<Color>(
                      textColor ?? Colors.white,
                    ),
                  ),
                )
              : Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (icon != null) ...[icon!, const SizedBox(width: 8)],
                    Text(
                      text,
                      style: AppTheme.buttonLarge.copyWith(
                        color: (isEnable && !isLoading)
                            ? (textColor ?? Colors.white)
                            : (isDark ? AppColors.neutral50 : AppColors.neutral40),
                      ),
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}
