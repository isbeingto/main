import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:shimmer/shimmer.dart';

import '../../../generated/locale_keys.g.dart';
import '../../../routing/routes.dart';
import '../../../shared/widgets/modern_input.dart';
import '../../../theme/app_colors.dart';
import '../../../theme/app_theme.dart';
import '../model/listing.dart';
import '../view_model/listings_view_model.dart';

/// 2025年风格的房源列表页面
/// Airbnb风格：大图卡片、无边框设计、沉浸式体验
class ListingsScreen extends ConsumerStatefulWidget {
  const ListingsScreen({super.key});

  @override
  ConsumerState<ListingsScreen> createState() => _ListingsScreenState();
}

class _ListingsScreenState extends ConsumerState<ListingsScreen> {
  final _searchController = TextEditingController();
  final _scrollController = ScrollController();
  bool _isSearching = false;
  int _selectedFilterIndex = 0;

  @override
  void dispose() {
    _searchController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final listingsAsync = ref.watch(listingsViewModelProvider);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? AppColors.neutral90 : AppColors.neutral0,
      body: CustomScrollView(
        controller: _scrollController,
        physics: const BouncingScrollPhysics(),
        slivers: [
          // 现代化顶部导航
          _buildSliverAppBar(context, isDark),
          // 筛选栏
          _buildFilterBar(context, isDark),
          // 房源列表
          listingsAsync.when(
            data: (listings) => _buildListingsGrid(listings, isDark),
            loading: () => const SliverToBoxAdapter(
              child: _ModernLoadingSkeleton(),
            ),
            error: (error, stack) => SliverToBoxAdapter(
              child: _buildErrorState(context, isDark),
            ),
          ),
          // 底部安全区
          SliverToBoxAdapter(
            child: SizedBox(height: MediaQuery.of(context).padding.bottom + 100),
          ),
        ],
      ),
    );
  }

  Widget _buildSliverAppBar(BuildContext context, bool isDark) {
    return SliverAppBar(
      floating: true,
      snap: true,
      backgroundColor: isDark ? AppColors.neutral90 : AppColors.neutral0,
      surfaceTintColor: Colors.transparent,
      elevation: 0,
      toolbarHeight: 80,
      flexibleSpace: FlexibleSpaceBar(
        background: SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(
              AppTheme.spacing20, 
              AppTheme.spacing12, 
              AppTheme.spacing20, 
              AppTheme.spacing8,
            ),
            child: _isSearching
                ? ModernSearchBar(
                    controller: _searchController,
                    hint: LocaleKeys.listings.tr(),
                    showCancelButton: true,
                    autofocus: true,
                    onChanged: (value) {
                      // TODO: 实现搜索逻辑
                    },
                  )
                : Row(
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            setState(() => _isSearching = true);
                          },
                          child: Container(
                            height: 52,
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            decoration: BoxDecoration(
                              color: isDark ? AppColors.neutral80 : AppColors.neutral5,
                              borderRadius: BorderRadius.circular(AppTheme.radiusFull),
                              border: Border.all(
                                color: isDark ? AppColors.neutral70 : AppColors.neutral20,
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withValues(alpha: 0.04),
                                  blurRadius: 8,
                                  offset: const Offset(0, 2),
                                ),
                              ],
                            ),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.search_rounded,
                                  color: AppColors.neutral50,
                                  size: 22,
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        '搜索民宿',
                                        style: AppTheme.subtitle14.copyWith(
                                          color: isDark ? AppColors.neutral20 : AppColors.neutral90,
                                        ),
                                      ),
                                      Text(
                                        '任意地点 · 任意时间',
                                        style: AppTheme.body12.copyWith(
                                          color: AppColors.neutral50,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  width: 36,
                                  height: 36,
                                  decoration: BoxDecoration(
                                    border: Border.all(color: AppColors.neutral30),
                                    borderRadius: BorderRadius.circular(AppTheme.radiusFull),
                                  ),
                                  child: Icon(
                                    Icons.tune_rounded,
                                    size: 18,
                                    color: isDark ? AppColors.neutral30 : AppColors.neutral70,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
          ),
        ),
      ),
    );
  }

  Widget _buildFilterBar(BuildContext context, bool isDark) {
    final filters = ['全部', '整套房源', '独立房间', '超赞房东', '最近添加'];
    
    return SliverToBoxAdapter(
      child: Container(
        height: 48,
        margin: const EdgeInsets.only(bottom: AppTheme.spacing8),
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.symmetric(horizontal: AppTheme.spacing20),
          itemCount: filters.length,
          separatorBuilder: (_, __) => const SizedBox(width: 8),
          itemBuilder: (context, index) {
            final isSelected = index == _selectedFilterIndex;
            return GestureDetector(
              onTap: () {
                HapticFeedback.selectionClick();
                setState(() {
                  _selectedFilterIndex = index;
                });
                // TODO: 实现筛选逻辑
              },
              child: AnimatedContainer(
                duration: AppTheme.durationFast,
                padding: const EdgeInsets.symmetric(
                  horizontal: AppTheme.spacing16,
                  vertical: AppTheme.spacing8,
                ),
                decoration: BoxDecoration(
                  color: isSelected 
                      ? (isDark ? AppColors.neutral0 : AppColors.neutral90)
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(AppTheme.radiusFull),
                  border: Border.all(
                    color: isSelected 
                        ? Colors.transparent
                        : (isDark ? AppColors.neutral60 : AppColors.neutral30),
                  ),
                ),
                child: Center(
                  child: Text(
                    filters[index],
                    style: AppTheme.label14.copyWith(
                      color: isSelected
                          ? (isDark ? AppColors.neutral90 : AppColors.neutral0)
                          : (isDark ? AppColors.neutral30 : AppColors.neutral70),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildListingsGrid(List<Listing> listings, bool isDark) {
    if (listings.isEmpty) {
      return SliverFillRemaining(
        hasScrollBody: false,
        child: _buildEmptyState(isDark),
      );
    }

    return SliverPadding(
      padding: const EdgeInsets.symmetric(horizontal: AppTheme.spacing20),
      sliver: SliverList(
        delegate: SliverChildBuilderDelegate(
          (context, index) {
            return _ModernListingCard(
              listing: listings[index],
              onTap: () => context.push(Routes.lodgingDetailPath(listings[index].id)),
            );
          },
          childCount: listings.length,
        ),
      ),
    );
  }

  Widget _buildEmptyState(bool isDark) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppTheme.spacing32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                color: AppColors.neutral10,
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.home_work_outlined,
                size: 36,
                color: AppColors.neutral40,
              ),
            ),
            const SizedBox(height: AppTheme.spacing24),
            Text(
              '暂无房源',
              style: AppTheme.title20.copyWith(
                color: isDark ? AppColors.neutral20 : AppColors.neutral80,
              ),
            ),
            const SizedBox(height: AppTheme.spacing8),
            Text(
              '请稍后再来查看',
              style: AppTheme.body14.copyWith(
                color: AppColors.neutral50,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildErrorState(BuildContext context, bool isDark) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppTheme.spacing32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                color: AppColors.error10,
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.wifi_off_rounded,
                size: 36,
                color: AppColors.error,
              ),
            ),
            const SizedBox(height: AppTheme.spacing24),
            Text(
              '加载失败',
              style: AppTheme.title20.copyWith(
                color: isDark ? AppColors.neutral20 : AppColors.neutral80,
              ),
            ),
            const SizedBox(height: AppTheme.spacing8),
            Text(
              '请检查网络连接后重试',
              style: AppTheme.body14.copyWith(
                color: AppColors.neutral50,
              ),
            ),
            const SizedBox(height: AppTheme.spacing24),
            GestureDetector(
              onTap: () => ref.read(listingsViewModelProvider.notifier).refresh(),
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppTheme.spacing24,
                  vertical: AppTheme.spacing12,
                ),
                decoration: BoxDecoration(
                  color: AppColors.accent,
                  borderRadius: BorderRadius.circular(AppTheme.radiusFull),
                ),
                child: Text(
                  '重试',
                  style: AppTheme.buttonMedium.copyWith(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// 现代化房源卡片
class _ModernListingCard extends StatelessWidget {
  final Listing listing;
  final VoidCallback? onTap;

  const _ModernListingCard({
    required this.listing,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final photoUrl = listing.photos.isNotEmpty ? listing.photos.first.photoUrl : null;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: AppTheme.spacing24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 图片区域
            Stack(
              children: [
                AspectRatio(
                  aspectRatio: 4 / 3,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(AppTheme.radiusXL),
                      color: AppColors.neutral20,
                    ),
                    clipBehavior: Clip.antiAlias,
                    child: photoUrl != null
                        ? CachedNetworkImage(
                            imageUrl: photoUrl,
                            fit: BoxFit.cover,
                            placeholder: (context, url) => _buildImagePlaceholder(),
                            errorWidget: (context, url, error) => _buildImagePlaceholder(),
                          )
                        : _buildImagePlaceholder(),
                  ),
                ),
                // 收藏按钮
                Positioned(
                  top: AppTheme.spacing12,
                  right: AppTheme.spacing12,
                  child: Container(
                    width: 36,
                    height: 36,
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.9),
                      shape: BoxShape.circle,
                      boxShadow: AppTheme.shadowSM,
                    ),
                    child: Icon(
                      Icons.favorite_border_rounded,
                      size: 20,
                      color: AppColors.neutral70,
                    ),
                  ),
                ),
                // 图片指示器 (多图时显示)
                if (listing.photos.length > 1)
                  Positioned(
                    bottom: AppTheme.spacing12,
                    left: 0,
                    right: 0,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(
                        listing.photos.length.clamp(0, 5),
                        (index) => Container(
                          width: index == 0 ? 8 : 6,
                          height: index == 0 ? 8 : 6,
                          margin: const EdgeInsets.symmetric(horizontal: 2),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: index == 0 
                                ? Colors.white 
                                : Colors.white.withValues(alpha: 0.5),
                          ),
                        ),
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(height: AppTheme.spacing12),
            // 信息区域
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // 标题
                      Text(
                        listing.title,
                        style: AppTheme.title16.copyWith(
                          color: isDark ? AppColors.neutral10 : AppColors.neutral90,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 2),
                      // 位置
                      if (listing.location != null)
                        Text(
                          listing.location!,
                          style: AppTheme.body14.copyWith(
                            color: AppColors.neutral50,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      const SizedBox(height: 4),
                      // 设施信息
                      Row(
                        children: [
                          _buildInfoTag(Icons.bed_rounded, '${listing.bedrooms}卧'),
                          const SizedBox(width: 12),
                          _buildInfoTag(Icons.bathtub_rounded, '${listing.bathrooms}卫'),
                          const SizedBox(width: 12),
                          _buildInfoTag(Icons.person_rounded, '${listing.maxGuests}人'),
                        ],
                      ),
                      const SizedBox(height: AppTheme.spacing8),
                      // 价格
                      if (listing.pricePerNight != null)
                        RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: '¥${listing.pricePerNight!.toStringAsFixed(0)}',
                                style: AppTheme.priceMedium.copyWith(
                                  color: isDark ? AppColors.neutral10 : AppColors.neutral90,
                                ),
                              ),
                              TextSpan(
                                text: ' /晚',
                                style: AppTheme.body14.copyWith(
                                  color: AppColors.neutral50,
                                ),
                              ),
                            ],
                          ),
                        ),
                    ],
                  ),
                ),
                // 评分
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.star_rounded,
                        size: 16,
                        color: isDark ? AppColors.neutral10 : AppColors.neutral90,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        '4.9',
                        style: AppTheme.subtitle14.copyWith(
                          color: isDark ? AppColors.neutral10 : AppColors.neutral90,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildImagePlaceholder() {
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

  Widget _buildInfoTag(IconData icon, String text) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 14, color: AppColors.neutral50),
        const SizedBox(width: 4),
        Text(
          text,
          style: AppTheme.body12.copyWith(color: AppColors.neutral50),
        ),
      ],
    );
  }
}

/// 现代化加载骨架屏
class _ModernLoadingSkeleton extends StatelessWidget {
  const _ModernLoadingSkeleton();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppTheme.spacing20),
      child: Shimmer.fromColors(
        baseColor: AppColors.neutral20,
        highlightColor: AppColors.neutral10,
        child: Column(
          children: List.generate(3, (index) {
            return Container(
              margin: const EdgeInsets.only(bottom: AppTheme.spacing24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 图片骨架
                  AspectRatio(
                    aspectRatio: 4 / 3,
                    child: Container(
                      decoration: BoxDecoration(
                        color: AppColors.neutral20,
                        borderRadius: BorderRadius.circular(AppTheme.radiusXL),
                      ),
                    ),
                  ),
                  const SizedBox(height: AppTheme.spacing12),
                  // 标题骨架
                  Container(
                    height: 20,
                    width: 200,
                    decoration: BoxDecoration(
                      color: AppColors.neutral20,
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                  const SizedBox(height: 8),
                  // 位置骨架
                  Container(
                    height: 16,
                    width: 150,
                    decoration: BoxDecoration(
                      color: AppColors.neutral20,
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                  const SizedBox(height: 12),
                  // 价格骨架
                  Container(
                    height: 18,
                    width: 100,
                    decoration: BoxDecoration(
                      color: AppColors.neutral20,
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                ],
              ),
            );
          }),
        ),
      ),
    );
  }
}
