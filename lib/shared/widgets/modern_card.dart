import 'package:flutter/material.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_theme.dart';

/// 2025年风格的现代卡片组件
/// 特点：无边框、柔和阴影、大圆角、玻璃质感
class ModernCard extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final VoidCallback? onTap;
  final Color? backgroundColor;
  final double? borderRadius;
  final bool enableHover;
  final bool glassmorphism;

  const ModernCard({
    super.key,
    required this.child,
    this.padding,
    this.margin,
    this.onTap,
    this.backgroundColor,
    this.borderRadius,
    this.enableHover = true,
    this.glassmorphism = false,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final bgColor = backgroundColor ?? 
        (isDark ? AppColors.neutral80 : AppColors.neutral0);
    
    Widget card = AnimatedContainer(
      duration: AppTheme.durationFast,
      margin: margin ?? const EdgeInsets.only(bottom: AppTheme.spacing16),
      decoration: BoxDecoration(
        color: glassmorphism ? bgColor.withValues(alpha: 0.8) : bgColor,
        borderRadius: BorderRadius.circular(borderRadius ?? AppTheme.radiusXL),
        boxShadow: glassmorphism ? null : AppTheme.shadowMD,
        border: glassmorphism
            ? Border.all(
                color: (isDark ? Colors.white : Colors.black).withValues(alpha: 0.1),
                width: 1,
              )
            : null,
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(borderRadius ?? AppTheme.radiusXL),
        child: Padding(
          padding: padding ?? const EdgeInsets.all(AppTheme.spacing16),
          child: child,
        ),
      ),
    );

    if (onTap != null) {
      return GestureDetector(
        onTap: onTap,
        child: card,
      );
    }

    return card;
  }
}

/// 房源卡片 - Airbnb风格
class ListingCard extends StatelessWidget {
  final String? imageUrl;
  final String title;
  final String? location;
  final String? price;
  final String? priceUnit;
  final double? rating;
  final int? reviewCount;
  final List<String>? tags;
  final VoidCallback? onTap;
  final VoidCallback? onFavorite;
  final bool isFavorite;
  final Widget? badge;

  const ListingCard({
    super.key,
    this.imageUrl,
    required this.title,
    this.location,
    this.price,
    this.priceUnit,
    this.rating,
    this.reviewCount,
    this.tags,
    this.onTap,
    this.onFavorite,
    this.isFavorite = false,
    this.badge,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: AppTheme.spacing20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 图片区域
            _buildImageSection(context),
            const SizedBox(height: AppTheme.spacing12),
            // 信息区域
            _buildInfoSection(context),
          ],
        ),
      ),
    );
  }

  Widget _buildImageSection(BuildContext context) {
    return Stack(
      children: [
        // 图片
        AspectRatio(
          aspectRatio: 4 / 3,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(AppTheme.radiusXL),
              color: AppColors.neutral20,
            ),
            clipBehavior: Clip.antiAlias,
            child: imageUrl != null
                ? Image.network(
                    imageUrl!,
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) => _buildPlaceholder(),
                  )
                : _buildPlaceholder(),
          ),
        ),
        // 收藏按钮
        if (onFavorite != null)
          Positioned(
            top: AppTheme.spacing12,
            right: AppTheme.spacing12,
            child: _FavoriteButton(
              isFavorite: isFavorite,
              onTap: onFavorite!,
            ),
          ),
        // 标签
        if (badge != null)
          Positioned(
            top: AppTheme.spacing12,
            left: AppTheme.spacing12,
            child: badge!,
          ),
      ],
    );
  }

  Widget _buildPlaceholder() {
    return Container(
      color: AppColors.neutral10,
      child: Center(
        child: Icon(
          Icons.home_rounded,
          size: 48,
          color: AppColors.neutral30,
        ),
      ),
    );
  }

  Widget _buildInfoSection(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppTheme.spacing4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 评分和位置行
          Row(
            children: [
              if (rating != null) ...[
                Icon(
                  Icons.star_rounded,
                  size: 16,
                  color: AppColors.neutral90,
                ),
                const SizedBox(width: 4),
                Text(
                  rating!.toStringAsFixed(1),
                  style: AppTheme.subtitle14.copyWith(
                    color: AppColors.neutral90,
                  ),
                ),
                if (reviewCount != null) ...[
                  Text(
                    ' ($reviewCount)',
                    style: AppTheme.body14.copyWith(
                      color: AppColors.neutral50,
                    ),
                  ),
                ],
                const Spacer(),
              ],
            ],
          ),
          const SizedBox(height: AppTheme.spacing4),
          // 标题
          Text(
            title,
            style: AppTheme.title16.copyWith(
              color: AppColors.neutral90,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          // 位置
          if (location != null) ...[
            const SizedBox(height: AppTheme.spacing4),
            Text(
              location!,
              style: AppTheme.body14.copyWith(
                color: AppColors.neutral50,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
          // 价格
          if (price != null) ...[
            const SizedBox(height: AppTheme.spacing8),
            RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: '¥$price',
                    style: AppTheme.priceMedium.copyWith(
                      color: AppColors.neutral90,
                    ),
                  ),
                  if (priceUnit != null)
                    TextSpan(
                      text: ' $priceUnit',
                      style: AppTheme.body14.copyWith(
                        color: AppColors.neutral50,
                      ),
                    ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }
}

/// 收藏按钮
class _FavoriteButton extends StatelessWidget {
  final bool isFavorite;
  final VoidCallback onTap;

  const _FavoriteButton({
    required this.isFavorite,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 36,
        height: 36,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white.withValues(alpha: 0.9),
          boxShadow: AppTheme.shadowSM,
        ),
        child: Icon(
          isFavorite ? Icons.favorite_rounded : Icons.favorite_border_rounded,
          size: 20,
          color: isFavorite ? AppColors.error : AppColors.neutral60,
        ),
      ),
    );
  }
}

/// 标签徽章
class ModernBadge extends StatelessWidget {
  final String text;
  final Color? backgroundColor;
  final Color? textColor;
  final IconData? icon;
  final bool outlined;

  const ModernBadge({
    super.key,
    required this.text,
    this.backgroundColor,
    this.textColor,
    this.icon,
    this.outlined = false,
  });

  factory ModernBadge.highlight(String text) {
    return ModernBadge(
      text: text,
      backgroundColor: AppColors.accent,
      textColor: Colors.white,
    );
  }

  factory ModernBadge.subtle(String text) {
    return ModernBadge(
      text: text,
      backgroundColor: AppColors.neutral10,
      textColor: AppColors.neutral70,
    );
  }

  @override
  Widget build(BuildContext context) {
    final bgColor = backgroundColor ?? AppColors.neutral10;
    final fgColor = textColor ?? AppColors.neutral70;

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppTheme.spacing12,
        vertical: AppTheme.spacing4,
      ),
      decoration: BoxDecoration(
        color: outlined ? Colors.transparent : bgColor,
        borderRadius: BorderRadius.circular(AppTheme.radiusFull),
        border: outlined ? Border.all(color: bgColor, width: 1.5) : null,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) ...[
            Icon(icon, size: 14, color: fgColor),
            const SizedBox(width: 4),
          ],
          Text(
            text,
            style: AppTheme.label12.copyWith(color: fgColor),
          ),
        ],
      ),
    );
  }
}
