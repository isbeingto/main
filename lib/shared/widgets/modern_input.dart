import 'package:flutter/material.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_theme.dart';

/// 2025年风格的现代输入框组件
/// 特点：无边框设计、柔和背景、大圆角

class ModernTextField extends StatefulWidget {
  final String? label;
  final String? hint;
  final String? helperText;
  final String? errorText;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final bool obscureText;
  final bool enabled;
  final int? maxLines;
  final int? maxLength;
  final IconData? prefixIcon;
  final IconData? suffixIcon;
  final VoidCallback? onSuffixTap;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onSubmitted;
  final FocusNode? focusNode;
  final TextInputAction? textInputAction;
  final bool filled;
  final double? borderRadius;

  const ModernTextField({
    super.key,
    this.label,
    this.hint,
    this.helperText,
    this.errorText,
    this.controller,
    this.keyboardType,
    this.obscureText = false,
    this.enabled = true,
    this.maxLines = 1,
    this.maxLength,
    this.prefixIcon,
    this.suffixIcon,
    this.onSuffixTap,
    this.onChanged,
    this.onSubmitted,
    this.focusNode,
    this.textInputAction,
    this.filled = true,
    this.borderRadius,
  });

  @override
  State<ModernTextField> createState() => _ModernTextFieldState();
}

class _ModernTextFieldState extends State<ModernTextField> {
  late FocusNode _focusNode;
  bool _isFocused = false;

  @override
  void initState() {
    super.initState();
    _focusNode = widget.focusNode ?? FocusNode();
    _focusNode.addListener(_handleFocusChange);
  }

  @override
  void dispose() {
    if (widget.focusNode == null) {
      _focusNode.dispose();
    }
    super.dispose();
  }

  void _handleFocusChange() {
    setState(() {
      _isFocused = _focusNode.hasFocus;
    });
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final hasError = widget.errorText != null;
    final radius = widget.borderRadius ?? AppTheme.radiusLG;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        // Label
        if (widget.label != null) ...[
          Text(
            widget.label!,
            style: AppTheme.label14.copyWith(
              color: hasError ? AppColors.error : AppColors.neutral70,
            ),
          ),
          const SizedBox(height: AppTheme.spacing8),
        ],
        // Input Field
        AnimatedContainer(
          duration: AppTheme.durationFast,
          decoration: BoxDecoration(
            color: widget.filled
                ? (isDark ? AppColors.neutral80 : AppColors.neutral5)
                : Colors.transparent,
            borderRadius: BorderRadius.circular(radius),
            border: Border.all(
              color: hasError
                  ? AppColors.error
                  : _isFocused
                      ? AppColors.accent
                      : widget.filled
                          ? Colors.transparent
                          : AppColors.neutral30,
              width: _isFocused ? 2 : 1,
            ),
          ),
          child: TextField(
            controller: widget.controller,
            focusNode: _focusNode,
            keyboardType: widget.keyboardType,
            obscureText: widget.obscureText,
            enabled: widget.enabled,
            maxLines: widget.maxLines,
            maxLength: widget.maxLength,
            onChanged: widget.onChanged,
            onSubmitted: widget.onSubmitted,
            textInputAction: widget.textInputAction,
            style: AppTheme.body16.copyWith(
              color: isDark ? AppColors.neutral10 : AppColors.neutral90,
            ),
            decoration: InputDecoration(
              hintText: widget.hint,
              hintStyle: AppTheme.body16.copyWith(
                color: AppColors.neutral40,
              ),
              border: InputBorder.none,
              contentPadding: EdgeInsets.symmetric(
                horizontal: AppTheme.spacing16,
                vertical: widget.maxLines != null && widget.maxLines! > 1
                    ? AppTheme.spacing16
                    : AppTheme.spacing12,
              ),
              prefixIcon: widget.prefixIcon != null
                  ? Icon(
                      widget.prefixIcon,
                      color: _isFocused ? AppColors.accent : AppColors.neutral50,
                      size: 20,
                    )
                  : null,
              suffixIcon: widget.suffixIcon != null
                  ? GestureDetector(
                      onTap: widget.onSuffixTap,
                      child: Icon(
                        widget.suffixIcon,
                        color: AppColors.neutral50,
                        size: 20,
                      ),
                    )
                  : null,
              counterText: '',
            ),
          ),
        ),
        // Helper/Error text
        if (widget.helperText != null || hasError) ...[
          const SizedBox(height: AppTheme.spacing4),
          Text(
            hasError ? widget.errorText! : widget.helperText!,
            style: AppTheme.body12.copyWith(
              color: hasError ? AppColors.error : AppColors.neutral50,
            ),
          ),
        ],
      ],
    );
  }
}

/// 搜索框组件
class ModernSearchBar extends StatefulWidget {
  final String? hint;
  final TextEditingController? controller;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onSubmitted;
  final VoidCallback? onClear;
  final bool autofocus;
  final bool showCancelButton;

  const ModernSearchBar({
    super.key,
    this.hint,
    this.controller,
    this.onChanged,
    this.onSubmitted,
    this.onClear,
    this.autofocus = false,
    this.showCancelButton = false,
  });

  @override
  State<ModernSearchBar> createState() => _ModernSearchBarState();
}

class _ModernSearchBarState extends State<ModernSearchBar> {
  late TextEditingController _controller;
  bool _hasText = false;

  @override
  void initState() {
    super.initState();
    _controller = widget.controller ?? TextEditingController();
    _controller.addListener(_handleTextChange);
  }

  @override
  void dispose() {
    if (widget.controller == null) {
      _controller.dispose();
    }
    super.dispose();
  }

  void _handleTextChange() {
    setState(() {
      _hasText = _controller.text.isNotEmpty;
    });
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Row(
      children: [
        Expanded(
          child: Container(
            height: 48,
            decoration: BoxDecoration(
              color: isDark ? AppColors.neutral80 : AppColors.neutral10,
              borderRadius: BorderRadius.circular(AppTheme.radiusFull),
            ),
            child: Row(
              children: [
                const SizedBox(width: AppTheme.spacing16),
                Icon(
                  Icons.search_rounded,
                  color: AppColors.neutral50,
                  size: 22,
                ),
                const SizedBox(width: AppTheme.spacing12),
                Expanded(
                  child: TextField(
                    controller: _controller,
                    autofocus: widget.autofocus,
                    onChanged: widget.onChanged,
                    onSubmitted: widget.onSubmitted,
                    style: AppTheme.body16.copyWith(
                      color: isDark ? AppColors.neutral10 : AppColors.neutral90,
                    ),
                    decoration: InputDecoration(
                      hintText: widget.hint ?? '搜索...',
                      hintStyle: AppTheme.body16.copyWith(
                        color: AppColors.neutral40,
                      ),
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.zero,
                    ),
                  ),
                ),
                if (_hasText)
                  GestureDetector(
                    onTap: () {
                      _controller.clear();
                      widget.onClear?.call();
                    },
                    child: Container(
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        color: AppColors.neutral40,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.close_rounded,
                        size: 14,
                        color: isDark ? AppColors.neutral90 : Colors.white,
                      ),
                    ),
                  ),
                const SizedBox(width: AppTheme.spacing16),
              ],
            ),
          ),
        ),
        if (widget.showCancelButton) ...[
          const SizedBox(width: AppTheme.spacing12),
          GestureDetector(
            onTap: () {
              _controller.clear();
              FocusScope.of(context).unfocus();
            },
            child: Text(
              '取消',
              style: AppTheme.buttonMedium.copyWith(
                color: AppColors.accent,
              ),
            ),
          ),
        ],
      ],
    );
  }
}
