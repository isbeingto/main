# 路由文档 (ROUTES.md)

## 概述

本应用使用 **go_router** 实现导航，采用 `StatefulShellRoute.indexedStack` 实现类似微信小程序的底部 Tab 导航结构。每个 Tab 拥有独立的导航栈，支持页面间的独立前进/后退。

## 路由架构

```
/                           <- 启动页 (Splash)
├── /register               <- 注册页
├── /login                  <- 登录页
├── /otp                    <- 验证码页
├── /onboarding             <- 引导页
└── /shell                  <- 主 Shell (底部导航容器)
    ├── /shell/home         <- Tab 1: 首页
    │   └── /shell/home/product/:id    <- 商品详情
    ├── /shell/lodging      <- Tab 2: 民宿
    │   └── /shell/lodging/detail/:id  <- 民宿详情
    ├── /shell/activity     <- Tab 3: 活动
    │   └── /shell/activity/detail/:id <- 活动详情
    └── /shell/profile      <- Tab 4: 我的
        ├── /shell/profile/account     <- 账户信息
        ├── /shell/profile/appearances <- 外观设置
        ├── /shell/profile/languages   <- 语言设置
        └── /shell/profile/premium     <- 高级会员
```

## 路由表

| 路径 | 页面 | 说明 | 参数 |
|------|------|------|------|
| `/` | `SplashScreen` | 启动页 | - |
| `/register` | `RegisterScreen` | 注册页 | - |
| `/login` | `SignInScreen` | 登录页 | - |
| `/otp` | `OtpScreen` | 验证码页 | `extra: {email, isRegister}` |
| `/onboarding` | `OnboardingScreen` | 引导页 | - |
| `/shell/home` | `HomeScreen` | 首页（商品列表） | - |
| `/shell/home/product/:id` | `ProductDetailScreen` | 商品详情 | `id: String` |
| `/shell/lodging` | `ListingsScreen` | 民宿列表 | - |
| `/shell/lodging/detail/:id` | `ListingDetailScreen` | 民宿详情 | `id: String` |
| `/shell/activity` | `ActivityListScreen` | 活动列表 | - |
| `/shell/activity/detail/:id` | `ActivityDetailScreen` | 活动详情 | `id: String` |
| `/shell/profile` | `ProfileScreen` | 个人中心 | - |
| `/shell/profile/account` | `AccountInfoScreen` | 账户信息 | `extra: Profile` |
| `/shell/profile/appearances` | `AppearancesScreen` | 外观设置 | - |
| `/shell/profile/languages` | `LanguagesScreen` | 语言设置 | - |
| `/shell/profile/premium` | `PremiumScreen` | 高级会员 | - |

## 路由常量

所有路由路径定义在 `lib/routing/routes.dart`：

```dart
class Routes {
  // 认证路由
  static const splash = '/';
  static const register = '/register';
  static const login = '/login';
  static const otp = '/otp';
  static const onboarding = '/onboarding';

  // 主 Shell
  static const home = '/shell/home';
  static const lodging = '/shell/lodging';
  static const activity = '/shell/activity';
  static const profile = '/shell/profile';

  // 嵌套路由
  static const accountInformation = '/shell/profile/account';
  static const appearances = '/shell/profile/appearances';
  static const languages = '/shell/profile/languages';
  static const premium = '/shell/profile/premium';

  // 动态路由辅助方法
  static String homeProductDetailPath(String id) => '/shell/home/product/$id';
  static String lodgingDetailPath(String id) => '/shell/lodging/detail/$id';
  static String activityDetailPath(String id) => '/shell/activity/detail/$id';
}
```

## 导航使用示例

### 1. Tab 内导航（推入详情页）

```dart
// 从首页进入商品详情
context.push(Routes.homeProductDetailPath('product_123'));

// 从民宿列表进入详情
context.push(Routes.lodgingDetailPath('listing_456'));

// 从活动列表进入详情
context.push(Routes.activityDetailPath('activity_789'));
```

### 2. Tab 间切换

Tab 切换由 `AppShell` 自动处理，使用 `StatefulNavigationShell.goBranch()`:

```dart
void _onTap(int index) {
  navigationShell.goBranch(
    index,
    // 若点击当前 Tab，返回该 Tab 的初始页面
    initialLocation: index == navigationShell.currentIndex,
  );
}
```

### 3. 传递参数

```dart
// 使用 extra 传递对象
context.push(
  Routes.accountInformation,
  extra: profile,
);

// 在目标页面获取
final profile = GoRouterState.of(context).extra as Profile;
```

### 4. 替换当前页面

```dart
// 登录成功后替换到首页
context.go(Routes.home);
```

## Deep Link 示例

| Deep Link | 目标页面 |
|-----------|----------|
| `farmapp://app/shell/home` | 首页 |
| `farmapp://app/shell/lodging` | 民宿列表 |
| `farmapp://app/shell/lodging/detail/abc123` | 民宿详情页 |
| `farmapp://app/shell/activity` | 活动列表 |
| `farmapp://app/shell/profile` | 个人中心 |

## 导航栈行为

### 独立导航栈

每个 Tab 使用独立的 `GlobalKey<NavigatorState>`，实现：
- Tab 1 (首页): `_homeNavigatorKey`
- Tab 2 (民宿): `_lodgingNavigatorKey`
- Tab 3 (活动): `_activityNavigatorKey`
- Tab 4 (我的): `_profileNavigatorKey`

### 返回行为

1. **Tab 内返回**：`context.pop()` 或系统返回键返回 Tab 内上一页
2. **Tab 根页面返回**：无任何操作（不会退出 Tab 或切换 Tab）
3. **点击当前 Tab 图标**：返回该 Tab 初始页面并清空导航栈

### 页面过渡动画

使用自定义 `SlideRouteTransition` 实现滑动动画：

```dart
extension GoRouterStateExtension on GoRouterState {
  SlideRouteTransition slidePage(
    Widget child, {
    SlideDirection direction = SlideDirection.left,
  });
}
```

方向选项：
- `SlideDirection.left` - 从右向左滑入（默认）
- `SlideDirection.right` - 从左向右滑入
- `SlideDirection.up` - 从下向上滑入
- `SlideDirection.down` - 从上向下滑入

## 文件结构

```
lib/routing/
├── router.dart      <- GoRouter 配置
├── routes.dart      <- 路由路径常量
└── app_shell.dart   <- 底部导航 Shell 组件
```

## 注意事项

1. **避免路由循环**：不要在 Shell 内使用 `context.go()` 导航到 Shell 外的认证页面
2. **参数类型安全**：使用 `extra` 传递复杂对象时，确保类型转换正确
3. **初始路由**：应用启动时从 `/` (Splash) 开始，根据登录状态跳转
4. **Tab 保活**：使用 `indexedStack` 确保切换 Tab 时保留页面状态
