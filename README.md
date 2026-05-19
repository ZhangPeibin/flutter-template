# Flutter Template

一个可复用的 Flutter 基础项目模板，用于快速启动新的 Android / iOS Flutter App。

## 目标

- 保持基础工程可直接运行。
- 预留多环境配置入口。
- 提供清晰的目录结构，方便后续扩展路由、网络、状态管理和设计系统。
- 作为多个业务项目的起点，而不是绑定单一业务。



## 目录结构

```text
lib/
  app/
    app.dart
    theme/
      app_theme.dart
  core/
    config/
      app_config.dart
  features/
    home/
      presentation/
        home_page.dart
  main.dart
```



## 从模板创建新项目

1. 复制模版

   ```bash
   rsync -a --exclude .git flutter_template/ my_app/
   cd my_app
   ```

2. 执行重命名脚本

   ```bash
   dart run tool/setup_project.dart \
     --project-name my_app \
     --display-name "My App" \
     --android-package com.xxx.my_app \
     --ios-bundle-id com.xxx.my-app
   ```

   参数说明：

   - `project-name`：Dart package 名，写入 `pubspec.yaml`，例如 `my_app`。
   - `display-name`：App 在 Android Launcher 和 iOS Home Screen 显示的名字。
   - `android-package`：Android `namespace`、`applicationId` 和 Kotlin package，例如 `com.xxx.my_app`。
   - `ios-bundle-id`：iOS `PRODUCT_BUNDLE_IDENTIFIER`。可省略，默认从 `android-package` 推导，并把 `_` 转成 `-`。

   脚本会同步修改：

   - `pubspec.yaml`
   - Android `namespace`、`applicationId`、Launcher 名称和 `MainActivity.kt` package 路径
   - iOS `CFBundleDisplayName`、`CFBundleName`、`PRODUCT_BUNDLE_IDENTIFIER`
   - `lib/`、`test/`、`integration_test/` 下 Dart 文件里的模板包名和默认 App 名称

   如果需要配置签名团队，打开 `ios/Runner.xcworkspace` → `Runner` target → `Signing & Capabilities` 修改 Team。

   注意：脚本需要在 Flutter 项目根目录执行，并且新名字不能包含旧模板名或旧包名。

3. 清理IDE残留文件

   ```bash
   flutter clean
   ```

4. 重新生成依赖

   ```bash
   flutter pub get
   ```

5. 初始化 Git

   ```bash
   dart run tool/init_git.dart
   ```

   如果想直接创建首个提交：

   ```bash
   dart run tool/init_git.dart --commit --message "Initial commit"
   ```

6. 重新打开IDE



## 运行

```bash
flutter pub get
flutter run
```

也可以使用 `Makefile` 里的快捷命令：

```bash
make get
make run-dev
```

## 多环境配置

模板通过 `--dart-define-from-file` 注入环境配置，并提供了 `Makefile` 与 VS Code 启动配置。

环境配置文件：

- `config/dev.json`
- `config/staging.json`
- `config/prod.json`

`APP_NAME` 会影响 Flutter 页面里读取 `AppConfig.appName` 的位置，例如 `MaterialApp.title` 和首页标题。Android Launcher 与 iOS Home Screen 显示名来自平台配置，需要通过 `tool/setup_project.dart` 或手动修改 Android `android:label`、iOS `CFBundleDisplayName`。

### Makefile 命令

| 命令 | 作用 |
| --- | --- |
| `make get` | 执行 `flutter pub get` |
| `make run-dev` | 以 `APP_ENV=dev` 启动 |
| `make run-staging` | 以 `APP_ENV=staging` 启动 |
| `make run-prod` | 以 `APP_ENV=prod` 和 release 模式启动 |
| `make analyze` | 执行 `flutter analyze` |
| `make test` | 执行 `flutter test` |
| `make clean` | 执行 `flutter clean` |

常用运行命令：

```bash
make run-dev
make run-staging
make run-prod
```

如需修改 App 名或接口地址，直接编辑对应环境的 JSON 文件。

VS Code 运行：

- `Flutter Dev`
- `Flutter Staging`
- `Flutter Prod`

手动运行：

```bash
flutter run \
  --dart-define-from-file=config/dev.json
```

当前支持的 `APP_ENV`：

- `dev`
- `staging`
- `prod`

## 质量检查

```bash
flutter analyze
flutter test
```

## 后续扩展方向

- 接入 `go_router` 统一路由。
- 接入 `riverpod` 作为状态管理和依赖注入方案。
- 封装 `dio` 网络层和错误处理。
- 增加 Android flavor 与 iOS scheme。
- 增加 Mason 模板，用于生成 feature、page、service 和 model。
