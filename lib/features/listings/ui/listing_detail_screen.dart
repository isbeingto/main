import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:shimmer/shimmer.dart';

import '../../../generated/locale_keys.g.dart';
import '../../../routing/routes.dart';
import '../../../theme/app_colors.dart';
import '../../../theme/app_theme.dart';
import '../model/listing.dart';
import '../view_model/booking_view_model.dart';
import '../view_model/listings_view_model.dart';

/// 2025年风格的房源详情页面
/// 沉浸式图片浏览、流畅动画、现代化预订体验
class ListingDetailScreen extends ConsumerStatefulWidget {
  const ListingDetailScreen({super.key, required this.listingId});

  final String listingId;

  @override
  ConsumerState<ListingDetailScreen> createState() => _ListingDetailScreenState();
}

class _ListingDetailScreenState extends ConsumerState<ListingDetailScreen> {
  final _noteController = TextEditingController();
  DateTime? _startDate;
  DateTime? _endDate;
  int _guests = 1;
  int _currentPhotoIndex = 0;
  final PageController _pageController = PageController();

  @override
  void dispose() {
    _noteController.dispose();
    _pageController.dispose();
    super.dispose();
  }

  Future<void> _selectDate(BuildContext context, bool isStart) async {
    final initialDate = isStart ? (_startDate ?? DateTime.now()) : (_endDate ?? DateTime.now().add(const Duration(days: 1)));
    final firstDate = isStart ? DateTime.now() : (_startDate ?? DateTime.now());
    final lastDate = DateTime.now().add(const Duration(days: 365));

    final picked = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: firstDate,
      lastDate: lastDate,
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: Theme.of(context).colorScheme.copyWith(
              primary: AppColors.accent,
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      setState(() {
        if (isStart) {
          _startDate = picked;
          if (_endDate != null && _endDate!.isBefore(picked)) {
            _endDate = null;
          }
        } else {
          _endDate = picked;
        }
      });
    }
  }

  void _showLoginRequiredDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppTheme.radiusXL),
        ),
        title: Text(LocaleKeys.loginRequired.tr()),
        content: Text(LocaleKeys.loginRequiredMessage.tr()),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(LocaleKeys.cancel.tr()),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              context.go(Routes.login);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.accent,
            ),
            child: Text(LocaleKeys.goToLogin.tr()),
          ),
        ],
      ),
    );
  }

  Future<void> _submitBookingRequest(Listing listing) async {
    final bookingViewModel = ref.read(bookingViewModelProvider.notifier);

    if (!bookingViewModel.isAuthenticated) {
      _showLoginRequiredDialog();
      return;
    }

    final success = await bookingViewModel.createBookingRequest(
      listingId: listing.id,
      startDate: _startDate,
      endDate: _endDate,
      guests: _guests,
      note: _noteController.text,
    );

    if (!mounted) return;

    if (success) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(LocaleKeys.bookingRequestSuccess.tr()),
          backgroundColor: AppColors.success,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppTheme.radiusMD),
          ),
        ),
      );
      setState(() {
        _startDate = null;
        _endDate = null;
        _guests = 1;
        _noteController.clear();
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(LocaleKeys.bookingRequestError.tr()),
          backgroundColor: AppColors.error,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppTheme.radiusMD),
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final listingAsync = ref.watch(listingDetailProvider(widget.listingId));
    final bookingState = ref.watch(bookingViewModelProvider);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? AppColors.neutral90 : AppColors.neutral0,
      body: listingAsync.when(
        data: (listing) {
          if (listing == null) {
            return Center(
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
                    child: Icon(Icons.error_outline_rounded, size: 40, color: AppColors.neutral40),
                  ),
                  const SizedBox(height: AppTheme.spacing16),
                  Text(LocaleKeys.noData.tr(), style: AppTheme.title16),
                ],
              ),
            );
          }
          return Stack(
            children: [
              CustomScrollView(
                physics: const BouncingScrollPhysics(),
                slivers: [
                  // 沉浸式图片AppBar
                  _buildImageSlider(context, listing, isDark),
                  // 内容区域
                  SliverToBoxAdapter(
                    child: _buildContent(context, listing, bookingState, isDark),
                  ),
                ],
              ),
              // 固定底部预订按钮
              Positioned(
                left: 0,
                right: 0,
                bottom: 0,
                child: _buildBottomBar(context, listing, bookingState, isDark),
              ),
            ],
          );
        },
        loading: () => const _ModernDetailLoadingSkeleton(),
        error: (error, stack) => _buildErrorState(context, isDark),
      ),
    );
  }

  Widget _buildImageSlider(BuildContext context, Listing listing, bool isDark) {
    return SliverAppBar(
      expandedHeight: MediaQuery.of(context).size.height * 0.45,
      pinned: true,
      stretch: true,
      backgroundColor: isDark ? AppColors.neutral90 : AppColors.neutral0,
      leading: Padding(
        padding: const EdgeInsets.all(8),
        child: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.9),
              shape: BoxShape.circle,
              boxShadow: AppTheme.shadowSM,
            ),
            child: const Icon(
              Icons.arrow_back_rounded,
              color: AppColors.neutral90,
              size: 22,
            ),
          ),
        ),
      ),
      actions: [
        // 分享按钮
        Padding(
          padding: const EdgeInsets.all(8),
          child: Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.9),
              shape: BoxShape.circle,
              boxShadow: AppTheme.shadowSM,
            ),
            child: const Icon(
              Icons.share_rounded,
              color: AppColors.neutral90,
              size: 20,
            ),
          ),
        ),
        // 收藏按钮
        Padding(
          padding: const EdgeInsets.only(right: 8),
          child: Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.9),
              shape: BoxShape.circle,
              boxShadow: AppTheme.shadowSM,
            ),
            child: const Icon(
              Icons.favorite_border_rounded,
              color: AppColors.neutral90,
              size: 20,
            ),
          ),
        ),
      ],
      flexibleSpace: FlexibleSpaceBar(
        background: listing.photos.isNotEmpty
            ? Stack(
                fit: StackFit.expand,
                children: [
                  PageView.builder(
                    controller: _pageController,
                    itemCount: listing.photos.length,
                    onPageChanged: (index) {
                      setState(() => _currentPhotoIndex = index);
                    },
                    itemBuilder: (context, index) {
                      return CachedNetworkImage(
                        imageUrl: listing.photos[index].photoUrl,
                        fit: BoxFit.cover,
                        placeholder: (context, url) => Container(
                          color: AppColors.neutral20,
                          child: Center(
                            child: CircularProgressIndicator(
                              color: AppColors.accent,
                              strokeWidth: 2,
                            ),
                          ),
                        ),
                        errorWidget: (context, url, error) => Container(
                          color: AppColors.neutral20,
                          child: Icon(Icons.image_not_supported_rounded, size: 48, color: AppColors.neutral40),
                        ),
                      );
                    },
                  ),
                  // 渐变遮罩
                  Positioned(
                    left: 0,
                    right: 0,
                    bottom: 0,
                    height: 100,
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter,
                          colors: [
                            Colors.black.withValues(alpha: 0.3),
                            Colors.transparent,
                          ],
                        ),
                      ),
                    ),
                  ),
                  // 图片指示器
                  if (listing.photos.length > 1)
                    Positioned(
                      bottom: AppTheme.spacing20,
                      left: 0,
                      right: 0,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(
                          listing.photos.length.clamp(0, 10),
                          (index) => AnimatedContainer(
                            duration: AppTheme.durationFast,
                            margin: const EdgeInsets.symmetric(horizontal: 3),
                            width: index == _currentPhotoIndex ? 24 : 8,
                            height: 8,
                            decoration: BoxDecoration(
                              color: index == _currentPhotoIndex
                                  ? Colors.white
                                  : Colors.white.withValues(alpha: 0.5),
                              borderRadius: BorderRadius.circular(4),
                            ),
                          ),
                        ),
                      ),
                    ),
                  // 图片计数
                  Positioned(
                    bottom: AppTheme.spacing20,
                    right: AppTheme.spacing20,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppTheme.spacing12,
                        vertical: AppTheme.spacing4,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.black.withValues(alpha: 0.6),
                        borderRadius: BorderRadius.circular(AppTheme.radiusFull),
                      ),
                      child: Text(
                        '${_currentPhotoIndex + 1}/${listing.photos.length}',
                        style: AppTheme.label12.copyWith(color: Colors.white),
                      ),
                    ),
                  ),
                ],
              )
            : Container(
                color: AppColors.neutral20,
                child: Center(
                  child: Icon(Icons.home_rounded, size: 64, color: AppColors.neutral40),
                ),
              ),
      ),
    );
  }

  Widget _buildContent(BuildContext context, Listing listing, AsyncValue bookingState, bool isDark) {
    return Container(
      decoration: BoxDecoration(
        color: isDark ? AppColors.neutral90 : AppColors.neutral0,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(AppTheme.radius2XL)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppTheme.spacing20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 标题
            Text(
              listing.title,
              style: AppTheme.title24.copyWith(
                color: isDark ? AppColors.neutral10 : AppColors.neutral90,
              ),
            ),
            const SizedBox(height: AppTheme.spacing8),
            // 位置和评分
            Row(
              children: [
                if (listing.location != null) ...[
                  Icon(Icons.location_on_rounded, size: 18, color: AppColors.neutral50),
                  const SizedBox(width: 4),
                  Expanded(
                    child: Text(
                      listing.location!,
                      style: AppTheme.body14.copyWith(color: AppColors.neutral50),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
                // 评分
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: AppColors.accent.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(AppTheme.radiusSM),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.star_rounded, size: 16, color: AppColors.accent),
                      const SizedBox(width: 4),
                      Text(
                        '4.9',
                        style: AppTheme.subtitle14.copyWith(color: AppColors.accent),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppTheme.spacing20),
            
            // 房间信息卡片
            Container(
              padding: const EdgeInsets.all(AppTheme.spacing16),
              decoration: BoxDecoration(
                color: isDark ? AppColors.neutral80 : AppColors.neutral5,
                borderRadius: BorderRadius.circular(AppTheme.radiusLG),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _ModernInfoItem(
                    icon: Icons.bed_rounded,
                    value: '${listing.bedrooms}',
                    label: '卧室',
                    isDark: isDark,
                  ),
                  _buildDivider(isDark),
                  _ModernInfoItem(
                    icon: Icons.bathtub_rounded,
                    value: '${listing.bathrooms}',
                    label: '卫生间',
                    isDark: isDark,
                  ),
                  _buildDivider(isDark),
                  _ModernInfoItem(
                    icon: Icons.person_rounded,
                    value: '${listing.maxGuests}',
                    label: '最多入住',
                    isDark: isDark,
                  ),
                ],
              ),
            ),
            const SizedBox(height: AppTheme.spacing24),
            
            // 描述
            if (listing.description != null) ...[
              Text(
                '房源介绍',
                style: AppTheme.title18.copyWith(
                  color: isDark ? AppColors.neutral10 : AppColors.neutral90,
                ),
              ),
              const SizedBox(height: AppTheme.spacing12),
              Text(
                listing.description!,
                style: AppTheme.body16.copyWith(
                  color: isDark ? AppColors.neutral30 : AppColors.neutral60,
                  height: 1.6,
                ),
              ),
              const SizedBox(height: AppTheme.spacing24),
            ],
            
            // 设施
            if (listing.amenities.isNotEmpty) ...[
              Text(
                '设施服务',
                style: AppTheme.title18.copyWith(
                  color: isDark ? AppColors.neutral10 : AppColors.neutral90,
                ),
              ),
              const SizedBox(height: AppTheme.spacing12),
              Wrap(
                spacing: AppTheme.spacing8,
                runSpacing: AppTheme.spacing8,
                children: listing.amenities.map((amenity) {
                  return Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppTheme.spacing12,
                      vertical: AppTheme.spacing8,
                    ),
                    decoration: BoxDecoration(
                      color: isDark ? AppColors.neutral80 : AppColors.neutral5,
                      borderRadius: BorderRadius.circular(AppTheme.radiusFull),
                      border: Border.all(
                        color: isDark ? AppColors.neutral70 : AppColors.neutral20,
                      ),
                    ),
                    child: Text(
                      amenity,
                      style: AppTheme.label14.copyWith(
                        color: isDark ? AppColors.neutral20 : AppColors.neutral70,
                      ),
                    ),
                  );
                }).toList(),
              ),
              const SizedBox(height: AppTheme.spacing24),
            ],
            
            // 预订表单
            Divider(color: isDark ? AppColors.neutral70 : AppColors.neutral20),
            const SizedBox(height: AppTheme.spacing20),
            Text(
              '预订信息',
              style: AppTheme.title18.copyWith(
                color: isDark ? AppColors.neutral10 : AppColors.neutral90,
              ),
            ),
            const SizedBox(height: AppTheme.spacing16),
            
            // 日期选择
            Row(
              children: [
                Expanded(
                  child: _ModernDateField(
                    label: '入住日期',
                    date: _startDate,
                    onTap: () => _selectDate(context, true),
                    isDark: isDark,
                  ),
                ),
                const SizedBox(width: AppTheme.spacing12),
                Expanded(
                  child: _ModernDateField(
                    label: '退房日期',
                    date: _endDate,
                    onTap: () => _selectDate(context, false),
                    isDark: isDark,
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppTheme.spacing16),
            
            // 人数选择
            Container(
              padding: const EdgeInsets.all(AppTheme.spacing16),
              decoration: BoxDecoration(
                color: isDark ? AppColors.neutral80 : AppColors.neutral5,
                borderRadius: BorderRadius.circular(AppTheme.radiusMD),
              ),
              child: Row(
                children: [
                  Icon(Icons.person_outline_rounded, color: AppColors.neutral50),
                  const SizedBox(width: AppTheme.spacing12),
                  Expanded(
                    child: Text(
                      '入住人数',
                      style: AppTheme.body16.copyWith(
                        color: isDark ? AppColors.neutral20 : AppColors.neutral70,
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: _guests > 1 ? () => setState(() => _guests--) : null,
                    child: Container(
                      width: 36,
                      height: 36,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: _guests > 1 ? AppColors.accent : AppColors.neutral30,
                        ),
                      ),
                      child: Icon(
                        Icons.remove_rounded,
                        size: 20,
                        color: _guests > 1 ? AppColors.accent : AppColors.neutral30,
                      ),
                    ),
                  ),
                  Container(
                    width: 48,
                    alignment: Alignment.center,
                    child: Text(
                      '$_guests',
                      style: AppTheme.title18.copyWith(
                        color: isDark ? AppColors.neutral10 : AppColors.neutral90,
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: _guests < listing.maxGuests
                        ? () => setState(() => _guests++)
                        : null,
                    child: Container(
                      width: 36,
                      height: 36,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: _guests < listing.maxGuests 
                            ? AppColors.accent 
                            : AppColors.neutral30,
                      ),
                      child: Icon(
                        Icons.add_rounded,
                        size: 20,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: AppTheme.spacing16),
            
            // 备注
            Container(
              decoration: BoxDecoration(
                color: isDark ? AppColors.neutral80 : AppColors.neutral5,
                borderRadius: BorderRadius.circular(AppTheme.radiusMD),
              ),
              child: TextField(
                controller: _noteController,
                maxLines: 3,
                style: AppTheme.body16.copyWith(
                  color: isDark ? AppColors.neutral10 : AppColors.neutral90,
                ),
                decoration: InputDecoration(
                  hintText: '有什么特殊需求可以告诉我们...',
                  hintStyle: AppTheme.body16.copyWith(color: AppColors.neutral40),
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.all(AppTheme.spacing16),
                ),
              ),
            ),
            
            // 底部占位
            const SizedBox(height: 120),
          ],
        ),
      ),
    );
  }

  Widget _buildDivider(bool isDark) {
    return Container(
      width: 1,
      height: 40,
      color: isDark ? AppColors.neutral70 : AppColors.neutral20,
    );
  }

  Widget _buildBottomBar(BuildContext context, Listing listing, AsyncValue bookingState, bool isDark) {
    return Container(
      padding: EdgeInsets.fromLTRB(
        AppTheme.spacing20,
        AppTheme.spacing16,
        AppTheme.spacing20,
        MediaQuery.of(context).padding.bottom + AppTheme.spacing16,
      ),
      decoration: BoxDecoration(
        color: isDark ? AppColors.neutral80 : AppColors.neutral0,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 20,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: Row(
        children: [
          // 价格信息
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              if (listing.pricePerNight != null) ...[
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: '¥${listing.pricePerNight!.toStringAsFixed(0)}',
                        style: AppTheme.priceDisplay.copyWith(
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
            ],
          ),
          const SizedBox(width: AppTheme.spacing20),
          // 预订按钮
          Expanded(
            child: GestureDetector(
              onTap: bookingState.isLoading
                  ? null
                  : () {
                      HapticFeedback.mediumImpact();
                      _submitBookingRequest(listing);
                    },
              child: Container(
                height: 52,
                decoration: BoxDecoration(
                  gradient: AppColors.primaryGradient,
                  borderRadius: BorderRadius.circular(AppTheme.radiusFull),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.accent.withValues(alpha: 0.3),
                      blurRadius: 12,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Center(
                  child: bookingState.isLoading
                      ? const SizedBox(
                          width: 22,
                          height: 22,
                          child: CircularProgressIndicator(
                            strokeWidth: 2.5,
                            valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                          ),
                        )
                      : Text(
                          '立即预订',
                          style: AppTheme.buttonLarge.copyWith(color: Colors.white),
                        ),
                ),
              ),
            ),
          ),
        ],
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
              child: Icon(Icons.wifi_off_rounded, size: 40, color: AppColors.error),
            ),
            const SizedBox(height: AppTheme.spacing24),
            Text(
              '加载失败',
              style: AppTheme.title20.copyWith(
                color: isDark ? AppColors.neutral10 : AppColors.neutral80,
              ),
            ),
            const SizedBox(height: AppTheme.spacing8),
            Text(
              '请检查网络连接后重试',
              style: AppTheme.body14.copyWith(color: AppColors.neutral50),
            ),
            const SizedBox(height: AppTheme.spacing24),
            GestureDetector(
              onTap: () => ref.invalidate(listingDetailProvider(widget.listingId)),
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

/// 2025年风格的房间信息项组件
class _ModernInfoItem extends StatelessWidget {
  const _ModernInfoItem({
    required this.icon,
    required this.label,
    required this.value,
    required this.isDark,
  });

  final IconData icon;
  final String label;
  final String value;
  final bool isDark;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 44,
          height: 44,
          decoration: BoxDecoration(
            color: AppColors.accent.withValues(alpha: 0.1),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: AppColors.accent, size: 22),
        ),
        const SizedBox(height: AppTheme.spacing8),
        Text(
          value,
          style: AppTheme.title20.copyWith(
            color: isDark ? AppColors.neutral10 : AppColors.neutral90,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          label,
          style: AppTheme.label12.copyWith(color: AppColors.neutral50),
        ),
      ],
    );
  }
}

/// 2025年风格的日期选择字段组件
class _ModernDateField extends StatelessWidget {
  const _ModernDateField({
    required this.label,
    required this.date,
    required this.onTap,
    required this.isDark,
  });

  final String label;
  final DateTime? date;
  final VoidCallback onTap;
  final bool isDark;

  @override
  Widget build(BuildContext context) {
    final dateFormat = DateFormat('MM月dd日');
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(AppTheme.spacing16),
        decoration: BoxDecoration(
          color: isDark ? AppColors.neutral80 : AppColors.neutral5,
          borderRadius: BorderRadius.circular(AppTheme.radiusMD),
          border: Border.all(
            color: date != null 
                ? AppColors.accent.withValues(alpha: 0.5)
                : (isDark ? AppColors.neutral70 : AppColors.neutral20),
            width: date != null ? 1.5 : 1,
          ),
        ),
        child: Row(
          children: [
            Icon(
              Icons.calendar_today_rounded, 
              size: 20, 
              color: date != null ? AppColors.accent : AppColors.neutral50,
            ),
            const SizedBox(width: AppTheme.spacing12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    label,
                    style: AppTheme.label12.copyWith(color: AppColors.neutral50),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    date != null ? dateFormat.format(date!) : '选择日期',
                    style: AppTheme.body16.copyWith(
                      color: date != null 
                          ? (isDark ? AppColors.neutral10 : AppColors.neutral90)
                          : AppColors.neutral40,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// 2025年风格的详情页加载骨架屏
class _ModernDetailLoadingSkeleton extends StatelessWidget {
  const _ModernDetailLoadingSkeleton();

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Shimmer.fromColors(
      baseColor: isDark ? AppColors.neutral70 : AppColors.neutral10,
      highlightColor: isDark ? AppColors.neutral60 : AppColors.neutral0,
      child: CustomScrollView(
        physics: const NeverScrollableScrollPhysics(),
        slivers: [
          SliverAppBar(
            expandedHeight: MediaQuery.of(context).size.height * 0.45,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                decoration: BoxDecoration(
                  color: isDark ? AppColors.neutral80 : AppColors.neutral10,
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(AppTheme.spacing20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 标题骨架
                  Container(
                    height: 28,
                    width: 280,
                    decoration: BoxDecoration(
                      color: isDark ? AppColors.neutral70 : AppColors.neutral10,
                      borderRadius: BorderRadius.circular(AppTheme.radiusSM),
                    ),
                  ),
                  const SizedBox(height: AppTheme.spacing12),
                  // 位置骨架
                  Container(
                    height: 18,
                    width: 180,
                    decoration: BoxDecoration(
                      color: isDark ? AppColors.neutral70 : AppColors.neutral10,
                      borderRadius: BorderRadius.circular(AppTheme.radiusSM),
                    ),
                  ),
                  const SizedBox(height: AppTheme.spacing24),
                  // 房间信息骨架
                  Container(
                    height: 100,
                    decoration: BoxDecoration(
                      color: isDark ? AppColors.neutral70 : AppColors.neutral10,
                      borderRadius: BorderRadius.circular(AppTheme.radiusLG),
                    ),
                  ),
                  const SizedBox(height: AppTheme.spacing24),
                  // 描述标题
                  Container(
                    height: 22,
                    width: 100,
                    decoration: BoxDecoration(
                      color: isDark ? AppColors.neutral70 : AppColors.neutral10,
                      borderRadius: BorderRadius.circular(AppTheme.radiusSM),
                    ),
                  ),
                  const SizedBox(height: AppTheme.spacing12),
                  // 描述内容
                  ...List.generate(
                    3,
                    (index) => Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: Container(
                        height: 16,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: isDark ? AppColors.neutral70 : AppColors.neutral10,
                          borderRadius: BorderRadius.circular(AppTheme.radiusSM),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: AppTheme.spacing24),
                  // 设施骨架
                  Container(
                    height: 22,
                    width: 80,
                    decoration: BoxDecoration(
                      color: isDark ? AppColors.neutral70 : AppColors.neutral10,
                      borderRadius: BorderRadius.circular(AppTheme.radiusSM),
                    ),
                  ),
                  const SizedBox(height: AppTheme.spacing12),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: List.generate(
                      6,
                      (index) => Container(
                        width: 80,
                        height: 36,
                        decoration: BoxDecoration(
                          color: isDark ? AppColors.neutral70 : AppColors.neutral10,
                          borderRadius: BorderRadius.circular(AppTheme.radiusFull),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
