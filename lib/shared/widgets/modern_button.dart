import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_theme.dart';

/// 2025年风格的现代按钮组件
/// 特点：渐变色、圆润、动画反馈

enum ModernButtonSize { small, medium, large }
enum ModernButtonVariant { primary, secondary, outline, ghost, danger }

class ModernButton extends StatefulWidget {
  final String text;
  final VoidCallback? onPressed;
  final ModernButtonSize size;
  final ModernButtonVariant variant;
  final IconData? icon;
  final bool iconRight;
  final bool loading;
  final bool fullWidth;
  final double? borderRadius;

  const ModernButton({
    super.key,
    required this.text,
    this.onPressed,
    this.size = ModernButtonSize.medium,
    this.variant = ModernButtonVariant.primary,
    this.icon,
    this.iconRight = false,
    this.loading = false,
    this.fullWidth = false,
    this.borderRadius,
  });

  @override
  State<ModernButton> createState() => _ModernButtonState();
}

class _ModernButtonState extends State<ModernButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 100),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.97).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDisabled = widget.onPressed == null || widget.loading;

    return AnimatedBuilder(
      animation: _scaleAnimation,
      builder: (context, child) {
        return Transform.scale(
          scale: _scaleAnimation.value,
          child: child,
        );
      },
      child: GestureDetector(
        onTapDown: isDisabled ? null : (_) => _controller.forward(),
        onTapUp: isDisabled
            ? null
            : (_) {
                _controller.reverse();
                HapticFeedback.lightImpact();
                widget.onPressed?.call();
              },
        onTapCancel: isDisabled ? null : () => _controller.reverse(),
        child: AnimatedContainer(
          duration: AppTheme.durationFast,
          width: widget.fullWidth ? double.infinity : null,
          padding: _getPadding(),
          decoration: _getDecoration(isDisabled),
          child: Row(
            mainAxisSize: widget.fullWidth ? MainAxisSize.max : MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: _buildChildren(isDisabled),
          ),
        ),
      ),
    );
  }

  EdgeInsetsGeometry _getPadding() {
    switch (widget.size) {
      case ModernButtonSize.small:
        return const EdgeInsets.symmetric(
          horizontal: AppTheme.spacing12,
          vertical: AppTheme.spacing8,
        );
      case ModernButtonSize.medium:
        return const EdgeInsets.symmetric(
          horizontal: AppTheme.spacing20,
          vertical: AppTheme.spacing12,
        );
      case ModernButtonSize.large:
        return const EdgeInsets.symmetric(
          horizontal: AppTheme.spacing24,
          vertical: AppTheme.spacing16,
        );
    }
  }

  BoxDecoration _getDecoration(bool isDisabled) {
    final radius = widget.borderRadius ?? AppTheme.radiusFull;

    switch (widget.variant) {
      case ModernButtonVariant.primary:
        return BoxDecoration(
          gradient: isDisabled
              ? null
              : const LinearGradient(
                  colors: [AppColors.accent, AppColors.accent70],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
          color: isDisabled ? AppColors.neutral30 : null,
          borderRadius: BorderRadius.circular(radius),
          boxShadow: isDisabled ? null : [
            BoxShadow(
              color: AppColors.accent.withValues(alpha: 0.3),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        );
      case ModernButtonVariant.secondary:
        return BoxDecoration(
          color: isDisabled ? AppColors.neutral20 : AppColors.primary20,
          borderRadius: BorderRadius.circular(radius),
        );
      case ModernButtonVariant.outline:
        return BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(radius),
          border: Border.all(
            color: isDisabled ? AppColors.neutral30 : AppColors.neutral40,
            width: 1.5,
          ),
        );
      case ModernButtonVariant.ghost:
        return BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(radius),
        );
      case ModernButtonVariant.danger:
        return BoxDecoration(
          color: isDisabled ? AppColors.neutral30 : AppColors.error,
          borderRadius: BorderRadius.circular(radius),
        );
    }
  }

  Color _getTextColor(bool isDisabled) {
    if (isDisabled) return AppColors.neutral50;

    switch (widget.variant) {
      case ModernButtonVariant.primary:
        return Colors.white;
      case ModernButtonVariant.secondary:
        return AppColors.primary;
      case ModernButtonVariant.outline:
        return AppColors.neutral80;
      case ModernButtonVariant.ghost:
        return AppColors.neutral70;
      case ModernButtonVariant.danger:
        return Colors.white;
    }
  }

  TextStyle _getTextStyle(bool isDisabled) {
    final color = _getTextColor(isDisabled);
    switch (widget.size) {
      case ModernButtonSize.small:
        return AppTheme.buttonSmall.copyWith(color: color);
      case ModernButtonSize.medium:
        return AppTheme.buttonMedium.copyWith(color: color);
      case ModernButtonSize.large:
        return AppTheme.buttonLarge.copyWith(color: color);
    }
  }

  double _getIconSize() {
    switch (widget.size) {
      case ModernButtonSize.small:
        return 16;
      case ModernButtonSize.medium:
        return 18;
      case ModernButtonSize.large:
        return 20;
    }
  }

  List<Widget> _buildChildren(bool isDisabled) {
    final textColor = _getTextColor(isDisabled);
    final iconSize = _getIconSize();
    final textStyle = _getTextStyle(isDisabled);

    if (widget.loading) {
      return [
        SizedBox(
          width: iconSize,
          height: iconSize,
          child: CircularProgressIndicator(
            strokeWidth: 2,
            valueColor: AlwaysStoppedAnimation<Color>(textColor),
          ),
        ),
      ];
    }

    final List<Widget> children = [];

    if (widget.icon != null && !widget.iconRight) {
      children.add(Icon(widget.icon, size: iconSize, color: textColor));
      children.add(const SizedBox(width: 8));
    }

    children.add(Text(widget.text, style: textStyle));

    if (widget.icon != null && widget.iconRight) {
      children.add(const SizedBox(width: 8));
      children.add(Icon(widget.icon, size: iconSize, color: textColor));
    }

    return children;
  }
}

/// 图标按钮 - 圆形
class ModernIconButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback? onPressed;
  final double size;
  final Color? backgroundColor;
  final Color? iconColor;
  final bool outlined;

  const ModernIconButton({
    super.key,
    required this.icon,
    this.onPressed,
    this.size = 44,
    this.backgroundColor,
    this.iconColor,
    this.outlined = false,
  });

  @override
  Widget build(BuildContext context) {
    final bgColor = backgroundColor ?? AppColors.neutral10;
    final fgColor = iconColor ?? AppColors.neutral70;

    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: outlined ? Colors.transparent : bgColor,
          border: outlined ? Border.all(color: bgColor, width: 1.5) : null,
        ),
        child: Icon(
          icon,
          size: size * 0.5,
          color: fgColor,
        ),
      ),
    );
  }
}

/// 浮动操作按钮 - 渐变样式
class ModernFAB extends StatelessWidget {
  final IconData icon;
  final VoidCallback? onPressed;
  final String? label;

  const ModernFAB({
    super.key,
    required this.icon,
    this.onPressed,
    this.label,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        HapticFeedback.mediumImpact();
        onPressed?.call();
      },
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: label != null ? 20 : 16,
          vertical: 16,
        ),
        decoration: BoxDecoration(
          gradient: AppColors.primaryGradient,
          borderRadius: BorderRadius.circular(AppTheme.radiusFull),
          boxShadow: [
            BoxShadow(
              color: AppColors.accent.withValues(alpha: 0.4),
              blurRadius: 16,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: Colors.white, size: 22),
            if (label != null) ...[
              const SizedBox(width: 8),
              Text(
                label!,
                style: AppTheme.buttonMedium.copyWith(color: Colors.white),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
