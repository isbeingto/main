import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import '../../theme/app_colors.dart';

/// Unified empty state widget
class EmptyState extends StatelessWidget {
  final IconData icon;
  final String title;
  final String? message;
  final Widget? action;

  const EmptyState({
    super.key,
    required this.icon,
    required this.title,
    this.message,
    this.action,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                color: AppColors.mono20,
                shape: BoxShape.circle,
              ),
              child: Icon(
                icon,
                size: 40,
                color: AppColors.mono60,
              ),
            ),
            const SizedBox(height: 24),
            Text(
              title,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    color: AppColors.mono100,
                    fontWeight: FontWeight.w600,
                  ),
              textAlign: TextAlign.center,
            ),
            if (message != null) ...[
              const SizedBox(height: 8),
              Text(
                message!,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: AppColors.mono60,
                    ),
                textAlign: TextAlign.center,
              ),
            ],
            if (action != null) ...[
              const SizedBox(height: 24),
              action!,
            ],
          ],
        ),
      ),
    );
  }
}

/// Empty state for no data
class NoDataState extends StatelessWidget {
  final String? message;
  final VoidCallback? onRetry;

  const NoDataState({
    super.key,
    this.message,
    this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    return EmptyState(
      icon: HugeIcons.strokeRoundedFolderOff,
      title: '暂无数据',
      message: message,
      action: onRetry != null
          ? OutlinedButton.icon(
              onPressed: onRetry,
              icon: const Icon(HugeIcons.strokeRoundedRefresh),
              label: const Text('刷新'),
            )
          : null,
    );
  }
}

/// Empty state for no results
class NoResultsState extends StatelessWidget {
  final String? query;

  const NoResultsState({super.key, this.query});

  @override
  Widget build(BuildContext context) {
    return EmptyState(
      icon: HugeIcons.strokeRoundedSearch01,
      title: '未找到结果',
      message: query != null ? '没有找到与"$query"相关的内容' : '请尝试其他搜索词',
    );
  }
}

/// Empty state for offline
class OfflineState extends StatelessWidget {
  final VoidCallback? onRetry;

  const OfflineState({super.key, this.onRetry});

  @override
  Widget build(BuildContext context) {
    return EmptyState(
      icon: HugeIcons.strokeRoundedWifiOff01,
      title: '网络连接已断开',
      message: '请检查您的网络连接',
      action: onRetry != null
          ? ElevatedButton.icon(
              onPressed: onRetry,
              icon: const Icon(HugeIcons.strokeRoundedRefresh),
              label: const Text('重试'),
            )
          : null,
    );
  }
}

/// Empty state for login required
class LoginRequiredState extends StatelessWidget {
  final VoidCallback? onLogin;

  const LoginRequiredState({super.key, this.onLogin});

  @override
  Widget build(BuildContext context) {
    return EmptyState(
      icon: HugeIcons.strokeRoundedLogin01,
      title: '需要登录',
      message: '登录后即可查看此内容',
      action: onLogin != null
          ? ElevatedButton.icon(
              onPressed: onLogin,
              icon: const Icon(HugeIcons.strokeRoundedLogin01),
              label: const Text('立即登录'),
            )
          : null,
    );
  }
}
