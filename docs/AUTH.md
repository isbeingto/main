# 认证文档 (AUTH.md)

## 概述

本应用使用 **Supabase Auth** 实现用户认证，支持以下登录方式：
- Email OTP (Magic Link)
- Google OAuth
- Apple OAuth

## 认证流程

### 1. Email OTP 流程

```
┌─────────────┐     ┌─────────────┐     ┌─────────────┐     ┌─────────────┐
│  用户输入    │────▶│  发送 OTP   │────▶│  用户验证    │────▶│  登录成功   │
│  Email      │     │  到邮箱     │     │  6位验证码  │     │  upsert     │
│             │     │             │     │             │     │  profile    │
└─────────────┘     └─────────────┘     └─────────────┘     └─────────────┘
```

**代码流程：**

1. **发送 OTP**
   ```dart
   await supabase.auth.signInWithOtp(
     email: email,
     emailRedirectTo: Constants.supabaseLoginCallback,
   );
   ```

2. **验证 OTP**
   ```dart
   await supabase.auth.verifyOTP(
     email: email,
     token: token,
     type: isRegister ? OtpType.signup : OtpType.magiclink,
   );
   ```

3. **自动创建 Profile**
   - 登录成功后触发 `handleResult()` 
   - 调用 `upsertProfile()` 在 `profiles` 表中创建/更新用户资料

### 2. Social Login 流程

```
┌─────────────┐     ┌─────────────┐     ┌─────────────┐     ┌─────────────┐
│  点击社交   │────▶│  OAuth 跳转 │────▶│  授权回调   │────▶│  登录成功   │
│  登录按钮   │     │  Google/    │     │  返回 App   │     │  upsert     │
│             │     │  Apple      │     │             │     │  profile    │
└─────────────┘     └─────────────┘     └─────────────┘     └─────────────┘
```

## 数据库结构

### profiles 表

```sql
CREATE TABLE public.profiles (
    id UUID PRIMARY KEY REFERENCES auth.users(id) ON DELETE CASCADE,
    email TEXT,
    name TEXT,
    avatar TEXT,
    job TEXT,
    diamond INTEGER DEFAULT 0,
    expiry_date_premium TIMESTAMPTZ,
    is_lifetime_premium BOOLEAN DEFAULT false,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ DEFAULT NOW()
);
```

### 自动创建 Profile 触发器

当用户在 `auth.users` 表中创建时，自动在 `profiles` 表中创建对应记录：

```sql
CREATE OR REPLACE FUNCTION public.handle_new_user()
RETURNS TRIGGER AS $$
BEGIN
    INSERT INTO public.profiles (id, email, name)
    VALUES (
        NEW.id,
        NEW.email,
        COALESCE(NEW.raw_user_meta_data->>'name', split_part(NEW.email, '@', 1))
    )
    ON CONFLICT (id) DO UPDATE SET
        email = EXCLUDED.email,
        updated_at = NOW();
    RETURN NEW;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

CREATE TRIGGER on_auth_user_created
    AFTER INSERT ON auth.users
    FOR EACH ROW
    EXECUTE FUNCTION public.handle_new_user();
```

## RLS 策略

### profiles 表 RLS

| 策略名称 | 操作 | 条件 |
|---------|------|------|
| Users can view own profile | SELECT | `auth.uid() = id` |
| Users can update own profile | UPDATE | `auth.uid() = id` |
| Users can insert own profile | INSERT | `auth.uid() = id` |

```sql
-- 启用 RLS
ALTER TABLE public.profiles ENABLE ROW LEVEL SECURITY;

-- SELECT 策略
CREATE POLICY "Users can view own profile"
    ON public.profiles FOR SELECT
    USING (auth.uid() = id);

-- UPDATE 策略
CREATE POLICY "Users can update own profile"
    ON public.profiles FOR UPDATE
    USING (auth.uid() = id)
    WITH CHECK (auth.uid() = id);

-- INSERT 策略
CREATE POLICY "Users can insert own profile"
    ON public.profiles FOR INSERT
    WITH CHECK (auth.uid() = id);
```

### 与其他表的 RLS 依赖

| 表名 | 依赖关系 | 说明 |
|------|---------|------|
| `booking_requests` | `user_id = auth.uid()` | 用户只能查看/创建自己的预订 |
| `listings` | `host_id` 可选 | 房源可被匿名用户查看 |

## 认证状态管理

### AuthenticationViewModel

```dart
@riverpod
class AuthenticationViewModel extends _$AuthenticationViewModel {
  // 发送 Magic Link
  Future<void> signInWithMagicLink(String email);
  
  // 验证 OTP
  Future<void> verifyOtp({
    required String email,
    required String token,
    required bool isRegister,
  });
  
  // 社交登录
  Future<void> signInWithGoogle();
  Future<void> signInWithApple();
  
  // 退出登录
  Future<void> signOut();
  
  // 登录成功后 upsert profile
  Future<void> upsertProfile(User user);
}
```

### ProfileViewModel

```dart
@Riverpod(keepAlive: true)
class ProfileViewModel extends _$ProfileViewModel {
  // 获取当前用户 profile
  FutureOr<ProfileState> build();
  
  // Upsert profile（登录后调用）
  Future<void> upsertProfile({
    required String userId,
    String? email,
    String? name,
    String? avatar,
  });
  
  // 更新 profile
  Future<void> updateProfile({...});
  
  // 退出登录
  Future<void> signOut();
}
```

## 未登录保护

### ProfileWrapper

`ProfileWrapper` 组件检查登录状态，未登录时显示登录引导页：

```dart
class ProfileWrapper extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return StreamBuilder<AuthState>(
      stream: supabase.auth.onAuthStateChange,
      builder: (context, snapshot) {
        final session = supabase.auth.currentSession;
        
        if (session != null) {
          return const ProfileScreen();
        } else {
          return const LoginRequiredScreen();
        }
      },
    );
  }
}
```

## 文件结构

```
lib/features/
├── authentication/
│   ├── repository/
│   │   └── authentication_repository.dart  # Supabase Auth API 调用
│   └── ui/
│       ├── otp_screen.dart                 # OTP 验证页
│       ├── register_screen.dart            # 注册页
│       ├── sign_in_screen.dart             # 登录页
│       ├── state/
│       │   └── authentication_state.dart   # 认证状态
│       ├── view_model/
│       │   └── authentication_view_model.dart
│       └── widgets/
│           ├── social_sign_in.dart
│           ├── sign_in_with_google.dart
│           └── sign_in_with_apple.dart
└── profile/
    ├── model/
    │   └── profile.dart                    # Profile 数据模型
    ├── repository/
    │   └── profile_repository.dart         # Profile CRUD 操作
    └── ui/
        ├── profile_screen.dart             # 个人中心页
        ├── profile_wrapper.dart            # 登录状态包装器
        ├── login_required_screen.dart      # 未登录引导页
        └── view_model/
            └── profile_view_model.dart
```

## 配置要求

### Supabase Dashboard 配置

1. **Authentication → Providers**
   - Email: 启用，配置 OTP 长度为 6
   - Google: 配置 OAuth credentials
   - Apple: 配置 Services ID

2. **Authentication → URL Configuration**
   - Site URL: `com.areser.flutter_mvvm_riverpod://login-callback/`
   - Redirect URLs: 添加应用回调 URL

3. **Database → Tables**
   - 运行 `20251222000002_create_profiles_table.sql` 迁移

### 环境变量

```dart
// lib/environment/env.dart
class Env {
  static const supabaseUrl = 'YOUR_SUPABASE_URL';
  static const supabaseAnonKey = 'YOUR_SUPABASE_ANON_KEY';
}
```

## 常见问题

### Q: Profile 未自动创建？

1. 检查 `handle_new_user` 触发器是否存在
2. 检查触发器函数的 `SECURITY DEFINER` 权限
3. 确保 `profiles` 表 RLS 策略正确

### Q: 无法更新 Profile？

1. 检查 `auth.uid() = id` RLS 策略
2. 确保用户已登录（session 有效）

### Q: 社交登录回调失败？

1. 检查 Deep Link 配置
2. iOS: 检查 `Info.plist` URL Schemes
3. Android: 检查 `AndroidManifest.xml` intent-filter

## 迁移脚本

```bash
# 推送 profiles 表迁移
supabase db push

# 或手动执行
supabase migration up
```

## 测试清单

- [ ] Email OTP 注册流程
- [ ] Email OTP 登录流程
- [ ] Google 登录
- [ ] Apple 登录
- [ ] 登录后 profiles 表自动写入
- [ ] 未登录访问"我的" Tab 显示登录引导
- [ ] 退出登录功能
- [ ] Profile 更新功能
