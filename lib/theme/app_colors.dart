import 'package:flutter/material.dart';

/// 2025年现代民宿App配色系统
/// 采用温暖自然的配色，突出舒适感和高端感
class AppColors {
  AppColors._();

  // ============ 主色调 - 温暖棕褐色系 ============
  // 体现民宿的自然、温馨氛围
  static const primary10 = Color(0xFFFAF7F5);
  static const primary20 = Color(0xFFF5EEE8);
  static const primary30 = Color(0xFFE8DED4);
  static const primary40 = Color(0xFFD4C4B4);
  static const primary50 = Color(0xFFB8A089);
  static const primary60 = Color(0xFF9C8570);
  static const primary70 = Color(0xFF7D6B5A);
  static const primary80 = Color(0xFF5E5144);
  static const primary = Color(0xFF3D352E);  // 主色调
  static const primary100 = Color(0xFF1E1A17);
  
  // ============ 强调色 - 珊瑚橙 ============
  // 用于CTA按钮和重要操作
  static const accent10 = Color(0xFFFFF4F2);
  static const accent20 = Color(0xFFFFE4DE);
  static const accent30 = Color(0xFFFFCDC2);
  static const accent40 = Color(0xFFFFB5A5);
  static const accent50 = Color(0xFFFF9D87);
  static const accent = Color(0xFFFF6B47);  // 强调色
  static const accent70 = Color(0xFFE55A3A);
  static const accent80 = Color(0xFFCC4A2E);
  static const accent90 = Color(0xFFB33A22);
  static const accent100 = Color(0xFF992916);

  // ============ 成功色 - 薄荷绿 ============
  static const success10 = Color(0xFFECFDF5);
  static const success20 = Color(0xFFD1FAE5);
  static const success30 = Color(0xFFA7F3D0);
  static const success = Color(0xFF10B981);
  static const success70 = Color(0xFF059669);
  static const success100 = Color(0xFF064E3B);

  // ============ 警告色 - 琥珀黄 ============
  static const warning10 = Color(0xFFFFFBEB);
  static const warning20 = Color(0xFFFEF3C7);
  static const warning30 = Color(0xFFFDE68A);
  static const warning = Color(0xFFF59E0B);
  static const warning70 = Color(0xFFD97706);
  static const warning100 = Color(0xFF78350F);

  // ============ 错误色 - 玫瑰红 ============
  static const error10 = Color(0xFFFFF1F2);
  static const error20 = Color(0xFFFFE4E6);
  static const error30 = Color(0xFFFECDD3);
  static const error = Color(0xFFF43F5E);
  static const error70 = Color(0xFFE11D48);
  static const error100 = Color(0xFF881337);

  // ============ 中性色 - 石墨灰 ============
  static const neutral0 = Color(0xFFFFFFFF);
  static const neutral5 = Color(0xFFFAFAFA);
  static const neutral10 = Color(0xFFF5F5F5);
  static const neutral20 = Color(0xFFE5E5E5);
  static const neutral30 = Color(0xFFD4D4D4);
  static const neutral40 = Color(0xFFA3A3A3);
  static const neutral50 = Color(0xFF737373);
  static const neutral60 = Color(0xFF525252);
  static const neutral70 = Color(0xFF404040);
  static const neutral80 = Color(0xFF262626);
  static const neutral90 = Color(0xFF171717);
  static const neutral100 = Color(0xFF0A0A0A);

  // ============ 渐变色 ============
  static const gradientStart = Color(0xFFFF6B47);
  static const gradientEnd = Color(0xFFFF9D87);
  
  static const LinearGradient primaryGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [gradientStart, gradientEnd],
  );

  static const LinearGradient darkGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [Color(0x00000000), Color(0xCC000000)],
  );

  // ============ 特殊用途 ============
  static const premiumGold = Color(0xFFD4AF37);
  static const premiumBackground = Color(0xFF1A1A1A);
  static const cardShadow = Color(0x0A000000);
  static const overlay = Color(0x33000000);

  // ============ 向后兼容的旧色值映射 ============
  static const blueberry10 = Color(0xFFFFF5F0); // 浅橙色背景
  static const blueberry20 = Color(0xFFFFE4D6);
  static const blueberry40 = Color(0xFFFFB899);
  static const blueberry80 = accent;
  static const blueberry100 = accent70;
  static const watermelon10 = Color(0xFFE8F5E8);
  static const watermelon40 = Color(0xFF81C784);
  static const watermelon80 = success;
  static const watermelon100 = success70;
  static const rambutan10 = Color(0xFFFEF0F0);
  static const rambutan40 = Color(0xFFF48FB1);
  static const rambutan80 = error;
  static const rambutan100 = error70;
  static const cempedak10 = Color(0xFFFFF8E8);
  static const cempedak40 = Color(0xFFFFD54F);
  static const cempedak60 = Color(0xFFFFC107);
  static const cempedak80 = warning;
  static const cempedak100 = warning70;
  
  static const mono0 = neutral0;
  static const mono10 = neutral10;
  static const mono20 = neutral20;
  static const mono40 = neutral40;
  static const mono60 = neutral50;
  static const mono80 = neutral60;
  static const mono90 = neutral70;
  static const mono100 = neutral90;
  static const whiteBg = primary10;
  
  static const gradient0 = Color(0x00000000);
  static const gradient10 = Color(0x1A000000);
  static const gradient20 = Color(0x33000000);
  static const gradient40 = Color(0x66000000);
  static const gradient60 = Color(0x99000000);
  static const gradient80 = Color(0xCC000000);
  static const gradient100 = Color(0xFF000000);
}
