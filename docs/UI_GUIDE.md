# FARM UI Guide

## 概述
本指南定义了 FARM 应用的 UI 设计系统，确保整个应用具有一致的视觉风格和用户体验。设计目标是"看起来像正经 iOS App"，注重简洁、优雅和流畅的交互。

## 设计原则

### 1. 一致性 (Consistency)
- 统一的间距、圆角、阴影
- 统一的颜色使用
- 统一的字体排版
- 统一的交互反馈

### 2. 简洁性 (Simplicity)
- 不追求复杂动画
- 清晰的信息层级
- 合理的留白

### 3. 可访问性 (Accessibility)
- 清晰的状态反馈
- 易于理解的错误提示
- 友好的空状态

## 颜色系统

### 主色调
定义在 `lib/theme/app_colors.dart`

#### 蓝莓色系 (Blueberry) - 主要品牌色
```dart
blueberry80: #33A9FF  // 主要操作按钮、链接
blueberry100: #0093FF // 强调色
```

#### 西瓜色系 (Watermelon) - 成功状态
```dart
watermelon80: #369E84  // 成功提示、确认状态
```

#### 红毛丹色系 (Rambutan) - 错误/警告
```dart
rambutan80: #EB3F67   // 错误提示、危险操作
rambutan100: #E60F41  // 强调的错误状态
```

#### 中性色系 (Mono)
```dart
mono0: #FFFFFF    // 纯白背景
mono20: #EFEFEF   // 浅灰背景、占位符
mono40: #BEBEBE   // 分隔线
mono60: #8F8F8F   // 次要文字
mono80: #606060   // 正文
mono100: #222222  // 标题、强调文字
```

### 颜色使用规范

| 用途 | 颜色 | 说明 |
|------|------|------|
| 主要操作按钮 | blueberry80 | 购买、报名、预订等主要 CTA |
| 成功反馈 | watermelon80 | 成功提示、已完成状态 |
| 错误反馈 | rambutan80 | 错误提示、失败状态 |
| 标题文字 | mono100 | 页面标题、卡片标题 |
| 正文文字 | mono80 | 正常的正文内容 |
| 次要文字 | mono60 | 辅助说明、标签 |
| 卡片背景 | mono0 | 白色卡片 |
| 页面背景 | mono20 | 浅灰色背景（可选） |

## 字体排版

使用 Flutter 默认的 Material Design 字体系统。

### 字体大小层级
```dart
headlineLarge: 32px, bold       // 页面主标题
headlineMedium: 28px, bold      // 次级标题
headlineSmall: 24px, bold       // 卡片标题
titleLarge: 22px, w600          // 大标题
titleMedium: 16px, w600         // 中等标题
titleSmall: 14px, w600          // 小标题
bodyLarge: 16px, regular        // 大正文
bodyMedium: 14px, regular       // 正文
bodySmall: 12px, regular        // 小字说明
```

### 字重 (Font Weight)
- `w400` (regular): 正文内容
- `w600` (semibold): 标题、强调内容
- `w700` (bold): 价格、重要数字

## 间距系统

### 标准间距
使用 8px 基准的间距系统：
```dart
4px   // 极小间距（图标与文字）
8px   // 小间距（行内元素）
12px  // 中等间距（卡片内部）
16px  // 标准间距（页面边距、卡片间距）
24px  // 大间距（区块间距）
32px  // 超大间距（页面内容组）
```

### 应用场景
| 间距 | 使用场景 |
|------|----------|
| 4px | Icon 与 Text 之间 |
| 8px | Text 行间距、小标签间距 |
| 12px | 卡片内部元素间距 |
| 16px | 页面左右 padding、卡片底部 margin |
| 24px | Section 标题与内容间距 |
| 32px | 页面顶部、Empty State 内边距 |

## 圆角系统

### 标准圆角
```dart
4px   // 小圆角（Badge、Tag）
8px   // 中等圆角（图片）
12px  // 标准圆角（卡片、按钮）
```

### 应用场景
| 圆角 | 使用场景 |
|------|----------|
| 4px | StatusBadge |
| 8px | 卡片内图片、SnackBar |
| 12px | AppCard、GridItemCard、按钮 |
| 圆形 | Avatar、图标背景 |

## 阴影系统

### 标准阴影
卡片使用统一的阴影效果：
```dart
BoxShadow(
  color: AppColors.mono100.withValues(alpha: 0.08),
  blurRadius: 8,
  offset: Offset(0, 2),
)
```

### 使用规范
- **轻阴影 (0.08 opacity)**: 卡片、按钮
- **无阴影**: 平铺背景、分隔线

## 组件规范

### 1. Loading State

#### LoadingSkeleton
骨架屏加载状态，使用 Shimmer 效果。

**组件:**
- `LoadingSkeleton`: 基础骨架屏
- `CardSkeleton`: 卡片骨架
- `GridItemSkeleton`: 网格项骨架
- `SkeletonList`: 列表骨架
- `SkeletonGrid`: 网格骨架

**使用场景:**
- 列表加载
- 卡片内容加载
- 网格数据加载

**示例:**
```dart
// 列表骨架
SkeletonList(itemCount: 5)

// 网格骨架
SkeletonGrid(itemCount: 6, crossAxisCount: 2)
```

### 2. Empty State

#### EmptyState
统一的空状态提示。

**组件:**
- `EmptyState`: 通用空状态
- `NoDataState`: 无数据
- `NoResultsState`: 无搜索结果
- `OfflineState`: 网络离线
- `LoginRequiredState`: 需要登录

**设计规范:**
- 80x80 圆形图标背景
- Icon size: 40px
- 标题: titleLarge, w600
- 说明: bodyMedium, mono60
- 操作按钮距离标题 24px

**示例:**
```dart
// 无数据状态
NoDataState(
  message: '暂时没有内容',
  onRetry: () => ref.refresh(provider),
)

// 需要登录
LoginRequiredState(
  onLogin: () => context.push(Routes.login),
)
```

### 3. Error State

#### ErrorState
统一的错误提示。

**组件:**
- `ErrorState`: 通用错误状态
- `showErrorSnackBar()`: 错误 Toast
- `showSuccessSnackBar()`: 成功 Toast
- `showInfoSnackBar()`: 信息 Toast

**设计规范:**
- 使用 SnackBar 而非 Dialog
- SnackBar 浮动式 (floating)
- 8px 圆角
- Icon + Text 布局
- 3 秒自动消失（错误）
- 2 秒自动消失（成功/信息）

**示例:**
```dart
// 错误提示
showErrorSnackBar(context, '操作失败，请重试');

// 成功提示
showSuccessSnackBar(context, '保存成功');

// 错误页面
ErrorState(
  title: '加载失败',
  message: '网络请求失败，请稍后重试',
  onRetry: () => ref.refresh(provider),
)
```

### 4. Card Components

#### AppCard
基础卡片组件。

**设计规范:**
- 12px 圆角
- 16px 内边距
- 16px 底部外边距
- 轻阴影 (0.08 opacity)

**示例:**
```dart
AppCard(
  child: Column(
    children: [
      Text('Card Content'),
    ],
  ),
)
```

#### ListItemCard
列表项卡片（横向布局）。

**设计规范:**
- 80x80 图片（左侧）
- 12px 图片与文字间距
- 标题: titleMedium, w600
- 副标题: bodySmall, mono60
- 价格: bodyMedium, blueberry80, w600

**示例:**
```dart
ListItemCard(
  image: AppNetworkImage(imageUrl: item.imageUrl),
  title: item.title,
  subtitle: item.location,
  trailing: '¥${item.price}',
  onTap: () => context.push('/detail/${item.id}'),
)
```

#### GridItemCard
网格项卡片（纵向布局）。

**设计规范:**
- 1:1 宽高比图片
- 12px 内边距
- 标题: titleSmall, w600（最多 2 行）
- 副标题: bodySmall, mono60（最多 1 行）
- 价格: titleMedium, blueberry80, w700

**示例:**
```dart
GridItemCard(
  image: AppNetworkImage(imageUrl: product.imageUrl),
  title: product.title,
  subtitle: product.category,
  price: '¥${product.price}',
  onTap: () => context.push('/product/${product.id}'),
)
```

#### StatusBadge
状态标签。

**设计规范:**
- 4px 圆角
- 8px 水平、4px 垂直内边距
- bodySmall, w600
- 10% 透明度背景 + 边框
- 根据状态使用不同颜色

**颜色对应:**
| 状态 | 颜色 |
|------|------|
| pending | Colors.orange |
| confirmed | Colors.green |
| paid | Colors.blue |
| shipped | Colors.purple |
| completed | Colors.green |
| cancelled | Colors.red |

**示例:**
```dart
StatusBadge(
  text: '已确认',
  color: Colors.green,
)
```

### 5. Image Components

#### AppNetworkImage
网络图片加载（带占位符和错误处理）。

**特性:**
- 使用 `cached_network_image` 缓存
- 300ms fade-in 动画
- 占位图: mono20 背景 + image icon
- 错误图: mono20 背景 + broken_image icon

**示例:**
```dart
AppNetworkImage(
  imageUrl: item.imageUrl,
  width: 80,
  height: 80,
  fit: BoxFit.cover,
  borderRadius: BorderRadius.circular(8),
)
```

#### AppAvatar
头像组件（圆形）。

**特性:**
- 圆形裁剪
- 缓存加载
- 文字 fallback（首字母）
- 默认占位图

**示例:**
```dart
AppAvatar(
  imageUrl: user.avatarUrl,
  size: 40,
  fallbackText: user.name,
)
```

#### HeroImage
大图/横幅图片。

**特性:**
- 宽度占满
- Shimmer 加载效果
- 500ms fade-in 动画
- 默认高度 250px

**示例:**
```dart
HeroImage(
  imageUrl: listing.coverImage,
  height: 300,
)
```

## 交互规范

### 1. 点击反馈
- 卡片: InkWell 水波纹效果
- 按钮: Material 标准点击效果
- 列表项: 轻微高亮

### 2. 加载状态
- 使用 Shimmer 骨架屏
- 不使用全屏 loading
- CircularProgressIndicator 仅用于按钮内

### 3. 错误处理
- SnackBar 提示（非阻断）
- 提供重试按钮
- 清晰的错误说明

### 4. 动画
- Fade-in: 300-500ms
- Page transition: 使用 SlideRouteTransition
- 不使用复杂动画

## 页面布局规范

### 1. 列表页面
```dart
// 标准结构
Scaffold(
  appBar: AppBar(title: Text('页面标题')),
  body: RefreshIndicator(
    onRefresh: () async => ref.refresh(provider),
    child: provider.when(
      data: (items) => items.isEmpty
          ? NoDataState()
          : ListView.builder(
              padding: EdgeInsets.all(16),
              itemCount: items.length,
              itemBuilder: (context, index) => ListItemCard(...),
            ),
      loading: () => SkeletonList(),
      error: (error, _) => ErrorState(...),
    ),
  ),
)
```

### 2. 网格页面
```dart
// 标准结构
Scaffold(
  appBar: AppBar(title: Text('页面标题')),
  body: provider.when(
    data: (items) => items.isEmpty
        ? NoDataState()
        : GridView.builder(
            padding: EdgeInsets.all(16),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              childAspectRatio: 0.75,
            ),
            itemCount: items.length,
            itemBuilder: (context, index) => GridItemCard(...),
          ),
    loading: () => SkeletonGrid(),
    error: (error, _) => ErrorState(...),
  ),
)
```

### 3. 详情页面
```dart
// 标准结构
Scaffold(
  appBar: AppBar(title: Text('详情')),
  body: provider.when(
    data: (item) => SingleChildScrollView(
      child: Column(
        children: [
          HeroImage(imageUrl: item.imageUrl),
          Padding(
            padding: EdgeInsets.all(16),
            child: Column(...),
          ),
        ],
      ),
    ),
    loading: () => SkeletonList(itemCount: 1),
    error: (error, _) => ErrorState(...),
  ),
)
```

## 依赖项

### 必需的包
```yaml
dependencies:
  shimmer: ^3.0.0              # Shimmer 加载效果
  cached_network_image: ^3.3.0 # 图片缓存加载
  hugeicons: ^0.0.7            # 图标库
```

## 文件组织

```
lib/
├── shared/
│   └── widgets/
│       ├── loading_skeleton.dart   # 加载骨架屏
│       ├── empty_state.dart        # 空状态组件
│       ├── error_state.dart        # 错误状态组件
│       ├── app_card.dart           # 卡片组件
│       └── app_image.dart          # 图片组件
├── theme/
│   ├── app_colors.dart             # 颜色定义
│   └── app_theme.dart              # 主题配置
```

## 最佳实践

### 1. 状态处理
总是处理三种状态：
```dart
provider.when(
  data: (data) => // 数据展示,
  loading: () => // 加载状态,
  error: (error, _) => // 错误状态,
)
```

### 2. 空状态
空数据时使用友好的空状态组件：
```dart
if (items.isEmpty) {
  return NoDataState(
    message: '暂时没有内容',
    onRetry: () => refresh(),
  );
}
```

### 3. 图片加载
统一使用 AppNetworkImage：
```dart
// ✅ 好的做法
AppNetworkImage(
  imageUrl: item.imageUrl,
  width: 80,
  height: 80,
)

// ❌ 避免
Image.network(item.imageUrl)
```

### 4. 错误提示
使用 SnackBar 而非 Dialog：
```dart
// ✅ 好的做法
showErrorSnackBar(context, '操作失败');

// ❌ 避免
showDialog(
  context: context,
  builder: (context) => AlertDialog(...),
)
```

### 5. 卡片间距
使用统一的卡片间距：
```dart
// ✅ 好的做法
ListView.builder(
  padding: EdgeInsets.all(16),
  itemBuilder: (context, index) => ListItemCard(...), // 自带 16px 底部间距
)

// ❌ 避免
ListView.builder(
  itemBuilder: (context, index) => Padding(
    padding: EdgeInsets.only(bottom: 8), // 不一致的间距
    child: Card(...),
  ),
)
```

## 检查清单

在实现新页面时，检查以下项目：

- [ ] 加载状态：使用 Shimmer/Skeleton
- [ ] 空状态：使用统一的 EmptyState 组件
- [ ] 错误状态：使用 ErrorState + SnackBar
- [ ] 卡片：使用 AppCard/ListItemCard/GridItemCard
- [ ] 图片：使用 AppNetworkImage/AppAvatar/HeroImage
- [ ] 间距：遵循 8px 基准间距系统
- [ ] 圆角：卡片 12px，图片 8px，标签 4px
- [ ] 阴影：统一使用轻阴影 (0.08 opacity)
- [ ] 颜色：遵循颜色使用规范
- [ ] 字体：使用正确的字体大小和字重
- [ ] 下拉刷新：列表页面添加 RefreshIndicator
- [ ] 点击反馈：卡片使用 InkWell

## 维护和更新

本指南应随着应用的迭代持续更新。当添加新组件或调整设计规范时，请及时更新此文档。

### 更新历史
- 2025-12-22: 初始版本，定义核心 UI 组件和设计系统
