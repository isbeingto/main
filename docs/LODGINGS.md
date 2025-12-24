# Lodgings Feature (民宿功能)

## 概述

民宿功能允许用户浏览民宿列表、查看详情、选择入住日期并创建预订记录。本功能专注于预订流程，暂不涉及库存锁定和支付功能。

## 功能特性

### 1. 民宿列表
- 展示所有可用民宿
- 显示信息：名称、位置、价格/晚、缩略图
- 下拉刷新功能
- 点击卡片进入详情页

### 2. 民宿详情
- 完整的民宿信息展示
  - 图片轮播
  - 标题和价格
  - 位置信息
  - 房间信息（卧室、浴室、最大入住人数）
  - 设施列表
  - 详细描述
- 日期范围选择器（Date Range Picker）
- 入住人数选择
- 备注输入
- 立即预订按钮

### 3. 预订记录
- "我的"页面入口
- 查看所有预订记录
- 显示信息：
  - 预订状态（待确认/已确认/已取消/已完成）
  - 入住/退房日期
  - 入住天数
  - 入住人数
  - 总价
  - 备注
- 下拉刷新功能

## 技术架构

### 数据层

#### 数据库表

**listings** (民宿信息表 - 已存在)
```sql
CREATE TABLE listings (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    title TEXT NOT NULL,
    description TEXT,
    location TEXT,
    price_per_night DECIMAL(10, 2),
    max_guests INTEGER DEFAULT 2,
    bedrooms INTEGER DEFAULT 1,
    bathrooms INTEGER DEFAULT 1,
    amenities TEXT[],
    host_id UUID REFERENCES auth.users(id),
    is_active BOOLEAN DEFAULT true,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ DEFAULT NOW()
);
```

**lodging_bookings** (预订记录表 - 新创建)
```sql
CREATE TABLE lodging_bookings (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    user_id UUID NOT NULL REFERENCES auth.users(id) ON DELETE CASCADE,
    lodging_id UUID NOT NULL REFERENCES listings(id) ON DELETE CASCADE,
    start_date DATE NOT NULL,
    end_date DATE NOT NULL,
    nights INTEGER NOT NULL,
    total_price DECIMAL(10, 2) NOT NULL DEFAULT 0,
    guests INTEGER DEFAULT 1,
    status TEXT DEFAULT 'pending',
    note TEXT,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ DEFAULT NOW()
);
```

#### RLS 策略

**lodging_bookings 表：**
- SELECT: 用户只能查看自己的预订记录
- INSERT: 登录用户可以创建预订
- UPDATE: 用户可以更新自己的预订（如取消）

### 数据模型

**Listing** (Freezed)
- 民宿基础信息
- 关联 ListingPhoto

**LodgingBooking** (Freezed)
- 预订记录信息
- 包含日期、价格、状态等

### Repository 层

**LodgingRepository**
- `fetchLodgings()` - 获取民宿列表
- `fetchLodgingDetail(id)` - 获取民宿详情
- `createBooking()` - 创建预订记录
- `fetchMyBookings(userId)` - 获取用户的预订记录

### ViewModel 层

**LodgingViewModel**
- 管理民宿列表状态
- 支持刷新操作

**LodgingDetailViewModel**
- 管理单个民宿详情状态

**LodgingBookingViewModel**
- 处理预订创建逻辑
- 管理预订状态

**MyBookingsViewModel**
- 管理用户的预订记录列表
- 支持刷新操作

### UI 层

**ListingsScreen** (已存在)
- 民宿列表展示
- 使用卡片布局
- 支持下拉刷新

**LodgingDetailScreen** (新创建)
- 民宿详情展示
- 日期范围选择器
- 入住人数选择器
- 预订表单

**MyBookingsScreen** (新创建)
- 预订记录列表
- 状态展示
- 详细信息展示

## 用户流程

### 浏览民宿
1. 用户进入"民宿"标签
2. 查看民宿列表
3. 点击感兴趣的民宿

### 预订民宿
1. 在详情页查看民宿信息
2. 选择入住和退房日期
3. 选择入住人数
4. 填写备注（可选）
5. 点击"立即预订"
6. 如未登录，跳转到登录页
7. 登录后创建预订记录
8. 显示预订成功提示

### 查看预订记录
1. 进入"我的"标签
2. 点击"我的预订"
3. 查看所有预订记录
4. 查看预订详情和状态

## 权限要求

- **浏览民宿**：无需登录
- **创建预订**：需要登录
- **查看预订记录**：需要登录

## 数据库迁移

文件：`supabase/migrations/20251222000004_create_lodging_bookings.sql`

执行命令：
```bash
supabase db push
```

## 国际化

已添加以下翻译键：
- `lodgings` - 民宿列表
- `lodgingDetail` - 民宿详情
- `bookLodging` - 立即预订
- `bookingSuccess` - 预订成功
- `bookingError` - 预订失败
- `myBookings` - 我的预订
- `bookingRecords` - 预订记录
- `bookingStatus` - 预订状态
- `statusPending` - 待确认
- `statusConfirmed` - 已确认
- `statusCancelled` - 已取消
- `statusCompleted` - 已完成
- `checkIn` - 入住日期
- `checkOut` - 退房日期
- `totalNights` - 共计
- `nights` - 晚
- `totalPrice` - 总价
- `guestCount` - 入住人数
- `selectDateRange` - 选择入住日期范围
- `dateRangeRequired` - 请选择入住和退房日期

## 路由配置

新增路由：
- `/shell/profile/bookings` - 我的预订页面

更新路由：
- `/shell/lodging/detail/:id` - 使用新的 `LodgingDetailScreen`

## 待实现功能（未来迭代）

1. **库存管理**
   - 日期可用性检查
   - 库存锁定机制
   - 重复预订冲突检测

2. **支付集成**
   - 在线支付功能
   - 订单状态自动更新
   - 退款处理

3. **预订管理**
   - 用户取消预订
   - 房东确认/拒绝预订
   - 预订修改功能

4. **通知功能**
   - 预订确认通知
   - 入住提醒
   - 状态变更通知

5. **评价系统**
   - 用户评价民宿
   - 评分展示
   - 评论管理

## 测试建议

### 数据准备
1. 确保 `listings` 表有测试数据
2. 测试不同价格和设施的民宿

### 功能测试
1. 未登录状态浏览民宿 ✓
2. 登录后创建预订 ✓
3. 查看预订记录 ✓
4. 日期选择器功能 ✓
5. 价格计算正确性 ✓

### 边界测试
1. 同一天入住退房（0晚）
2. 超过最大入住人数
3. 选择过去的日期
4. 空民宿列表
5. 空预订记录

## 代码质量

- ✅ 使用 Freezed 进行不可变数据模型
- ✅ 使用 Riverpod 进行状态管理
- ✅ 完整的错误处理
- ✅ 国际化支持
- ✅ RLS 安全策略
- ✅ 响应式 UI 设计

## 相关文件

### 数据库
- `supabase/migrations/20251222000001_create_listings_schema.sql`
- `supabase/migrations/20251222000004_create_lodging_bookings.sql`

### 模型
- `lib/features/listings/model/listing.dart`
- `lib/features/listings/model/lodging_booking.dart`

### Repository
- `lib/features/listings/repository/lodging_repository.dart`

### ViewModel
- `lib/features/listings/view_model/lodging_view_model.dart`
- `lib/features/listings/view_model/booking_view_model.dart`

### UI
- `lib/features/listings/ui/listings_screen.dart`
- `lib/features/listings/ui/lodging_detail_screen.dart`
- `lib/features/listings/ui/my_bookings_screen.dart`

### 路由
- `lib/routing/router.dart`
- `lib/routing/routes.dart`

## 总结

FARM-T06 民宿功能已完整实现：
- ✅ 完整的数据层（数据库表、模型、Repository）
- ✅ 完整的业务逻辑层（ViewModels）
- ✅ 完整的 UI 层（列表、详情、预订记录）
- ✅ 日期范围选择器
- ✅ 完整的权限控制（RLS）
- ✅ 国际化支持
- ✅ 路由集成

功能满足 DoD（Definition of Done）：
1. ✅ 登录后能创建 booking record
2. ✅ "我的-民宿预订记录"能看到
3. ✅ docs/LODGINGS.md 已创建
