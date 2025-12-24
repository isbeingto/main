import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import '../../theme/app_colors.dart';
import 'loading_skeleton.dart';

/// Unified network image widget with loading and error states
class AppNetworkImage extends StatelessWidget {
  final String? imageUrl;
  final double? width;
  final double? height;
  final BoxFit fit;
  final BorderRadius? borderRadius;

  const AppNetworkImage({
    super.key,
    required this.imageUrl,
    this.width,
    this.height,
    this.fit = BoxFit.cover,
    this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    if (imageUrl == null || imageUrl!.isEmpty) {
      return _buildPlaceholder();
    }

    return ClipRRect(
      borderRadius: borderRadius ?? BorderRadius.zero,
      child: CachedNetworkImage(
        imageUrl: imageUrl!,
        width: width,
        height: height,
        fit: fit,
        placeholder: (context, url) => _buildPlaceholder(),
        errorWidget: (context, url, error) => _buildError(),
        fadeInDuration: const Duration(milliseconds: 300),
        fadeOutDuration: const Duration(milliseconds: 100),
      ),
    );
  }

  Widget _buildPlaceholder() {
    return Container(
      width: width,
      height: height,
      color: AppColors.mono20,
      child: Icon(
        Icons.image_outlined,
        size: (width != null && height != null) ? (width! < height! ? width! : height!) * 0.4 : 40,
        color: AppColors.mono60,
      ),
    );
  }

  Widget _buildError() {
    return Container(
      width: width,
      height: height,
      color: AppColors.mono20,
      child: Icon(
        Icons.broken_image_outlined,
        size: (width != null && height != null) ? (width! < height! ? width! : height!) * 0.4 : 40,
        color: AppColors.mono60,
      ),
    );
  }
}

/// Avatar image with circular shape
class AppAvatar extends StatelessWidget {
  final String? imageUrl;
  final double size;
  final String? fallbackText;

  const AppAvatar({
    super.key,
    required this.imageUrl,
    this.size = 40,
    this.fallbackText,
  });

  @override
  Widget build(BuildContext context) {
    if (imageUrl == null || imageUrl!.isEmpty) {
      return _buildFallback(context);
    }

    return ClipOval(
      child: CachedNetworkImage(
        imageUrl: imageUrl!,
        width: size,
        height: size,
        fit: BoxFit.cover,
        placeholder: (context, url) => _buildPlaceholder(),
        errorWidget: (context, url, error) => _buildFallback(context),
        fadeInDuration: const Duration(milliseconds: 300),
      ),
    );
  }

  Widget _buildPlaceholder() {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: AppColors.mono20,
        shape: BoxShape.circle,
      ),
      child: Icon(
        Icons.person_outline,
        size: size * 0.5,
        color: AppColors.mono60,
      ),
    );
  }

  Widget _buildFallback(BuildContext context) {
    if (fallbackText != null && fallbackText!.isNotEmpty) {
      return Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          color: AppColors.blueberry80,
          shape: BoxShape.circle,
        ),
        child: Center(
          child: Text(
            fallbackText![0].toUpperCase(),
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  color: AppColors.mono0,
                  fontWeight: FontWeight.w600,
                ),
          ),
        ),
      );
    }

    return _buildPlaceholder();
  }
}

/// Hero image with shimmer loading
class HeroImage extends StatelessWidget {
  final String? imageUrl;
  final double height;

  const HeroImage({
    super.key,
    required this.imageUrl,
    this.height = 250,
  });

  @override
  Widget build(BuildContext context) {
    if (imageUrl == null || imageUrl!.isEmpty) {
      return Container(
        width: double.infinity,
        height: height,
        color: AppColors.mono20,
        child: Icon(
          Icons.image_outlined,
          size: 80,
          color: AppColors.mono60,
        ),
      );
    }

    return CachedNetworkImage(
      imageUrl: imageUrl!,
      width: double.infinity,
      height: height,
      fit: BoxFit.cover,
      placeholder: (context, url) => LoadingSkeleton(
        width: double.infinity,
        height: height,
        borderRadius: BorderRadius.zero,
      ),
      errorWidget: (context, url, error) => Container(
        width: double.infinity,
        height: height,
        color: AppColors.mono20,
        child: Icon(
          Icons.broken_image_outlined,
          size: 80,
          color: AppColors.mono60,
        ),
      ),
      fadeInDuration: const Duration(milliseconds: 500),
    );
  }
}
