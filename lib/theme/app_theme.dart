import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart';

/// 2025年现代化主题系统
/// 采用更现代的字体组合和间距系统
class AppTheme {
  AppTheme._();

  // ============ 字体系统 ============
  // 使用 Inter 作为主要字体，更现代清晰
  static String? _fontFamily;
  static String get fontFamily => _fontFamily ?? 'Inter';
  
  static TextStyle _baseStyle({
    double fontSize = 14,
    FontWeight fontWeight = FontWeight.w400,
    double? height,
    double? letterSpacing,
    Color? color,
  }) {
    return GoogleFonts.inter(
      fontSize: fontSize,
      fontWeight: fontWeight,
      height: height,
      letterSpacing: letterSpacing,
      color: color,
    );
  }

  // ============ 显示标题 - 用于大型Banner ============
  static final display1 = _baseStyle(
    fontSize: 48,
    fontWeight: FontWeight.w700,
    height: 1.1,
    letterSpacing: -1.5,
  );

  static final display2 = _baseStyle(
    fontSize: 40,
    fontWeight: FontWeight.w700,
    height: 1.15,
    letterSpacing: -1.2,
  );

  // ============ 标题样式 ============
  static final title32 = _baseStyle(
    fontSize: 32,
    fontWeight: FontWeight.w700,
    height: 1.2,
    letterSpacing: -0.8,
  );

  static final title28 = _baseStyle(
    fontSize: 28,
    fontWeight: FontWeight.w700,
    height: 1.25,
    letterSpacing: -0.5,
  );

  static final title24 = _baseStyle(
    fontSize: 24,
    fontWeight: FontWeight.w700,
    height: 1.3,
    letterSpacing: -0.3,
  );

  static final title20 = _baseStyle(
    fontSize: 20,
    fontWeight: FontWeight.w600,
    height: 1.35,
  );

  static final title18 = _baseStyle(
    fontSize: 18,
    fontWeight: FontWeight.w600,
    height: 1.4,
  );

  static final title16 = _baseStyle(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    height: 1.4,
  );

  static final title14 = _baseStyle(
    fontSize: 14,
    fontWeight: FontWeight.w600,
    height: 1.45,
  );

  static final title12 = _baseStyle(
    fontSize: 12,
    fontWeight: FontWeight.w600,
    height: 1.5,
  );

  static final title10 = _baseStyle(
    fontSize: 10,
    fontWeight: FontWeight.w600,
    height: 1.5,
  );

  // ============ 副标题样式 ============
  static final subtitle16 = _baseStyle(
    fontSize: 16,
    fontWeight: FontWeight.w500,
    height: 1.5,
  );

  static final subtitle14 = _baseStyle(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    height: 1.5,
  );

  static final subtitle12 = _baseStyle(
    fontSize: 12,
    fontWeight: FontWeight.w500,
    height: 1.5,
  );

  // ============ 标签样式 ============
  static final label16 = _baseStyle(
    fontSize: 16,
    fontWeight: FontWeight.w500,
    height: 1.5,
    letterSpacing: 0.1,
  );

  static final label14 = _baseStyle(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    height: 1.5,
    letterSpacing: 0.1,
  );

  static final label12 = _baseStyle(
    fontSize: 12,
    fontWeight: FontWeight.w500,
    height: 1.5,
    letterSpacing: 0.2,
  );

  static final labelSmall = _baseStyle(
    fontSize: 10,
    fontWeight: FontWeight.w500,
    height: 1.5,
    letterSpacing: 0.3,
  );

  // ============ 正文样式 ============
  static final body16 = _baseStyle(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    height: 1.6,
  );

  static final body14 = _baseStyle(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    height: 1.6,
  );

  static final body12 = _baseStyle(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    height: 1.6,
  );

  // ============ 价格样式 ============
  static final priceDisplay = _baseStyle(
    fontSize: 28,
    fontWeight: FontWeight.w700,
    height: 1.2,
    letterSpacing: -0.5,
  );

  static final priceLarge = _baseStyle(
    fontSize: 22,
    fontWeight: FontWeight.w700,
    height: 1.2,
  );

  static final priceMedium = _baseStyle(
    fontSize: 18,
    fontWeight: FontWeight.w700,
    height: 1.2,
  );

  static final priceSmall = _baseStyle(
    fontSize: 14,
    fontWeight: FontWeight.w600,
    height: 1.2,
  );

  // ============ 按钮样式 ============
  static final buttonLarge = _baseStyle(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    height: 1.25,
  );

  static final buttonMedium = _baseStyle(
    fontSize: 14,
    fontWeight: FontWeight.w600,
    height: 1.25,
  );

  static final buttonSmall = _baseStyle(
    fontSize: 12,
    fontWeight: FontWeight.w600,
    height: 1.25,
  );

  // ============ 间距系统 ============
  static const spacing4 = 4.0;
  static const spacing8 = 8.0;
  static const spacing12 = 12.0;
  static const spacing16 = 16.0;
  static const spacing20 = 20.0;
  static const spacing24 = 24.0;
  static const spacing32 = 32.0;
  static const spacing40 = 40.0;
  static const spacing48 = 48.0;
  static const spacing56 = 56.0;
  static const spacing64 = 64.0;

  // ============ 圆角系统 ============
  static const radiusXS = 4.0;
  static const radiusSM = 8.0;
  static const radiusMD = 12.0;
  static const radiusLG = 16.0;
  static const radiusXL = 20.0;
  static const radius2XL = 24.0;
  static const radius3XL = 32.0;
  static const radiusFull = 999.0;

  // ============ 阴影系统 ============
  static List<BoxShadow> get shadowSM => [
    BoxShadow(
      color: AppColors.cardShadow,
      blurRadius: 4,
      offset: const Offset(0, 1),
    ),
  ];

  static List<BoxShadow> get shadowMD => [
    BoxShadow(
      color: AppColors.cardShadow,
      blurRadius: 8,
      offset: const Offset(0, 2),
    ),
  ];

  static List<BoxShadow> get shadowLG => [
    BoxShadow(
      color: AppColors.cardShadow,
      blurRadius: 16,
      offset: const Offset(0, 4),
    ),
  ];

  static List<BoxShadow> get shadowXL => [
    BoxShadow(
      color: AppColors.cardShadow.withValues(alpha: 0.15),
      blurRadius: 24,
      offset: const Offset(0, 8),
    ),
  ];

  // ============ 动画时长 ============
  static const durationFast = Duration(milliseconds: 150);
  static const durationNormal = Duration(milliseconds: 250);
  static const durationSlow = Duration(milliseconds: 350);
  static const durationSlower = Duration(milliseconds: 500);
  
  // ============ 动画曲线 ============
  static const curveStandard = Curves.easeInOutCubic;
  static const curveDecelerate = Curves.decelerate;
  static const curveAccelerate = Curves.easeIn;
  static const curveElastic = Curves.elasticOut;
}
