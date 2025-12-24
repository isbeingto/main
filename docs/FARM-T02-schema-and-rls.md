# FARM-T02: Schema and RLS Documentation

## 概述

本文档说明 FARM-T02 任务中创建的数据库表结构、RLS 策略及配置方法。

## 表结构

### 1. listings（房源信息表）

民宿/房源的基础信息表。

| 字段 | 类型 | 描述 |
|------|------|------|
| `id` | UUID | 主键，自动生成 |
| `title` | TEXT | 房源标题（必填） |
| `description` | TEXT | 房源描述 |
| `location` | TEXT | 位置信息 |
| `price_per_night` | DECIMAL(10,2) | 每晚价格 |
| `max_guests` | INTEGER | 最大入住人数，默认 2 |
| `bedrooms` | INTEGER | 卧室数量，默认 1 |
| `bathrooms` | INTEGER | 浴室数量，默认 1 |
| `amenities` | TEXT[] | 设施列表（数组） |
| `host_id` | UUID | 房东用户ID（外键关联 auth.users） |
| `is_active` | BOOLEAN | 是否上架，默认 true |
| `created_at` | TIMESTAMPTZ | 创建时间 |
| `updated_at` | TIMESTAMPTZ | 更新时间（自动更新） |

### 2. listing_photos（房源图片表）

房源的图片信息，支持多图。

| 字段 | 类型 | 描述 |
|------|------|------|
| `id` | UUID | 主键，自动生成 |
| `listing_id` | UUID | 关联的房源ID（外键，级联删除） |
| `photo_url` | TEXT | 图片URL（必填） |
| `caption` | TEXT | 图片说明 |
| `display_order` | INTEGER | 显示顺序，默认 0 |
| `created_at` | TIMESTAMPTZ | 创建时间 |

### 3. booking_requests（预订申请表）

用户提交的预订意向/申请。

| 字段 | 类型 | 描述 |
|------|------|------|
| `id` | UUID | 主键，自动生成 |
| `listing_id` | UUID | 关联的房源ID（外键，级联删除） |
| `user_id` | UUID | 申请用户ID（外键关联 auth.users，级联删除） |
| `start_date` | DATE | 入住日期 |
| `end_date` | DATE | 退房日期 |
| `guests` | INTEGER | 入住人数，默认 1 |
| `note` | TEXT | 备注信息 |
| `status` | TEXT | 状态：pending/approved/rejected/cancelled |
| `created_at` | TIMESTAMPTZ | 创建时间 |
| `updated_at` | TIMESTAMPTZ | 更新时间（自动更新） |

## RLS 策略说明

### listings 表

1. **Anyone can view active listings** (SELECT)
   - 允许任何人（包括匿名用户）查看 `is_active = true` 的房源
   - 用于公开展示房源列表

2. **Hosts can manage their own listings** (ALL)
   - 房东可以管理自己的房源（增删改查）
   - 条件：`auth.uid() = host_id`

### listing_photos 表

1. **Anyone can view listing photos** (SELECT)
   - 允许查看已上架房源的图片
   - 通过关联 listings 表检查 `is_active = true`

2. **Hosts can manage their listing photos** (ALL)
   - 房东可以管理自己房源的图片
   - 通过关联 listings 表检查 `host_id`

### booking_requests 表

1. **Authenticated users can create booking requests** (INSERT)
   - 仅登录用户可以创建预订申请
   - 条件：`auth.uid() = user_id`

2. **Users can view their own booking requests** (SELECT)
   - 用户仅可查看自己的预订申请
   - 条件：`auth.uid() = user_id`

3. **Users can update their own booking requests** (UPDATE)
   - 用户可更新自己的预订申请（如取消）
   - 条件：`auth.uid() = user_id`

## 本地配置

### 1. 创建 `.env` 文件

在项目根目录创建 `.env` 文件（已在 `.gitignore` 中）：

```env
SUPABASE_URL=https://skluusetjxzolthhbuog.supabase.co
SUPABASE_ANON_KEY=your_anon_key_here
GOOGLE_CLIENT_ID=your_google_client_id
GOOGLE_SERVER_CLIENT_ID=your_google_server_client_id
REVENUE_CAT_PLAY_STORE=your_revenuecat_play_store_key
REVENUE_CAT_APP_STORE=your_revenuecat_app_store_key
```

### 2. 获取 Supabase 密钥

1. 登录 [Supabase Dashboard](https://supabase.com/dashboard)
2. 选择项目 → Settings → API
3. 复制 `Project URL` 和 `anon public` key

### 3. 生成代码

运行以下命令生成环境变量代码：

```bash
dart run build_runner build --delete-conflicting-outputs
```

## 迁移操作

### 一键推送迁移

```bash
# 链接项目（首次）
supabase link --project-ref skluusetjxzolthhbuog

# 推送迁移
supabase db push
```

### 验证数据

1. **通过 Supabase Dashboard 验证**
   - 登录 Dashboard → Table Editor
   - 检查 `listings`、`listing_photos`、`booking_requests` 表
   - 确认 seed 数据已插入

2. **通过 Flutter 应用验证**
   ```bash
   flutter run -d chrome
   ```
   - 列表页应显示 5 条 demo 房源
   - 点击房源进入详情页
   - 登录后提交预订申请
   - 在 Dashboard 检查 `booking_requests` 表

## Seed 数据

迁移文件已包含 5 条示例房源：

1. 田园小屋（云南大理）- ¥388/晚
2. 山间别墅（浙江莫干山）- ¥1288/晚
3. 海边度假屋（海南三亚）- ¥688/晚
4. 古镇民宿（江苏周庄）- ¥298/晚
5. 森林树屋（四川峨眉山）- ¥528/晚

每个房源都配有示例图片。

## 文件结构

```
lib/features/listings/
├── model/
│   ├── listing.dart          # 房源模型
│   └── booking_request.dart  # 预订申请模型
├── repository/
│   └── listings_repository.dart  # 数据仓库
├── view_model/
│   ├── listings_view_model.dart  # 列表ViewModel
│   └── booking_view_model.dart   # 预订ViewModel
└── ui/
    ├── listings_screen.dart      # 列表页面
    └── listing_detail_screen.dart # 详情页面
```

## API 接口

### ListingsRepository

```dart
// 获取所有房源（含图片）
Future<List<Listing>> fetchListings()

// 获取房源详情
Future<Listing?> fetchListingDetail(String id)

// 创建预订申请（需登录）
Future<BookingRequest> createBookingRequest({
  required String listingId,
  DateTime? startDate,
  DateTime? endDate,
  int guests = 1,
  String? note,
})

// 检查是否已登录
bool get isAuthenticated
```
