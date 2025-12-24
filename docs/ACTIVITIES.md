# FARM-T07: Activities Feature

## 概述
活动列表/详情/报名功能，用户可以浏览活动、查看详情并进行报名（带人数/数量选择）。

## 功能特性

### 1. 活动列表
- 展示所有可用活动
- 列表显示：活动名、时间、地点、费用
- 支持下拉刷新

### 2. 活动详情
- 活动图片
- 活动名称
- 活动时间和地点
- 活动介绍/描述
- 费用信息（元/人）
- 数量选择器（增减按钮）
- 备注输入框（可选）
- 总价计算（费用 × 数量）
- 报名按钮

### 3. 活动报名
- 登录验证（未登录时引导至登录页面）
- 创建报名记录到 `activity_signups` 表
- 包含：用户ID、活动ID、数量、总价、备注
- 报名成功后显示提示信息

### 4. 我的报名记录
- 在个人中心"我的-活动报名记录"查看
- 显示报名的活动信息（名称、图片、地点）
- 显示报名数量、总价、状态
- 显示备注和报名时间
- 状态标签（待确认/已确认/已取消）

## 数据库结构

### activity_signups 表
```sql
CREATE TABLE public.activity_signups (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id UUID NOT NULL REFERENCES auth.users(id) ON DELETE CASCADE,
  activity_id UUID NOT NULL REFERENCES public.listings(id) ON DELETE CASCADE,
  qty INTEGER NOT NULL DEFAULT 1 CHECK (qty > 0),
  total_price DECIMAL(10, 2) NOT NULL CHECK (total_price >= 0),
  note TEXT,
  status TEXT NOT NULL DEFAULT 'pending' CHECK (status IN ('pending', 'confirmed', 'cancelled')),
  created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);
```

### 索引
- `idx_activity_signups_user_id`: 用户ID索引（加速用户报名记录查询）
- `idx_activity_signups_activity_id`: 活动ID索引（加速活动报名查询）

### RLS 策略
- 用户只能查看自己的报名记录
- 用户只能创建属于自己的报名记录
- 用户只能更新自己的报名记录

## 技术实现

### 数据模型
- **ActivitySignup**: Freezed 模型，包含报名信息
  - id: 报名ID
  - userId: 用户ID
  - activityId: 活动ID
  - qty: 数量
  - totalPrice: 总价
  - note: 备注
  - status: 状态（pending/confirmed/cancelled）
  - createdAt: 创建时间
  - updatedAt: 更新时间

### Repository 层
**ActivityRepository** 提供以下方法：
- `fetchActivities()`: 获取所有活动列表
- `fetchActivityDetail(activityId)`: 获取活动详情
- `createSignup(...)`: 创建报名记录
- `fetchMySignups(userId)`: 获取用户的报名记录
- `fetchActivityBySignup(activityId)`: 根据报名记录获取活动信息

### ViewModel 层
**使用 Riverpod 进行状态管理：**
- `activityRepositoryProvider`: Repository 提供者
- `activitiesProvider`: 活动列表提供者
- `activityDetailProvider`: 活动详情提供者（带参数）
- `activitySignupViewModelProvider`: 报名状态管理
- `myActivitySignupsProvider`: 用户报名记录提供者（带参数）
- `activityBySignupProvider`: 活动信息提供者（带参数）

### UI 界面
1. **ActivityDetailScreen**
   - 活动详情展示
   - 数量选择器（+ / - 按钮）
   - 备注输入框
   - 实时计算总价
   - 登录验证
   - 报名提交

2. **MyActivitySignupsScreen**
   - 报名记录列表
   - 卡片式展示
   - 状态标签（颜色区分）
   - 下拉刷新
   - 空状态提示

### 路由配置
- `/shell/activity/detail/:id` - 活动详情页
- `/shell/profile/activity-signups` - 我的报名记录

## 国际化
新增翻译键（中英文）：
- `myActivitySignups`: 活动报名记录
- `signupActivity`: 报名活动
- `signupSuccess`: 报名成功！
- `signupError`: 报名失败
- `signupRecords`: 报名记录
- `signupStatus`: 报名状态
- `quantity`: 数量
- `selectQuantity`: 选择数量
- `quantityRequired`: 请选择数量
- `addNote`: 添加备注（可选）
- `fee`: 费用
- `perPerson`: 元/人 | /person

## 使用流程

### 1. 浏览活动
1. 进入"活动"标签
2. 查看活动列表（活动名、时间、地点、费用）
3. 点击活动卡片进入详情

### 2. 报名活动
1. 在活动详情页查看完整信息
2. 使用 +/- 按钮选择数量
3. 可选择填写备注
4. 查看总价（自动计算）
5. 点击"报名活动"按钮
6. 如未登录，跳转到登录页面
7. 登录后完成报名

### 3. 查看报名记录
1. 进入"我的"标签
2. 点击"活动报名记录"
3. 查看所有报名历史
4. 查看报名详情（活动、数量、总价、状态）

## DoD（完成标准）验证

✅ **登录后可报名成功**
- 实现了登录验证逻辑
- 未登录时显示登录引导对话框
- 登录后可成功创建报名记录

✅ **"我的-活动报名记录"可见**
- 在个人中心添加了"活动报名记录"入口
- 实现了报名记录列表界面
- 显示完整的报名信息和状态

✅ **docs/ACTIVITIES.md**
- 创建了完整的功能文档
- 包含功能说明、数据库结构、技术实现、使用流程

## 部署步骤

1. **运行数据库迁移**
   ```bash
   supabase db push
   ```

2. **生成代码**
   ```bash
   flutter pub run build_runner build --delete-conflicting-outputs
   ```

3. **运行应用**
   ```bash
   flutter run -d chrome
   ```

## 注意事项

1. **数据关联**
   - 活动数据存储在 `listings` 表中，`type='activity'`
   - 报名记录关联到 `listings.id`

2. **权限控制**
   - 使用 RLS 确保用户只能访问自己的报名记录
   - 前端进行登录状态验证

3. **状态管理**
   - pending: 待确认
   - confirmed: 已确认
   - cancelled: 已取消

4. **价格计算**
   - 总价 = 活动费用 × 数量
   - 客户端实时计算显示
   - 服务端写入时也进行计算

## 相关文件

### 数据库
- `supabase/migrations/20251222000005_create_activity_signups.sql`

### 数据模型
- `lib/features/listings/model/activity_signup.dart`

### Repository
- `lib/features/listings/repository/activity_repository.dart`

### ViewModel
- `lib/features/listings/view_model/activity_view_model.dart`

### UI
- `lib/features/listings/ui/activity_detail_screen.dart`
- `lib/features/listings/ui/my_activity_signups_screen.dart`
- `lib/features/profile/ui/profile_screen.dart` (添加入口)

### 路由
- `lib/routing/routes.dart` (添加路由常量)
- `lib/routing/router.dart` (配置路由)

### 国际化
- `assets/translations/zh.json`
- `assets/translations/en.json`
