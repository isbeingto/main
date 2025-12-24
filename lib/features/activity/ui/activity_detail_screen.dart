import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../routing/routes.dart';
import '../../../theme/app_colors.dart';

/// Activity detail screen (活动详情)
class ActivityDetailScreen extends ConsumerWidget {
  const ActivityDetailScreen({
    super.key,
    required this.activityId,
  });

  final String activityId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Mock data based on activityId
    final mockActivity = _getMockActivity(activityId);

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          // App Bar with image
          SliverAppBar(
            expandedHeight: 250,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(
                mockActivity.title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  shadows: [
                    Shadow(
                      blurRadius: 4,
                      color: Colors.black45,
                    ),
                  ],
                ),
              ),
              background: Stack(
                fit: StackFit.expand,
                children: [
                  Image.network(
                    mockActivity.imageUrl,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        color: AppColors.blueberry40,
                        child: const Center(
                          child: Icon(Icons.image_not_supported, size: 64, color: Colors.white54),
                        ),
                      );
                    },
                  ),
                  const DecoratedBox(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [Colors.transparent, Colors.black54],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            actions: [
              IconButton(
                icon: const Icon(Icons.share),
                onPressed: () {
                  // TODO: Implement share
                },
              ),
              IconButton(
                icon: const Icon(Icons.favorite_border),
                onPressed: () {
                  final user = Supabase.instance.client.auth.currentUser;
                  if (user == null) {
                    context.push(Routes.login);
                    return;
                  }
                  // TODO: Implement favorite
                },
              ),
            ],
          ),

          // Content
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Date and location
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: AppColors.blueberry10,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      children: [
                        _InfoRow(
                          icon: Icons.calendar_today,
                          label: '活动时间',
                          value: DateFormat('yyyy年MM月dd日 HH:mm').format(mockActivity.date),
                        ),
                        const Divider(height: 24),
                        _InfoRow(
                          icon: Icons.location_on,
                          label: '活动地点',
                          value: mockActivity.location,
                        ),
                        const Divider(height: 24),
                        _InfoRow(
                          icon: Icons.people,
                          label: '报名人数',
                          value: '${mockActivity.enrolled}/${mockActivity.capacity}人',
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 24),

                  // Description section
                  Text(
                    '活动介绍',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    mockActivity.description,
                    style: TextStyle(
                      color: AppColors.mono80,
                      fontSize: 15,
                      height: 1.6,
                    ),
                  ),

                  const SizedBox(height: 24),

                  // Schedule section
                  Text(
                    '活动流程',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  const SizedBox(height: 12),
                  ...mockActivity.schedule.map((item) => _ScheduleItem(
                        time: item.time,
                        title: item.title,
                      )),

                  const SizedBox(height: 24),

                  // Notes section
                  Text(
                    '注意事项',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  const SizedBox(height: 12),
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: AppColors.rambutan10,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: AppColors.rambutan40),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _NoteItem(text: '请穿着舒适的鞋子和衣物'),
                        _NoteItem(text: '自备防晒用品和驱蚊液'),
                        _NoteItem(text: '儿童需有成人陪同'),
                        _NoteItem(text: '如遇恶劣天气，活动可能延期'),
                      ],
                    ),
                  ),

                  const SizedBox(height: 100), // Space for bottom bar
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.1),
              blurRadius: 10,
              offset: const Offset(0, -2),
            ),
          ],
        ),
        child: SafeArea(
          child: Row(
            children: [
              // Price
              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    mockActivity.price > 0 ? '¥${mockActivity.price.toStringAsFixed(0)}' : '免费',
                    style: TextStyle(
                      color: AppColors.rambutan100,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    mockActivity.price > 0 ? '/人' : '活动',
                    style: TextStyle(
                      color: AppColors.mono60,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
              const SizedBox(width: 24),
              // Register button
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    final user = Supabase.instance.client.auth.currentUser;
                    if (user == null) {
                      context.push(Routes.login);
                      return;
                    }
                    // TODO: Implement registration
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('报名功能开发中...')),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.blueberry100,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    '立即报名',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _MockActivityDetail _getMockActivity(String id) {
    return _MockActivityDetail(
      id: id,
      title: '采摘节 · 体验农家乐趣',
      description: '''
来到我们的农场，您将体验最纯正的田园生活。在这里，您可以亲手采摘新鲜的水果和蔬菜，感受丰收的喜悦。

我们的农场占地200亩，种植了各种时令水果和有机蔬菜。专业的农场管理员会为您讲解种植知识，让您了解食物从田间到餐桌的全过程。

活动包含：
• 农场参观导览
• 采摘体验（可带走2斤果蔬）
• 农家午餐一份
• 儿童农耕体验区
''',
      imageUrl: 'https://picsum.photos/seed/$id/800/400',
      date: DateTime.now().add(const Duration(days: 7)),
      location: '浙江省杭州市临安区青山湖街道农业示范园',
      price: 99,
      enrolled: 45,
      capacity: 60,
      schedule: [
        _ScheduleItem(time: '09:00', title: '集合签到'),
        _ScheduleItem(time: '09:30', title: '农场导览'),
        _ScheduleItem(time: '10:30', title: '采摘体验'),
        _ScheduleItem(time: '12:00', title: '农家午餐'),
        _ScheduleItem(time: '13:30', title: '亲子农耕活动'),
        _ScheduleItem(time: '15:00', title: '合影留念，活动结束'),
      ],
    );
  }
}

class _MockActivityDetail {
  final String id;
  final String title;
  final String description;
  final String imageUrl;
  final DateTime date;
  final String location;
  final double price;
  final int enrolled;
  final int capacity;
  final List<_ScheduleItem> schedule;

  _MockActivityDetail({
    required this.id,
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.date,
    required this.location,
    required this.price,
    required this.enrolled,
    required this.capacity,
    required this.schedule,
  });
}

class _InfoRow extends StatelessWidget {
  const _InfoRow({
    required this.icon,
    required this.label,
    required this.value,
  });

  final IconData icon;
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 20, color: AppColors.blueberry100),
        const SizedBox(width: 12),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: TextStyle(
                color: AppColors.mono60,
                fontSize: 12,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              value,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _ScheduleItem extends StatelessWidget {
  const _ScheduleItem({
    required this.time,
    required this.title,
  });

  final String time;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          Container(
            width: 60,
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: AppColors.blueberry20,
              borderRadius: BorderRadius.circular(6),
            ),
            child: Text(
              time,
              style: TextStyle(
                color: AppColors.blueberry100,
                fontSize: 13,
                fontWeight: FontWeight.w600,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(width: 12),
          Text(
            title,
            style: const TextStyle(fontSize: 14),
          ),
        ],
      ),
    );
  }
}

class _NoteItem extends StatelessWidget {
  const _NoteItem({required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.info_outline, size: 16, color: AppColors.rambutan100),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              text,
              style: TextStyle(
                color: AppColors.mono80,
                fontSize: 14,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
