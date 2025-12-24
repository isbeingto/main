import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:shimmer/shimmer.dart';

import '../../../generated/locale_keys.g.dart';
import '../../../routing/routes.dart';
import '../../../theme/app_colors.dart';

/// Activity list screen (活动列表)
class ActivityListScreen extends ConsumerWidget {
  const ActivityListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Mock activity data
    final activities = List.generate(
      8,
      (index) => _MockActivity(
        id: 'activity_$index',
        title: _activityTitles[index % _activityTitles.length],
        description: _activityDescriptions[index % _activityDescriptions.length],
        date: DateTime.now().add(Duration(days: index * 3)),
        imageUrl: 'https://picsum.photos/seed/activity$index/400/200',
        location: _locations[index % _locations.length],
        price: index % 3 == 0 ? 0 : 99.0 + index * 50,
      ),
    );

    return Scaffold(
      appBar: AppBar(
        title: Text(LocaleKeys.tabActivity.tr()),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_list),
            onPressed: () {
              // TODO: Implement filter
            },
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          await Future.delayed(const Duration(seconds: 1));
        },
        child: ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: activities.length,
          itemBuilder: (context, index) {
            return _ActivityCard(activity: activities[index]);
          },
        ),
      ),
    );
  }
}

const _activityTitles = [
  '采摘节',
  '农家乐体验',
  '亲子农场日',
  '丰收庆典',
  '田园烧烤派对',
  '春耕体验活动',
  '农产品展销会',
  '乡村美食节',
];

const _activityDescriptions = [
  '体验田园采摘乐趣，品尝新鲜果蔬',
  '感受真正的农家生活，远离城市喧嚣',
  '带孩子走进自然，体验农耕文化',
  '庆祝丰收季节，分享农家喜悦',
  '在田野间享受美味烧烤，欣赏夕阳美景',
  '亲手播种，体验农耕的辛勤与乐趣',
  '精选各地农产品，品质保证',
  '品尝地道农家美食，感受乡村风味',
];

const _locations = [
  '云南大理',
  '浙江莫干山',
  '四川成都',
  '江苏苏州',
  '广东清远',
  '福建武夷山',
  '安徽黄山',
  '湖南张家界',
];

class _MockActivity {
  final String id;
  final String title;
  final String description;
  final DateTime date;
  final String imageUrl;
  final String location;
  final double price;

  _MockActivity({
    required this.id,
    required this.title,
    required this.description,
    required this.date,
    required this.imageUrl,
    required this.location,
    required this.price,
  });
}

class _ActivityCard extends StatelessWidget {
  const _ActivityCard({required this.activity});

  final _MockActivity activity;

  @override
  Widget build(BuildContext context) {
    final dateFormat = DateFormat('MM月dd日');

    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      clipBehavior: Clip.antiAlias,
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: InkWell(
        onTap: () {
          context.push(Routes.activityDetailPath(activity.id));
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image
            AspectRatio(
              aspectRatio: 16 / 9,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Image.network(
                    activity.imageUrl,
                    fit: BoxFit.cover,
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) return child;
                      return Shimmer.fromColors(
                        baseColor: Colors.grey[300]!,
                        highlightColor: Colors.grey[100]!,
                        child: Container(color: Colors.grey[300]),
                      );
                    },
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        color: AppColors.mono20,
                        child: const Center(
                          child: Icon(Icons.image_not_supported, size: 48, color: AppColors.mono40),
                        ),
                      );
                    },
                  ),
                  // Date badge
                  Positioned(
                    top: 12,
                    left: 12,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: AppColors.blueberry100,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        dateFormat.format(activity.date),
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                  // Free badge
                  if (activity.price == 0)
                    Positioned(
                      top: 12,
                      right: 12,
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                          color: AppColors.watermelon100,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: const Text(
                          '免费',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
            // Content
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    activity.title,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    activity.description,
                    style: TextStyle(
                      color: AppColors.mono60,
                      fontSize: 14,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Icon(Icons.location_on, size: 16, color: AppColors.mono60),
                      const SizedBox(width: 4),
                      Text(
                        activity.location,
                        style: TextStyle(
                          color: AppColors.mono60,
                          fontSize: 13,
                        ),
                      ),
                      const Spacer(),
                      if (activity.price > 0)
                        Text(
                          '¥${activity.price.toStringAsFixed(0)}/人',
                          style: TextStyle(
                            color: AppColors.rambutan100,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                    ],
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
