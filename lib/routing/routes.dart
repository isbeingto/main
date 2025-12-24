/// Route path constants for the application
class Routes {
  Routes._();

  // Auth routes
  static const splash = '/';
  static const register = '/register';
  static const login = '/login';
  static const onboarding = '/onboarding';

  // Main shell (bottom tab navigation)
  static const shell = '/shell';

  // Tab 1: Home (首页)
  static const home = '/shell/home';
  static const homeProductDetail = '/shell/home/product/:id';

  // Tab 2: Lodging (民宿)
  static const lodging = '/shell/lodging';
  static const lodgingDetail = '/shell/lodging/detail/:id';

  // Tab 3: Activity (活动)
  static const activity = '/shell/activity';
  static const activityDetail = '/shell/activity/detail/:id';

  // Tab 4: Profile (我的)
  static const profile = '/shell/profile';
  static const accountInformation = '/shell/profile/account';
  static const appearances = '/shell/profile/appearances';
  static const languages = '/shell/profile/languages';
  static const premium = '/shell/profile/premium';
  static const myBookings = '/shell/profile/bookings';
  static const myActivitySignups = '/shell/profile/activity-signups';
  static const myOrders = '/shell/profile/orders';

  // Helper methods for parameterized routes
  static String homeProductDetailPath(String id) => '/shell/home/product/$id';
  static String lodgingDetailPath(String id) => '/shell/lodging/detail/$id';
  static String activityDetailPath(String id) => '/shell/activity/detail/$id';
}
