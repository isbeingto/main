import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../features/activity/ui/activity_list_screen.dart';
import '../features/authentication/ui/sign_in_screen.dart';
import '../features/authentication/ui/register_screen.dart';
import '../features/home/ui/home_screen.dart';
import '../features/home/ui/product_detail_screen.dart';
import '../features/listings/ui/listings_screen.dart';
import '../features/listings/ui/lodging_detail_screen.dart';
import '../features/listings/ui/my_bookings_screen.dart';
import '../features/activity/ui/activity_detail_screen.dart';
import '../features/listings/ui/my_activity_signups_screen.dart';
import '../features/products/ui/my_orders_screen.dart';
import '../features/onboarding/ui/onboarding_screen.dart';
import '../features/onboarding/ui/splash_screen.dart';
import '../features/premium/ui/premium_screen.dart';
import '../features/profile/model/profile.dart';
import '../features/profile/ui/account_info_screen.dart';
import '../features/profile/ui/appearances_screen.dart';
import '../features/profile/ui/languages_screen.dart';
import '../features/profile/ui/profile_wrapper.dart';
import 'app_shell.dart';
import 'routes.dart';

// Navigation keys for each tab branch
final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _homeNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'home');
final _lodgingNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'lodging');
final _activityNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'activity');
final _profileNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'profile');

enum SlideDirection {
  right,
  left,
  up,
  down,
}

extension GoRouterStateExtension on GoRouterState {
  SlideRouteTransition slidePage(
    Widget child, {
    SlideDirection direction = SlideDirection.left,
  }) {
    return SlideRouteTransition(
      key: pageKey,
      child: child,
      direction: direction,
    );
  }
}

class SlideRouteTransition extends CustomTransitionPage<void> {
  SlideRouteTransition({
    required super.key,
    required super.child,
    SlideDirection direction = SlideDirection.left,
  }) : super(
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            final curve = CurvedAnimation(
              parent: animation,
              curve: Curves.easeInOut,
            );

            Offset begin;
            switch (direction) {
              case SlideDirection.right:
                begin = const Offset(-1.0, 0.0);
                break;
              case SlideDirection.left:
                begin = const Offset(1.0, 0.0);
                break;
              case SlideDirection.up:
                begin = const Offset(0.0, 1.0);
                break;
              case SlideDirection.down:
                begin = const Offset(0.0, -1.0);
                break;
            }
            final tween = Tween(begin: begin, end: Offset.zero);
            final offsetAnimation = tween.animate(curve);

            return SlideTransition(
              position: offsetAnimation,
              child: child,
            );
          },
        );
}

final GoRouter router = GoRouter(
  navigatorKey: _rootNavigatorKey,
  initialLocation: Routes.splash,
  routes: [
    // Auth routes (outside shell)
    GoRoute(
      path: Routes.splash,
      pageBuilder: (context, state) => state.slidePage(const SplashScreen()),
    ),
    GoRoute(
      path: Routes.register,
      pageBuilder: (context, state) => state.slidePage(const RegisterScreen()),
    ),
    GoRoute(
      path: Routes.login,
      pageBuilder: (context, state) => state.slidePage(const SignInScreen()),
    ),
    GoRoute(
      path: Routes.onboarding,
      pageBuilder: (context, state) =>
          state.slidePage(const OnboardingScreen()),
    ),

    // Main app shell with bottom navigation
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) {
        return AppShell(navigationShell: navigationShell);
      },
      branches: [
        // Tab 1: Home (首页)
        StatefulShellBranch(
          navigatorKey: _homeNavigatorKey,
          routes: [
            GoRoute(
              path: Routes.home,
              pageBuilder: (context, state) =>
                  state.slidePage(const HomeScreen(), direction: SlideDirection.right),
              routes: [
                GoRoute(
                  path: 'product/:id',
                  pageBuilder: (context, state) {
                    final id = state.pathParameters['id']!;
                    return state.slidePage(ProductDetailScreen(productId: id));
                  },
                ),
              ],
            ),
          ],
        ),

        // Tab 2: Lodging (民宿)
        StatefulShellBranch(
          navigatorKey: _lodgingNavigatorKey,
          routes: [
            GoRoute(
              path: Routes.lodging,
              pageBuilder: (context, state) =>
                  state.slidePage(const ListingsScreen(), direction: SlideDirection.right),
              routes: [
                GoRoute(
                  path: 'detail/:id',
                  pageBuilder: (context, state) {
                    final id = state.pathParameters['id']!;
                    return state.slidePage(LodgingDetailScreen(lodgingId: id));
                  },
                ),
              ],
            ),
          ],
        ),

        // Tab 3: Activity (活动)
        StatefulShellBranch(
          navigatorKey: _activityNavigatorKey,
          routes: [
            GoRoute(
              path: Routes.activity,
              pageBuilder: (context, state) =>
                  state.slidePage(const ActivityListScreen(), direction: SlideDirection.right),
              routes: [
                GoRoute(
                  path: 'detail/:id',
                  pageBuilder: (context, state) {
                    final id = state.pathParameters['id']!;
                    return state.slidePage(ActivityDetailScreen(activityId: id));
                  },
                ),
              ],
            ),
          ],
        ),

        // Tab 4: Profile (我的)
        StatefulShellBranch(
          navigatorKey: _profileNavigatorKey,
          routes: [
            GoRoute(
              path: Routes.profile,
              pageBuilder: (context, state) =>
                  state.slidePage(const ProfileWrapper(), direction: SlideDirection.right),
              routes: [
                GoRoute(
                  path: 'account',
                  pageBuilder: (context, state) {
                    final profile = state.extra as Profile? ?? const Profile();
                    return state.slidePage(AccountInfoScreen(originalProfile: profile));
                  },
                ),
                GoRoute(
                  path: 'appearances',
                  pageBuilder: (context, state) =>
                      state.slidePage(const AppearancesScreen()),
                ),
                GoRoute(
                  path: 'languages',
                  pageBuilder: (context, state) =>
                      state.slidePage(const LanguagesScreen()),
                ),
                GoRoute(
                  path: 'premium',
                  pageBuilder: (context, state) => state.slidePage(
                    const PremiumScreen(),
                    direction: SlideDirection.up,
                  ),
                ),
                GoRoute(
                  path: 'bookings',
                  pageBuilder: (context, state) =>
                      state.slidePage(const MyBookingsScreen()),
                ),
                GoRoute(
                  path: 'activity-signups',
                  pageBuilder: (context, state) =>
                      state.slidePage(const MyActivitySignupsScreen()),
                ),
                GoRoute(
                  path: 'orders',
                  pageBuilder: (context, state) =>
                      state.slidePage(const MyOrdersScreen()),
                ),
              ],
            ),
          ],
        ),
      ],
    ),
  ],
);
