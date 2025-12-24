# FARM-T08: My Records (我的记录)

## 概述
在"我的"页面实现三条记录入口：商品购买记录、民宿预订记录、活动报名记录。用户可以查看自己的所有历史记录，RLS 策略确保数据隔离。

## 功能特性

### 1. 商品购买记录 (My Orders)
- 查看所有购买的商品订单
- 显示商品信息（图片、名称、描述）
- 显示订单详情（数量、总价、状态、下单时间）
- 订单状态标签（待确认/已支付/已发货/已完成/已取消）
- 支持下拉刷新

### 2. 民宿预订记录 (My Bookings)
- 查看所有民宿预订记录
- 显示民宿信息（图片、名称、地点）
- 显示预订详情（入住/退房日期、晚数、人数、总价、状态）
- 预订状态标签（待确认/已确认/已取消/已完成）
- 支持下拉刷新

### 3. 活动报名记录 (My Activity Signups)
- 查看所有活动报名记录
- 显示活动信息（图片、名称、地点）
- 显示报名详情（数量、总价、状态、报名时间）
- 报名状态标签（待确认/已确认/已取消）
- 支持下拉刷新

## 权限控制

### RLS 策略验证

所有记录表都已启用 Row Level Security (RLS)，确保用户只能访问自己的数据：

#### 1. product_orders 表
```sql
-- 用户只能查看自己的订单
CREATE POLICY "Users can view own orders"
  ON public.product_orders FOR SELECT
  USING (auth.uid() = user_id);

-- 用户只能创建自己的订单
CREATE POLICY "Users can create own orders"
  ON public.product_orders FOR INSERT
  WITH CHECK (auth.uid() = user_id);
```

#### 2. lodging_bookings 表
```sql
-- 用户只能查看自己的预订
CREATE POLICY "Users can view own lodging bookings"
  ON public.lodging_bookings FOR SELECT
  USING (auth.uid() = user_id);

-- 用户只能创建自己的预订
CREATE POLICY "Users can create own lodging bookings"
  ON public.lodging_bookings FOR INSERT
  WITH CHECK (auth.uid() = user_id);

-- 用户只能更新自己的预订
CREATE POLICY "Users can update own lodging bookings"
  ON public.lodging_bookings FOR UPDATE
  USING (auth.uid() = user_id)
  WITH CHECK (auth.uid() = user_id);
```

#### 3. activity_signups 表
```sql
-- 用户只能查看自己的报名记录
CREATE POLICY "Users can view own activity signups"
  ON public.activity_signups FOR SELECT
  USING (auth.uid() = user_id);

-- 用户只能创建自己的报名记录
CREATE POLICY "Users can create own activity signups"
  ON public.activity_signups FOR INSERT
  WITH CHECK (auth.uid() = user_id);

-- 用户只能更新自己的报名记录
CREATE POLICY "Users can update own activity signups"
  ON public.activity_signups FOR UPDATE
  USING (auth.uid() = user_id)
  WITH CHECK (auth.uid() = user_id);
```

### 登录验证

所有记录页面都实现了登录验证：
- **未登录时**：显示登录引导界面，提示用户登录
- **登录后**：显示用户自己的记录数据

## 数据结构

### 1. product_orders 表
```sql
CREATE TABLE public.product_orders (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id UUID NOT NULL REFERENCES auth.users(id) ON DELETE CASCADE,
  product_id UUID NOT NULL REFERENCES public.products(id) ON DELETE SET NULL,
  quantity INTEGER NOT NULL DEFAULT 1,
  total_price DECIMAL(10, 2) NOT NULL DEFAULT 0,
  status TEXT DEFAULT 'pending', -- 'pending', 'paid', 'shipped', 'completed', 'cancelled'
  created_at TIMESTAMPTZ DEFAULT NOW(),
  updated_at TIMESTAMPTZ DEFAULT NOW()
);
```

### 2. lodging_bookings 表
```sql
CREATE TABLE public.lodging_bookings (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id UUID NOT NULL REFERENCES auth.users(id) ON DELETE CASCADE,
  lodging_id UUID NOT NULL REFERENCES public.listings(id) ON DELETE CASCADE,
  start_date DATE NOT NULL,
  end_date DATE NOT NULL,
  nights INTEGER NOT NULL CHECK (nights > 0),
  total_price DECIMAL(10, 2) NOT NULL CHECK (total_price >= 0),
  guests INTEGER DEFAULT 1,
  status TEXT NOT NULL DEFAULT 'pending', -- 'pending', 'confirmed', 'cancelled', 'completed'
  note TEXT,
  created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);
```

### 3. activity_signups 表
```sql
CREATE TABLE public.activity_signups (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id UUID NOT NULL REFERENCES auth.users(id) ON DELETE CASCADE,
  activity_id UUID NOT NULL REFERENCES public.listings(id) ON DELETE CASCADE,
  qty INTEGER NOT NULL DEFAULT 1 CHECK (qty > 0),
  total_price DECIMAL(10, 2) NOT NULL CHECK (total_price >= 0),
  note TEXT,
  status TEXT NOT NULL DEFAULT 'pending', -- 'pending', 'confirmed', 'cancelled'
  created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);
```

## 技术实现

### Repository 层

#### ProductRepository
- `getMyOrders(userId)`: 获取用户的商品订单
- `getProductByOrder(productId)`: 根据订单获取商品信息

#### LodgingRepository
- `fetchMyBookings(userId)`: 获取用户的民宿预订
- `fetchLodgingByBooking(lodgingId)`: 根据预订获取民宿信息

#### ActivityRepository
- `fetchMySignups(userId)`: 获取用户的活动报名
- `fetchActivityBySignup(activityId)`: 根据报名获取活动信息

### ViewModel 层

使用 Riverpod 进行状态管理：

```dart
// 商品订单
@riverpod
Future<List<ProductOrder>> myOrders(Ref ref, String userId);

@riverpod
Future<Product?> productByOrder(Ref ref, String productId);

// 民宿预订
final myBookingsProvider = FutureProvider.family<List<LodgingBooking>, String>;
final lodgingByBookingProvider = FutureProvider.family<Listing?, String>;

// 活动报名
final myActivitySignupsProvider = FutureProvider.family<List<ActivitySignup>, String>;
final activityBySignupProvider = FutureProvider.family<Listing?, String>;
```

### UI 界面

所有记录页面采用统一的设计模式：

1. **AppBar**：显示页面标题
2. **登录验证**：未登录时显示引导界面
3. **空状态**：无数据时显示友好提示
4. **列表展示**：卡片式布局，清晰展示记录信息
5. **状态标签**：使用颜色区分不同状态
6. **下拉刷新**：支持手动刷新数据
7. **错误处理**：网络错误时提供重试功能

## UI 组件

### MyOrdersScreen
- 位置：`lib/features/products/ui/my_orders_screen.dart`
- 展示字段：
  - 商品图片
  - 商品名称和描述
  - 购买数量
  - 总价
  - 订单状态（颜色标签）
  - 下单时间

### MyBookingsScreen
- 位置：`lib/features/listings/ui/my_bookings_screen.dart`
- 展示字段：
  - 民宿图片
  - 民宿名称和地点
  - 入住/退房日期
  - 晚数和人数
  - 总价
  - 预订状态（颜色标签）
  - 预订时间

### MyActivitySignupsScreen
- 位置：`lib/features/listings/ui/my_activity_signups_screen.dart`
- 展示字段：
  - 活动图片
  - 活动名称和地点
  - 报名数量
  - 总价
  - 报名状态（颜色标签）
  - 备注
  - 报名时间

## 路由配置

```dart
// routes.dart
static const myOrders = '/shell/profile/orders';
static const myBookings = '/shell/profile/bookings';
static const myActivitySignups = '/shell/profile/activity-signups';

// router.dart
GoRoute(
  path: 'orders',
  pageBuilder: (context, state) => state.slidePage(const MyOrdersScreen()),
),
GoRoute(
  path: 'bookings',
  pageBuilder: (context, state) => state.slidePage(const MyBookingsScreen()),
),
GoRoute(
  path: 'activity-signups',
  pageBuilder: (context, state) => state.slidePage(const MyActivitySignupsScreen()),
),
```

## 国际化

新增翻译键（中英文）：
- `myOrders`: 商品购买记录 / My Orders
- `orderRecords`: 购买记录 / Order Records
- `orderStatus`: 订单状态 / Order Status
- `statusPaid`: 已支付 / Paid
- `statusShipped`: 已发货 / Shipped
- `orderQuantity`: 购买数量 / Quantity
- `orderTime`: 下单时间 / Order Time

## 使用流程

### 查看商品购买记录
1. 进入"我的"标签
2. 点击"商品购买记录"
3. 查看所有购买的商品订单
4. 查看订单详情和状态

### 查看民宿预订记录
1. 进入"我的"标签
2. 点击"民宿预订记录"
3. 查看所有民宿预订
4. 查看预订详情和状态

### 查看活动报名记录
1. 进入"我的"标签
2. 点击"活动报名记录"
3. 查看所有活动报名
4. 查看报名详情和状态

## DoD（完成标准）验证

| 要求 | 状态 | 说明 |
|------|------|------|
| 未登录：不可进入记录页 | ✅ | 所有记录页都实现了登录验证和引导界面 |
| 登录：能看到自己数据 | ✅ | 使用 user.id 过滤数据，只显示当前用户的记录 |
| 登录：看不到他人数据 | ✅ | RLS 策略在数据库层面确保数据隔离 |
| docs/RECORDS.md | ✅ | 已创建完整文档 |

## 安全特性

### 1. 数据库层面（RLS）
- 所有表都启用了 Row Level Security
- 用户只能访问 `user_id = auth.uid()` 的数据
- 即使绕过前端验证，数据库也会拒绝非法访问

### 2. 应用层面
- 前端检查 `Supabase.instance.client.auth.currentUser`
- 未登录时显示登录引导，不发起数据请求
- 使用当前用户 ID 作为查询参数

### 3. UI 层面
- 未登录时隐藏敏感信息
- 登录后才显示个人数据
- 错误时不暴露其他用户数据

## 状态说明

### 订单状态 (product_orders.status)
- `pending`: 待确认（橙色）
- `paid`: 已支付（蓝色）
- `shipped`: 已发货（紫色）
- `completed`: 已完成（绿色）
- `cancelled`: 已取消（红色）

### 预订状态 (lodging_bookings.status)
- `pending`: 待确认（橙色）
- `confirmed`: 已确认（绿色）
- `cancelled`: 已取消（红色）
- `completed`: 已完成（绿色）

### 报名状态 (activity_signups.status)
- `pending`: 待确认（橙色）
- `confirmed`: 已确认（绿色）
- `cancelled`: 已取消（红色）

## 相关文件

### 数据库迁移
- `supabase/migrations/20251222000003_create_products_schema.sql` (商品订单)
- `supabase/migrations/20251222000004_create_lodging_bookings.sql` (民宿预订)
- `supabase/migrations/20251222000005_create_activity_signups.sql` (活动报名)

### 数据模型
- `lib/features/products/model/product_order.dart`
- `lib/features/listings/model/lodging_booking.dart`
- `lib/features/listings/model/activity_signup.dart`

### Repository
- `lib/features/products/repository/product_repository.dart`
- `lib/features/listings/repository/lodging_repository.dart`
- `lib/features/listings/repository/activity_repository.dart`

### ViewModel
- `lib/features/products/ui/view_model/order_view_model.dart`
- `lib/features/listings/view_model/booking_view_model.dart`
- `lib/features/listings/view_model/activity_view_model.dart`

### UI
- `lib/features/products/ui/my_orders_screen.dart`
- `lib/features/listings/ui/my_bookings_screen.dart`
- `lib/features/listings/ui/my_activity_signups_screen.dart`
- `lib/features/profile/ui/profile_screen.dart` (入口)

### 路由
- `lib/routing/routes.dart`
- `lib/routing/router.dart`

### 国际化
- `assets/translations/zh.json`
- `assets/translations/en.json`

## 测试建议

### 1. 登录验证测试
- 未登录时尝试进入各记录页面
- 验证是否显示登录引导界面
- 登录后验证数据加载

### 2. 数据隔离测试
- 创建多个测试账号
- 每个账号创建不同的记录
- 验证用户只能看到自己的记录

### 3. RLS 策略测试
在 Supabase Dashboard 中执行：
```sql
-- 以特定用户身份查询
SET LOCAL "request.jwt.claims" = '{"sub":"user-uuid-here"}';
SELECT * FROM product_orders;
SELECT * FROM lodging_bookings;
SELECT * FROM activity_signups;
```

### 4. 功能测试
- 测试下拉刷新
- 测试空状态显示
- 测试错误处理和重试
- 测试状态标签显示

## 部署步骤

所有数据库迁移已在之前的任务中完成：
```bash
# 已执行
supabase db push
```

生成代码并运行：
```bash
# 生成国际化键
dart run easy_localization:generate -f keys -o locale_keys.g.dart --source-dir assets/translations --output-dir lib/generated

# 生成 Riverpod 代码
flutter pub run build_runner build --delete-conflicting-outputs

# 运行应用
flutter run -d chrome
```

## 注意事项

1. **性能优化**
   - 使用分页加载大量记录
   - 图片使用缓存机制
   - 合理使用 RefreshIndicator

2. **用户体验**
   - 提供清晰的空状态提示
   - 状态标签使用直观的颜色
   - 错误时提供重试功能

3. **数据安全**
   - 依赖 RLS 策略确保数据隔离
   - 前端验证作为第一道防线
   - 不在前端暴露敏感信息

4. **可扩展性**
   - 订单详情页（点击卡片查看更多信息）
   - 订单筛选功能（按状态、时间筛选）
   - 导出功能（导出订单记录）
