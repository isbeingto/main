# Farm App

Flutter MVVM + Riverpod + Supabase baseline for long-term iteration.

## Quickstart

### Prerequisites

- Flutter SDK 3.27.1 (Dart 3.6.0) in PATH
- Chrome (web) and/or Windows desktop toolchain

### Setup

```bash
# 1) Install dependencies
flutter pub get

# 2) Create local env file
cp .env.example .env

# 3) Fill in .env (Supabase URL/anon key required)
# See .env.example for optional keys.

# 4) Generate localization keys
dart run easy_localization:generate -f keys -o locale_keys.g.dart --source-dir assets/translations --output-dir lib/generated

# 5) Generate code (envied, riverpod, freezed)
dart run build_runner build --delete-conflicting-outputs

# 6) Run the app
flutter run -d chrome
# or
flutter run -d windows
```

### Troubleshooting (Windows)

If `flutter pub get` reports "Building with plugins requires symlink support":

- Enable Developer Mode in Windows Settings, or
- For web-only runs, disable Windows desktop: `flutter config --no-enable-windows-desktop`

### Environment switching

This project uses envied, so `.env` is compiled into generated code.

Example workflow:

```bash
cp .env.example .env.dev
cp .env.example .env.prod

# Switch env for a run
cp .env.dev .env
dart run build_runner build --delete-conflicting-outputs
flutter run -d chrome
```

## Environment Variables

Create a `.env` file in the project root. See `.env.example` for all keys.

Required:
- `SUPABASE_URL`
- `SUPABASE_ANON_KEY`

Optional:
- `GOOGLE_CLIENT_ID`
- `GOOGLE_SERVER_CLIENT_ID`
- `REVENUE_CAT_PLAY_STORE`
- `REVENUE_CAT_APP_STORE`

Get Supabase values from:
https://supabase.com/dashboard/project/YOUR_PROJECT/settings/api

## Project Structure

```
lib/
  constants/       # App constants and configs
  environment/     # Env variables (envied)
  extensions/      # Extension methods
  features/        # Feature modules (MVVM)
  routing/         # go_router setup
  theme/           # Theme definitions
  utils/           # Utilities
supabase/          # Supabase CLI config + migrations
assets/            # Animations, fonts, images, translations
```

## Notes

- `.env` is gitignored; use `.env.example` as the template.
- `supabase/` stays in the repo for CLI and migrations.

## T02 验证步骤

### 数据库迁移

```bash
# 链接 Supabase 项目
supabase link --project-ref skluusetjxzolthhbuog

# 推送迁移
supabase db push
```

### 应用验证

1. **运行应用**
   ```bash
   flutter run -d chrome
   ```

2. **验证房源列表**
   - 启动后进入主页，应显示 5 条 seed 房源数据
   - 每个房源卡片显示：标题、位置、价格、卧室/浴室/人数信息

3. **验证房源详情**
   - 点击任意房源进入详情页
   - 查看图片轮播、设施列表、描述信息

4. **验证预订申请**
   - 登录账户
   - 在详情页填写日期、人数、备注
   - 点击"预订申请"按钮
   - 应看到成功提示 SnackBar
   - 在 Supabase Dashboard → Table Editor → `booking_requests` 表验证数据

### 代码检查

```bash
# 静态分析（0 issues）
flutter analyze

# 单元测试
flutter test
```

### 相关文档

- [表结构与 RLS 说明](docs/FARM-T02-schema-and-rls.md)

## License

Contains MIT-licensed baseline components from https://github.com/namanh11611/flutter_mvvm_riverpod (see LICENSE). Project-specific code remains private.
