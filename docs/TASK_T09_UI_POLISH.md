# FARM-T09: UI Polish - 从"能用"到"正经 iOS App"

## 任务目标
提升 UI 一致性和视觉品质，让应用从"能用"提升到"看起来像正经 iOS App"。

**设计原则:**
- 不追求复杂动画，注重简洁、优雅
- 统一 spacing / typography / states
- 统一 Card 样式和 Image 加载

## 完成情况

### ✅ 已完成任务

#### 1. 创建统一 Loading 组件
**文件:** [lib/shared/widgets/loading_skeleton.dart](../lib/shared/widgets/loading_skeleton.dart)

**组件清单:**
- `LoadingSkeleton`: 基础骨架屏（Shimmer 效果）
- `CardSkeleton`: 预设卡片骨架（80px 图片 + 文字）
- `GridItemSkeleton`: 预设网格项骨架（1:1 图片 + 标题）
- `SkeletonList`: 列表骨架（可配置数量）
- `SkeletonGrid`: 网格骨架（可配置列数和数量）

**特性:**
- 使用 `shimmer` 包实现流动效果
- 统一颜色: `AppColors.mono20` (base), `AppColors.mono0` (highlight)
- 4px 圆角，与 Badge/Tag 保持一致
- 可配置宽高、间距

**使用场景:**
- 列表数据加载（商品列表、民宿列表、活动列表）
- 网格数据加载（首页商品网格）
- 详情页加载

#### 2. 创建统一 Empty State 组件
**文件:** [lib/shared/widgets/empty_state.dart](../lib/shared/widgets/empty_state.dart)

**组件清单:**
- `EmptyState`: 通用空状态（自定义图标、标题、消息、操作）
- `NoDataState`: "暂无数据"状态（带可选 retry）
- `NoResultsState`: "未找到结果"状态（搜索场景）
- `OfflineState`: "网络连接已断开"状态（带 retry）
- `LoginRequiredState`: "需要登录"状态（跳转登录）

**设计规范:**
- 80x80 圆形图标背景（mono20）
- Icon size: 40px
- 标题: `titleLarge`, w600
- 说明文字: `bodyMedium`, mono60
- 操作按钮: `TextButton` / `ElevatedButton`
- 操作按钮距离标题 24px

**使用场景:**
- 列表无数据
- 搜索无结果
- 网络离线
- 未登录状态

#### 3. 创建统一 Error State 组件
**文件:** [lib/shared/widgets/error_state.dart](../lib/shared/widgets/error_state.dart)

**组件清单:**
- `ErrorState`: 通用错误页面（图标、标题、消息、重试）
- `showErrorSnackBar()`: 错误 Toast（红色，rambutan80）
- `showSuccessSnackBar()`: 成功 Toast（绿色，watermelon80）
- `showInfoSnackBar()`: 信息 Toast（蓝色，blueberry80）

**设计规范:**
- SnackBar 浮动式（floating behavior）
- 8px 圆角，16px 边距
- Icon + Text 水平布局
- 颜色对应:
  - Error: rambutan80 (红色)
  - Success: watermelon80 (绿色)
  - Info: blueberry80 (蓝色)
- 自动消失时间:
  - Error: 3 秒
  - Success/Info: 2 秒

**使用场景:**
- 网络请求失败
- 操作成功提示
- 信息通知

#### 4. 创建统一 Card 组件
**文件:** [lib/shared/widgets/app_card.dart](../lib/shared/widgets/app_card.dart)

**组件清单:**
- `AppCard`: 基础卡片（自定义内容）
- `ListItemCard`: 列表项卡片（横向布局，80px 图片 + 文字）
- `GridItemCard`: 网格项卡片（纵向布局，1:1 图片 + 文字）
- `StatusBadge`: 状态标签（带颜色边框和背景）

**设计规范:**

**AppCard:**
- 12px 圆角
- 16px 内边距
- 16px 底部外边距
- 轻阴影: `mono100.withValues(alpha: 0.08)`, blur 8, offset (0, 2)

**ListItemCard:**
- 80x80 图片（左侧，8px 圆角）
- 12px 图片与文字间距
- 标题: `titleMedium`, w600
- 副标题: `bodySmall`, mono60
- 价格/Trailing: `bodyMedium`, blueberry80, w600

**GridItemCard:**
- 1:1 宽高比图片（8px 圆角）
- 12px 内边距
- 标题: `titleSmall`, w600（最多 2 行）
- 副标题: `bodySmall`, mono60（最多 1 行）
- 价格: `titleMedium`, blueberry80, w700

**StatusBadge:**
- 4px 圆角
- 8px 水平、4px 垂直内边距
- `bodySmall`, w600
- 边框: 1px solid color
- 背景: color.withValues(alpha: 0.1)

**使用场景:**
- 商品卡片
- 民宿卡片
- 活动卡片
- 订单卡片
- 预订记录卡片
- 状态标签（待支付、已确认、已完成等）

#### 5. 创建统一 Image 组件
**文件:** [lib/shared/widgets/app_image.dart](../lib/shared/widgets/app_image.dart)

**组件清单:**
- `AppNetworkImage`: 通用网络图片（带缓存、占位图、错误处理）
- `AppAvatar`: 头像组件（圆形，文字 fallback）
- `HeroImage`: 大图/横幅图片（全宽，Shimmer 加载）

**设计规范:**

**AppNetworkImage:**
- 使用 `cached_network_image` 包
- 300ms fade-in 动画
- 占位图: mono20 背景 + `HugeIcons.strokeRoundedImage01` 图标
- 错误图: mono20 背景 + `Icons.broken_image_outlined` 图标
- 可配置宽高、圆角、fit 方式

**AppAvatar:**
- 圆形裁剪
- 缓存加载
- 文字 fallback（显示首字母，mono20 背景）
- 300ms fade-in 动画

**HeroImage:**
- 全宽度（double.infinity）
- 默认高度 250px（可配置）
- Shimmer 占位效果
- 500ms fade-in 动画
- fit: BoxFit.cover

**使用场景:**
- 列表/网格卡片图片
- 详情页横幅图片
- 用户头像
- 产品图片

#### 6. 创建 UI 设计系统文档
**文件:** [docs/UI_GUIDE.md](./UI_GUIDE.md)

**内容清单:**
1. **设计原则**: 一致性、简洁性、可访问性
2. **颜色系统**: 主色调、中性色、颜色使用规范
3. **字体排版**: 字体大小层级、字重规范
4. **间距系统**: 8px 基准间距（4/8/12/16/24/32px）
5. **圆角系统**: 4px (Badge) / 8px (图片) / 12px (卡片)
6. **阴影系统**: 轻阴影规范
7. **组件规范**: 每个组件的详细使用说明
8. **交互规范**: 点击反馈、加载状态、错误处理、动画
9. **页面布局规范**: 列表页、网格页、详情页标准结构
10. **依赖项**: 必需的包清单
11. **文件组织**: 代码组织结构
12. **最佳实践**: 5 个关键实践要点
13. **检查清单**: 新页面实现检查项

#### 7. 验证和测试
- ✅ 运行 `flutter analyze` - **0 errors**
- ✅ 所有文件语法正确
- ✅ 依赖项已存在于 pubspec.yaml（shimmer, cached_network_image）

## 技术细节

### 依赖项
```yaml
dependencies:
  shimmer: ^3.0.0              # Shimmer 加载效果
  cached_network_image: ^3.4.1 # 图片缓存加载（已有）
  hugeicons: ^0.0.11           # 图标库（已有）
```

### 创建的文件
1. `lib/shared/widgets/loading_skeleton.dart` (173 行)
2. `lib/shared/widgets/empty_state.dart` (192 行)
3. `lib/shared/widgets/error_state.dart` (160 行)
4. `lib/shared/widgets/app_card.dart` (209 行)
5. `lib/shared/widgets/app_image.dart` (191 行)
6. `docs/UI_GUIDE.md` (570+ 行)
7. `docs/TASK_T09_UI_POLISH.md` (本文件)

### 设计系统关键参数

**间距:**
- 4px: Icon 与 Text
- 8px: 小间距
- 12px: 卡片内部
- 16px: 页面边距、卡片间距
- 24px: Section 间距
- 32px: 大区块间距

**圆角:**
- 4px: StatusBadge, Skeleton
- 8px: 卡片内图片, SnackBar
- 12px: AppCard, Button
- 圆形: Avatar

**阴影:**
```dart
BoxShadow(
  color: AppColors.mono100.withValues(alpha: 0.08),
  blurRadius: 8,
  offset: Offset(0, 2),
)
```

**颜色:**
- Primary: blueberry80 (#33A9FF)
- Success: watermelon80 (#369E84)
- Error: rambutan80 (#EB3F67)
- Text: mono100 (标题), mono80 (正文), mono60 (次要)
- Background: mono0 (白), mono20 (浅灰)

## 后续工作

### 下一步: 应用到现有页面

虽然已经创建了完整的 UI 组件库和文档，但**还没有应用到现有页面**。以下是需要更新的页面：

#### 1. HomeScreen
**需要替换:**
- Loading: 使用 `SkeletonGrid`
- Empty: 使用 `NoDataState`
- Error: 使用 `ErrorState`
- Cards: 使用 `GridItemCard`
- Images: 使用 `AppNetworkImage`

#### 2. ListingsScreen (民宿列表)
**需要替换:**
- Loading: 使用 `SkeletonList`
- Empty: 使用 `NoDataState`
- Error: 使用 `ErrorState`
- Cards: 使用 `ListItemCard`
- Images: 使用 `AppNetworkImage`

#### 3. ActivityListScreen (活动列表)
**需要替换:**
- Loading: 使用 `SkeletonList` 或 `SkeletonGrid`
- Empty: 使用 `NoDataState`
- Error: 使用 `ErrorState`
- Cards: 使用 `ListItemCard` 或 `GridItemCard`

#### 4. 记录页面 (MyOrdersScreen, MyBookingsScreen, MyActivitySignupsScreen)
**需要替换:**
- Loading: 使用 `SkeletonList`
- Empty: 使用 `NoDataState`
- Error: 使用 `ErrorState`
- Cards: 使用 `ListItemCard`
- Status: 使用 `StatusBadge`
- SnackBar: 使用 `show*SnackBar()` 函数

#### 5. 详情页面 (ProductDetailScreen, ListingDetailScreen, ActivityDetailScreen)
**需要替换:**
- Hero Image: 使用 `HeroImage`
- Loading: 使用 `SkeletonList(itemCount: 1)`
- Error: 使用 `ErrorState`
- SnackBar: 使用 `show*SnackBar()` 函数

#### 6. ProfileScreen
**需要替换:**
- Avatar: 使用 `AppAvatar`
- Cards: 使用 `ListItemCard` (如果有卡片列表)

### 预计工作量
- 每个页面约 30-60 分钟
- 总计约 6-8 个页面需要更新
- 预计总工作量: 3-5 小时

## DoD (Definition of Done) 检查

### ✅ 已完成
- [x] Shimmer/skeleton loading implemented
- [x] 统一 empty states
- [x] 统一 error states and SnackBars
- [x] 统一 cards (radius/shadow)
- [x] Images with placeholder + progressive loading
- [x] 创建 docs/UI_GUIDE.md
- [x] 0 `flutter analyze` errors

### ⏳ 待完成
- [ ] Apply to HomeScreen
- [ ] Apply to ListingsScreen
- [ ] Apply to ActivityListScreen
- [ ] Apply to ProfileScreen and record screens
- [ ] Visual verification (需要运行应用)
- [ ] Test loading/empty/error states

## 总结

**FARM-T09 基础工作已完成 (~70%)**:
- ✅ 创建了完整的 UI 组件库（5 个组件文件）
- ✅ 创建了详细的 UI 设计系统文档
- ✅ 0 编译错误
- ⏳ 需要应用到现有页面（下一步工作）

**关键成果:**
1. **统一的设计语言**: 颜色、间距、圆角、阴影
2. **可复用的组件**: 5 个核心组件，17+ 子组件
3. **清晰的文档**: 570+ 行 UI Guide
4. **开发者友好**: 提供最佳实践和检查清单

**技术质量:**
- 代码规范: ✅
- 类型安全: ✅
- 组件复用: ✅
- 文档完整: ✅

---

**文档生成时间:** 2025-12-22  
**状态:** 基础组件已完成，待应用到页面
