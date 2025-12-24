import 'package:flutter/material.dart';

import '/theme/app_colors.dart';
import '/theme/app_theme.dart';

/// 2025年风格的文本输入框
class CommonTextFormField extends StatefulWidget {
  final String label;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final String? errorText;
  final bool isPassword;
  final TextInputType? keyboardType;
  final String? hintText;

  const CommonTextFormField({
    super.key,
    required this.label,
    this.controller,
    this.validator,
    this.errorText,
    this.isPassword = false,
    this.keyboardType,
    this.hintText,
  });

  @override
  State<CommonTextFormField> createState() => _CommonTextFormFieldState();
}

class _CommonTextFormFieldState extends State<CommonTextFormField>
    with SingleTickerProviderStateMixin {
  bool _isObscure = false;
  String? _errorText;
  final FocusNode _focus = FocusNode();
  late AnimationController _animController;
  late Animation<double> _borderAnimation;

  @override
  void initState() {
    super.initState();
    _isObscure = widget.isPassword;
    _focus.addListener(_onFocusChange);
    _animController = AnimationController(
      duration: AppTheme.durationFast,
      vsync: this,
    );
    _borderAnimation = Tween<double>(begin: 1.0, end: 2.0).animate(
      CurvedAnimation(parent: _animController, curve: Curves.easeOut),
    );
  }

  @override
  void dispose() {
    _focus.removeListener(_onFocusChange);
    _focus.dispose();
    _animController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final hasError = (widget.errorText ?? _errorText) != null;
    
    return AnimatedBuilder(
      animation: _animController,
      builder: (context, child) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 标签
            Text(
              widget.label,
              style: AppTheme.label14.copyWith(
                color: hasError 
                    ? AppColors.error 
                    : (_focus.hasFocus 
                        ? AppColors.accent 
                        : AppColors.neutral50),
              ),
            ),
            const SizedBox(height: AppTheme.spacing8),
            // 输入框
            Container(
              decoration: BoxDecoration(
                color: isDark ? AppColors.neutral80 : AppColors.neutral5,
                borderRadius: BorderRadius.circular(AppTheme.radiusMD),
                border: Border.all(
                  color: hasError
                      ? AppColors.error
                      : (_focus.hasFocus
                          ? AppColors.accent
                          : Colors.transparent),
                  width: _borderAnimation.value,
                ),
              ),
              child: TextFormField(
                controller: widget.controller,
                validator: widget.validator,
                obscureText: _isObscure,
                focusNode: _focus,
                keyboardType: widget.keyboardType,
                style: AppTheme.body16.copyWith(
                  color: isDark ? AppColors.neutral10 : AppColors.neutral90,
                ),
                cursorColor: AppColors.accent,
                decoration: InputDecoration(
                  hintText: widget.hintText ?? '请输入${widget.label}',
                  hintStyle: AppTheme.body16.copyWith(color: AppColors.neutral40),
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: AppTheme.spacing16,
                    vertical: AppTheme.spacing16,
                  ),
                  suffixIcon: widget.isPassword
                      ? IconButton(
                          icon: Icon(
                            _isObscure
                                ? Icons.visibility_outlined
                                : Icons.visibility_off_outlined,
                            color: AppColors.neutral50,
                            size: 22,
                          ),
                          onPressed: () {
                            setState(() {
                              _isObscure = !_isObscure;
                            });
                          },
                        )
                      : null,
                ),
                onChanged: (value) {
                  final error = widget.validator?.call(widget.controller?.text);
                  if (error == null && _errorText != null) {
                    setState(() {
                      _errorText = null;
                    });
                  }
                },
              ),
            ),
            // 错误提示
            if (hasError)
              Padding(
                padding: const EdgeInsets.only(top: AppTheme.spacing4, left: AppTheme.spacing4),
                child: Row(
                  children: [
                    Icon(Icons.error_outline_rounded, size: 14, color: AppColors.error),
                    const SizedBox(width: 4),
                    Expanded(
                      child: Text(
                        widget.errorText ?? _errorText ?? '',
                        style: AppTheme.label12.copyWith(color: AppColors.error),
                      ),
                    ),
                  ],
                ),
              ),
          ],
        );
      },
    );
  }

  void _onFocusChange() {
    if (_focus.hasFocus) {
      _animController.forward();
    } else {
      _animController.reverse();
      setState(() {
        _errorText = widget.validator?.call(widget.controller?.text);
      });
    }
    setState(() {});
  }
}
