# iOS Runbook - 10 分钟快速上手指南

## 目标
拿到 Mac 后 10 分钟内跑起来 FARM 应用，完成 iOS 开发环境配置和首次构建。

## 前置条件

### 1. 硬件要求
- MacBook（Intel 或 Apple Silicon）
- iOS 设备或模拟器

### 2. 软件要求
- macOS 12.0 或更高版本
- Xcode 14.0 或更高版本
- Flutter SDK 3.4.3 或更高版本

## 快速开始

### Step 1: 安装 Xcode

```bash
# 从 App Store 安装 Xcode
# 安装完成后，打开 Xcode 并同意许可协议

# 安装 Command Line Tools
sudo xcode-select --switch /Applications/Xcode.app/Contents/Developer
sudo xcodebuild -runFirstLaunch

# 验证安装
xcodebuild -version
```

### Step 2: 安装 Flutter

```bash
# 使用 Homebrew 安装（推荐）
brew install flutter

# 或者手动下载
# 访问 https://flutter.dev/docs/get-started/install/macos

# 验证安装
flutter --version

# 检查环境
flutter doctor
```

**期望的 `flutter doctor` 输出:**
```
Doctor summary (to see all details, run flutter doctor -v):
[✓] Flutter (Channel stable, 3.27.1, on macOS, locale zh-CN)
[✓] Xcode - develop for iOS and macOS (Xcode 15.0)
[✓] Chrome - develop for the web
[✓] VS Code (version 1.85.0)
[✓] Connected device (2 available)
[✓] Network resources

• No issues found!
```

**如果有问题:**
```bash
# 缺少 CocoaPods
sudo gem install cocoapods

# 缺少 iOS 证书（暂时可跳过，只运行模拟器）
# 需要真机测试时，在 Xcode 中添加 Apple ID

# 网络问题（中国大陆）
export PUB_HOSTED_URL="https://pub.flutter-io.cn"
export FLUTTER_STORAGE_BASE_URL="https://storage.flutter-io.cn"

# 永久配置
echo 'export PUB_HOSTED_URL="https://pub.flutter-io.cn"' >> ~/.zshrc
echo 'export FLUTTER_STORAGE_BASE_URL="https://storage.flutter-io.cn"' >> ~/.zshrc
source ~/.zshrc
```

### Step 3: 克隆项目并配置环境变量

```bash
# 克隆项目（假设在 Mac 上的路径）
cd ~/Projects
git clone <repository-url> farm
cd farm

# 或者如果已有项目
cd ~/Projects/farm  # Mac 上的路径示例
# Windows 路径 D:\farm 对应 Mac 可能是 ~/Projects/farm

# 创建 .env 文件
cp .env.example .env

# 编辑 .env 文件，填入实际的 Supabase 配置
nano .env
# 或使用 VS Code
code .env
```

**.env 文件内容示例:**
```env
# Supabase 配置
SUPABASE_URL=https://your-project.supabase.co
SUPABASE_ANON_KEY=your-anon-key-here

# Google 登录配置（iOS）
GOOGLE_CLIENT_ID=your-google-client-id.apps.googleusercontent.com
GOOGLE_SERVER_CLIENT_ID=your-google-server-client-id.apps.googleusercontent.com

# RevenueCat 配置
REVENUE_CAT_PLAY_STORE=your-play-store-key
REVENUE_CAT_APP_STORE=your-app-store-key
```

**获取 Supabase 配置:**
1. 登录 [Supabase Dashboard](https://app.supabase.com)
2. 进入项目 → Settings → API
3. 复制 Project URL 和 anon public key

### Step 4: 安装依赖

```bash
# 安装 Flutter 依赖
flutter pub get

# 生成环境变量代码
flutter pub run build_runner build --delete-conflicting-outputs

# 生成国际化代码
flutter pub run easy_localization:generate -f keys -o locale_keys.g.dart --source-dir assets/translations --output-dir lib/generated

# 安装 iOS CocoaPods 依赖
cd ios
pod install
cd ..
```

### Step 5: 运行应用

```bash
# 查看可用设备
flutter devices

# 运行到 iOS 模拟器
flutter run -d "iPhone 15 Pro"

# 或使用简写（自动选择 iOS 设备）
flutter run -d iPhone

# 运行到真机（需要配置签名）
flutter run -d <device-id>

# Debug 模式
flutter run --debug

# Release 模式（性能更好）
flutter run --release
```

**首次运行预期时间:**
- 依赖安装: 2-3 分钟
- CocoaPods 安装: 1-2 分钟
- 首次构建: 3-5 分钟
- **总计: 约 6-10 分钟**

## iOS 配置详解

### 1. Info.plist 配置

如果项目还没有 `ios/` 目录，需要先创建：

```bash
flutter create --platforms=ios .
```

**需要添加的权限（根据功能需要）:**

编辑 `ios/Runner/Info.plist`：

```xml
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
    <!-- 基础配置 -->
    <key>CFBundleDevelopmentRegion</key>
    <string>$(DEVELOPMENT_LANGUAGE)</string>
    
    <key>CFBundleDisplayName</key>
    <string>FARM</string>
    
    <key>CFBundleExecutable</key>
    <string>$(EXECUTABLE_NAME)</string>
    
    <key>CFBundleIdentifier</key>
    <string>$(PRODUCT_BUNDLE_IDENTIFIER)</string>
    
    <key>CFBundleInfoDictionaryVersion</key>
    <string>6.0</string>
    
    <key>CFBundleName</key>
    <string>farm_app</string>
    
    <key>CFBundlePackageType</key>
    <string>APPL</string>
    
    <key>CFBundleShortVersionString</key>
    <string>$(FLUTTER_BUILD_NAME)</string>
    
    <key>CFBundleVersion</key>
    <string>$(FLUTTER_BUILD_NUMBER)</string>
    
    <key>LSRequiresIPhoneOS</key>
    <true/>
    
    <key>UILaunchStoryboardName</key>
    <string>LaunchScreen</string>
    
    <key>UIMainStoryboardFile</key>
    <string>Main</string>
    
    <key>UISupportedInterfaceOrientations</key>
    <array>
        <string>UIInterfaceOrientationPortrait</string>
        <string>UIInterfaceOrientationLandscapeLeft</string>
        <string>UIInterfaceOrientationLandscapeRight</string>
    </array>
    
    <key>UISupportedInterfaceOrientations~ipad</key>
    <array>
        <string>UIInterfaceOrientationPortrait</string>
        <string>UIInterfaceOrientationPortraitUpsideDown</string>
        <string>UIInterfaceOrientationLandscapeLeft</string>
        <string>UIInterfaceOrientationLandscapeRight</string>
    </array>
    
    <!-- 相机权限（如果使用 image_picker）-->
    <key>NSCameraUsageDescription</key>
    <string>需要使用相机拍摄照片上传商品图片</string>
    
    <!-- 相册权限 -->
    <key>NSPhotoLibraryUsageDescription</key>
    <string>需要访问相册选择照片</string>
    
    <!-- 位置权限（如果需要）-->
    <key>NSLocationWhenInUseUsageDescription</key>
    <string>需要获取您的位置以显示附近的农场和民宿</string>
    
    <!-- App Transport Security (ATS) 配置 -->
    <!-- Supabase 使用 HTTPS，所以默认配置即可 -->
    <!-- 如果需要连接本地开发服务器，可以添加例外 -->
    <key>NSAppTransportSecurity</key>
    <dict>
        <!-- 允许所有 HTTP（仅用于开发，生产环境应删除）-->
        <!-- <key>NSAllowsArbitraryLoads</key>
        <true/> -->
        
        <!-- 或者只允许特定域名 -->
        <key>NSExceptionDomains</key>
        <dict>
            <!-- 本地开发服务器 -->
            <key>localhost</key>
            <dict>
                <key>NSExceptionAllowsInsecureHTTPLoads</key>
                <true/>
            </dict>
            <!-- Supabase 使用 HTTPS，不需要例外 -->
        </dict>
    </dict>
    
    <!-- URL Schemes（用于 Deep Linking 和 OAuth）-->
    <key>CFBundleURLTypes</key>
    <array>
        <dict>
            <key>CFBundleTypeRole</key>
            <string>Editor</string>
            <key>CFBundleURLSchemes</key>
            <array>
                <!-- 自定义 scheme -->
                <string>farm</string>
                <!-- Google 登录 -->
                <string>com.googleusercontent.apps.YOUR-CLIENT-ID</string>
            </array>
        </dict>
    </array>
    
    <!-- Universal Links（如果需要）-->
    <key>com.apple.developer.associated-domains</key>
    <array>
        <string>applinks:your-domain.com</string>
    </array>
</dict>
</plist>
```

### 2. 签名配置

#### 开发/测试（最简配置）

1. 打开 Xcode:
```bash
open ios/Runner.xcworkspace
```

2. 在 Xcode 中:
   - 选择 Runner 项目
   - 选择 Signing & Capabilities
   - 勾选 "Automatically manage signing"
   - 选择你的 Team（添加 Apple ID）
   - 修改 Bundle Identifier（如 `com.yourcompany.farm`）

3. 连接真机设备:
   - 设备 → Settings → Privacy & Security → Developer Mode (开启)
   - 信任开发者证书

#### 生产构建（暂不要求）

生产环境需要:
- Apple Developer Program 会员（$99/年）
- Distribution Certificate
- Provisioning Profile
- App Store Connect 配置

### 3. CocoaPods 配置

编辑 `ios/Podfile`（如果需要自定义）:

```ruby
# Uncomment this line to define a global platform for your project
platform :ios, '12.0'

# CocoaPods analytics sends network stats synchronously affecting flutter build latency.
ENV['COCOAPODS_DISABLE_STATS'] = 'true'

project 'Runner', {
  'Debug' => :debug,
  'Profile' => :release,
  'Release' => :release,
}

def flutter_root
  generated_xcode_build_settings_path = File.expand_path(File.join('..', 'Flutter', 'Generated.xcconfig'), __FILE__)
  unless File.exist?(generated_xcode_build_settings_path)
    raise "#{generated_xcode_build_settings_path} must exist. If you're running pod install manually, make sure flutter pub get is executed first"
  end

  File.foreach(generated_xcode_build_settings_path) do |line|
    matches = line.match(/FLUTTER_ROOT\=(.*)/)
    return matches[1].strip if matches
  end
  raise "FLUTTER_ROOT not found in #{generated_xcode_build_settings_path}. Try deleting Generated.xcconfig, then run flutter pub get"
end

require File.expand_path(File.join('packages', 'flutter_tools', 'bin', 'podhelper'), flutter_root)

flutter_ios_podfile_setup

target 'Runner' do
  use_frameworks!
  use_modular_headers!

  flutter_install_all_ios_pods File.dirname(File.realpath(__FILE__))
  
  # Firebase（如果使用）
  # pod 'Firebase/Analytics'
  # pod 'Firebase/Crashlytics'
end

post_install do |installer|
  installer.pods_project.targets.each do |target|
    flutter_additional_ios_build_settings(target)
    
    # 兼容 Swift 5.0+
    target.build_configurations.each do |config|
      config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '12.0'
    end
  end
end
```

## 常见问题和解决方案

### 问题 1: CocoaPods 找不到

**错误信息:**
```
CocoaPods not installed or not in valid state.
```

**解决方案:**
```bash
# 安装 CocoaPods
sudo gem install cocoapods

# 如果权限问题
sudo gem install -n /usr/local/bin cocoapods

# 更新 CocoaPods 仓库
pod repo update

# 清理并重新安装
cd ios
rm -rf Pods Podfile.lock
pod install
cd ..
```

### 问题 2: 构建失败 - 签名错误

**错误信息:**
```
Signing for "Runner" requires a development team.
```

**解决方案:**
1. 打开 Xcode: `open ios/Runner.xcworkspace`
2. 添加 Apple ID: Xcode → Preferences → Accounts → "+"
3. 选择 Team 并启用自动签名
4. 修改 Bundle ID 为唯一标识

### 问题 3: 模拟器启动失败

**错误信息:**
```
No devices found
```

**解决方案:**
```bash
# 列出可用模拟器
xcrun simctl list devices

# 打开模拟器应用
open -a Simulator

# 或通过命令启动特定模拟器
xcrun simctl boot "iPhone 15 Pro"

# 创建新模拟器
xcrun simctl create "My iPhone" "iPhone 15 Pro"
```

### 问题 4: Firebase/Google 配置错误

**错误信息:**
```
GoogleService-Info.plist not found
```

**解决方案（如果使用 Firebase）:**
1. 访问 [Firebase Console](https://console.firebase.google.com)
2. 创建 iOS 应用
3. 下载 `GoogleService-Info.plist`
4. 将文件放到 `ios/Runner/` 目录
5. 在 Xcode 中添加文件到项目（右键添加，确保选中 Target: Runner）

### 问题 5: 网络请求失败 (ATS)

**错误信息:**
```
NSURLConnection finished with error - code -1022
```

**解决方案:**

这是 App Transport Security (ATS) 限制。Supabase 使用 HTTPS，所以默认应该没问题。

如果需要连接本地服务器，在 `Info.plist` 中添加例外：

```xml
<key>NSAppTransportSecurity</key>
<dict>
    <key>NSExceptionDomains</key>
    <dict>
        <key>localhost</key>
        <dict>
            <key>NSExceptionAllowsInsecureHTTPLoads</key>
            <true/>
        </dict>
    </dict>
</dict>
```

### 问题 6: 依赖冲突

**错误信息:**
```
[!] CocoaPods could not find compatible versions for pod "XXX"
```

**解决方案:**
```bash
cd ios

# 清理并重新安装
rm -rf Pods Podfile.lock
pod deintegrate
pod install

# 如果还有问题，更新 CocoaPods
pod repo update
pod install

cd ..
```

### 问题 7: Xcode 版本过低

**错误信息:**
```
The iOS deployment target 'IPHONEOS_DEPLOYMENT_TARGET' is set to 12.0, but the range of supported deployment target versions is 13.0 to 17.0.
```

**解决方案:**

更新 `ios/Podfile`:
```ruby
platform :ios, '13.0'
```

更新后重新安装:
```bash
cd ios
rm -rf Pods Podfile.lock
pod install
cd ..
```

### 问题 8: 生成的代码找不到

**错误信息:**
```
Error: 'env.g.dart' not found
```

**解决方案:**
```bash
# 重新生成代码
flutter pub run build_runner build --delete-conflicting-outputs

# 如果还有问题，清理后重新生成
flutter clean
flutter pub get
flutter pub run build_runner build --delete-conflicting-outputs
```

## iOS 构建命令

### Debug 构建（开发用）

```bash
# 构建但不运行
flutter build ios --debug

# 构建并运行到模拟器
flutter run -d "iPhone 15 Pro"

# 热重载（开发时）
# 在运行时按 'r' 键
```

### Release 构建（测试用）

```bash
# 构建 Release 版本
flutter build ios --release

# 构建特定配置
flutter build ios --release --flavor production
```

### Archive 构建（分发用，暂不要求）

```bash
# 构建 IPA（需要签名配置）
flutter build ipa --release

# 输出位置
# build/ios/archive/Runner.xcarchive
# build/ios/ipa/farm_app.ipa
```

## 性能优化建议

### 1. 加速构建

```bash
# 使用 Flutter 缓存
export FLUTTER_BUILD_CACHE=1

# 并行构建
flutter build ios --release --dart-define=FLUTTER_BUILD_MODE=release -j8

# 使用本地 CocoaPods CDN
# 在 Podfile 顶部添加
# source 'https://cdn.cocoapods.org/'
```

### 2. 减少应用体积

```bash
# 启用代码混淆
flutter build ios --release --obfuscate --split-debug-info=build/debug-info

# 移除未使用的资源
flutter build ios --release --tree-shake-icons
```

### 3. 模拟器 vs 真机

| 特性 | 模拟器 | 真机 |
|------|--------|------|
| 速度 | 快（M1/M2 Mac） | 取决于设备 |
| 性能 | 不完全准确 | 真实性能 |
| 传感器 | 模拟 | 真实 |
| 网络 | 共享 Mac 网络 | 真实网络环境 |
| 推荐用途 | 日常开发 | 性能测试、真实场景测试 |

## 环境变量配置

### 开发环境

`.env`:
```env
SUPABASE_URL=https://your-project.supabase.co
SUPABASE_ANON_KEY=your-anon-key
```

### 多环境配置（可选）

如果需要区分开发/测试/生产环境:

1. 创建多个环境文件:
```
.env.development
.env.staging
.env.production
```

2. 修改 `env.dart`:
```dart
@Envied(path: '.env.${String.fromEnvironment('ENV', defaultValue: 'development')}')
abstract class Env {
  // ...
}
```

3. 构建时指定环境:
```bash
flutter run --dart-define=ENV=development
flutter build ios --dart-define=ENV=production
```

## CI/CD 配置示例

### GitHub Actions

`.github/workflows/ios.yml`:
```yaml
name: iOS Build

on:
  push:
    branches: [ main, develop ]
  pull_request:
    branches: [ main ]

jobs:
  build:
    runs-on: macos-latest
    
    steps:
    - uses: actions/checkout@v3
    
    - name: Setup Flutter
      uses: subosito/flutter-action@v2
      with:
        flutter-version: '3.27.1'
        channel: 'stable'
    
    - name: Create .env file
      run: |
        echo "SUPABASE_URL=${{ secrets.SUPABASE_URL }}" >> .env
        echo "SUPABASE_ANON_KEY=${{ secrets.SUPABASE_ANON_KEY }}" >> .env
        # ... other secrets
    
    - name: Install dependencies
      run: |
        flutter pub get
        flutter pub run build_runner build --delete-conflicting-outputs
    
    - name: Install CocoaPods
      run: |
        cd ios
        pod install
        cd ..
    
    - name: Build iOS
      run: flutter build ios --release --no-codesign
    
    - name: Archive build
      uses: actions/upload-artifact@v3
      with:
        name: ios-build
        path: build/ios/iphoneos/Runner.app
```

## 快速检查清单

开始开发前确认：

- [ ] Xcode 已安装并配置
- [ ] Flutter SDK 已安装 (3.4.3+)
- [ ] `flutter doctor` 无错误
- [ ] `.env` 文件已配置
- [ ] `flutter pub get` 成功
- [ ] `pod install` 成功
- [ ] 模拟器可以启动
- [ ] `flutter run -d iPhone` 成功运行
- [ ] 热重载功能正常

构建检查：

- [ ] `flutter build ios --debug` 成功
- [ ] `flutter build ios --release --no-codesign` 成功
- [ ] 应用在模拟器上运行正常
- [ ] 网络请求正常（Supabase 连接）

## 时间估算

| 步骤 | 预计时间 |
|------|----------|
| 安装 Xcode | 30-60 分钟（一次性）|
| 安装 Flutter | 5-10 分钟（一次性）|
| 克隆项目 | 1 分钟 |
| 配置 .env | 2 分钟 |
| flutter pub get | 2-3 分钟 |
| pod install | 1-2 分钟 |
| 首次构建 | 3-5 分钟 |
| **总计（首次）** | **10-15 分钟**（不含 Xcode 安装）|
| **后续构建** | **1-2 分钟** |

## 参考资料

- [Flutter 官方文档 - iOS 设置](https://docs.flutter.dev/get-started/install/macos)
- [Supabase Flutter 快速开始](https://supabase.com/docs/guides/getting-started/quickstarts/flutter)
- [CocoaPods 官方文档](https://guides.cocoapods.org/)
- [Xcode 文档](https://developer.apple.com/documentation/xcode)
- [App Transport Security](https://developer.apple.com/documentation/security/preventing_insecure_network_connections)

## 支持

如果遇到问题：

1. 查看本文档的"常见问题和解决方案"
2. 运行 `flutter doctor -v` 查看详细诊断
3. 查看 iOS 构建日志: `build/ios/iphoneos/Runner.app`
4. 查看项目 Issues 或联系团队

---

**文档版本:** 1.0  
**最后更新:** 2025-12-22  
**适用于:** Flutter 3.4.3+, Xcode 14+, iOS 12+
