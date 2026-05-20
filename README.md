# Flutter Template

一个可复用的 Flutter 基础项目模板，用于快速启动新的 Android / iOS Flutter App。

## 目标

- 保持基础工程可直接运行。
- 提供多环境配置入口。
- 提供清晰的目录结构，方便后续扩展路由、网络、状态管理和设计系统。
- 作为多个业务项目的起点，而不是绑定单一业务。

## 目录结构

```text
lib/
  app/
    app.dart
    router/
      app_router.dart
    theme/
      app_theme.dart
  core/
    config/
      app_config.dart
    logging/
      app_logger.dart
      console_app_logger.dart
    network/
      api_exception.dart
      dio_logging_interceptor.dart
      error_interceptor.dart
    providers/
      app_config_provider.dart
      dio_provider.dart
      key_value_storage_provider.dart
      logger_provider.dart
      secure_storage_provider.dart
    storage/
      flutter_secure_storage_adapter.dart
      key_value_storage.dart
      secure_storage.dart
      shared_preferences_key_value_storage.dart
  features/
    home/
      presentation/
        home_page.dart
    not_found/
      presentation/
        not_found_page.dart
    todo_demo/
      data/
        api/
        repositories/
      domain/
      presentation/
      providers/
  main.dart
```

## 从模板创建新项目

1. 复制模板

   ```bash
   rsync -a --exclude .git <template-dir>/ my_app/
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
   - `README.md`
   - `.vscode/launch.json`
   - `config/dev.json`、`config/staging.json`、`config/prod.example.json`
   - Android `namespace`、`applicationId`、Launcher 名称和 `MainActivity.kt` package 路径
   - iOS `CFBundleDisplayName`、`CFBundleName`、`PRODUCT_BUNDLE_IDENTIFIER`
   - `lib/`、`test/`、`integration_test/` 下 Dart 文件里的模板包名和默认 App 名称
   - `.idea/`、`android/.idea/` 和模板生成的 `.iml` 文件

   如果需要配置签名团队，打开 `ios/Runner.xcworkspace` → `Runner` target → `Signing & Capabilities` 修改 Team。

   注意：脚本需要在 Flutter 项目根目录执行，并且新名字不能包含旧模板名或旧包名。

3. 清理 IDE 残留文件

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

   默认会把初始分支改成 `main`。如果项目里已经存在 `.git`，脚本会停止并提示先删除复制过来的 `.git` 目录。

   如果想直接创建首个提交：

   ```bash
   dart run tool/init_git.dart --commit --message "Initial commit"
   ```

   也可以指定初始分支：

   ```bash
   dart run tool/init_git.dart --branch main
   dart run tool/init_git.dart --no-branch
   ```

6. 重新打开 IDE

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
- `config/prod.example.json`（模板，已提交）
- `config/prod.json`（本地实际生效的生产配置，**已 gitignore**，可包含密钥）

首次拉取项目后，执行下面任意一条命令生成本地 `config/prod.json`：

```bash
make bootstrap
# 或者手动：
cp config/prod.example.json config/prod.json
```

`make run-prod` 已自动调用 `bootstrap`，所以如果你只用 `make run-prod` 也无需手动复制。

`APP_NAME` 会影响 Flutter 页面里读取 `AppConfig.appName` 的位置，例如 `MaterialApp.title` 和首页标题。Android Launcher 与 iOS Home Screen 显示名来自平台配置，需要通过 `tool/setup_project.dart` 或手动修改 Android `android:label`、iOS `CFBundleDisplayName`。

### Makefile 命令

| 命令 | 作用 |
| --- | --- |
| `make get` | 执行 `flutter pub get` |
| `make bootstrap` | 若不存在，则从 `config/prod.example.json` 生成 `config/prod.json` |
| `make run-dev` | 以 `APP_ENV=dev` 启动 |
| `make run-staging` | 以 `APP_ENV=staging` 启动 |
| `make run-prod` | 自动执行 `bootstrap`，以 `APP_ENV=prod` 和 release 模式启动 |
| `make analyze` | 执行 `flutter analyze` |
| `make test` | 执行 `flutter test` |
| `make clean` | 执行 `flutter clean` |

常用运行命令：

```bash
make run-dev
make run-staging
make run-prod
```

如果 `make run-dev` 无法接收热重载输入，可以直接运行 Flutter 命令：

```bash
flutter run --dart-define-from-file=config/dev.json
flutter run --dart-define-from-file=config/staging.json
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

## 状态管理

模板已接入 `flutter_riverpod`。`lib/main.dart` 在启动时创建 `AppConfig`、初始化 `SharedPreferences`，并通过 `ProviderScope` 覆盖 `appConfigProvider` 与 `sharedPreferencesProvider`。页面可以使用 `ref.watch(appConfigProvider)` 读取运行时配置。

## 路由

模板已接入 `go_router`。路由定义集中在 `lib/app/router/app_router.dart`，`TemplateApp` 使用 `MaterialApp.router` 作为统一入口。`HomePage` 通过 `context.pushNamed(...)` 演示命名路由跳转，未匹配到的路径会显示 `NotFoundPage`。

新增页面路由示例：

```dart
class AppRoutePaths {
  static const profile = '/profile';
}

class AppRouteNames {
  static const profile = 'profile';
}

GoRoute(
  path: AppRoutePaths.profile,
  name: AppRouteNames.profile,
  builder: (context, state) => const ProfilePage(),
)
```

页面跳转示例：

```dart
context.pushNamed(AppRouteNames.profile);
```

如果需要传 path parameter：

```dart
context.pushNamed(
  AppRouteNames.profile,
  pathParameters: {'id': userId},
);
```

## 网络

模板已接入 `dio`。`lib/core/providers/dio_provider.dart` 中的 `dioProvider` 会读取 `appConfigProvider`，并使用 `AppConfig.apiBaseUrl` 作为 `BaseOptions.baseUrl`。它也会读取 `loggerProvider`，通过 `DioLoggingInterceptor` 统一记录 request、response 和 error。`todo_demo` feature 使用 JSONPlaceholder 的 `/todos/1` 演示 API layer、repository layer、provider 和页面状态。

Demo feature 结构：

- `lib/core/network/dio_logging_interceptor.dart`：通过 `AppLogger` 记录 Dio 请求、响应和错误。
- `lib/features/todo_demo/data/api/todo_api.dart`：负责 Dio 请求和 `DioException` 到 `ApiException` 的转换。
- `lib/features/todo_demo/data/repositories/todo_repository.dart`：调用 API layer，并把 JSON 转成 domain model。
- `lib/features/todo_demo/providers/todo_demo_providers.dart`：组装 API、repository 和 `FutureProvider`。
- `lib/features/todo_demo/presentation/todo_demo_page.dart`：展示 loading、data、error 状态。

API layer + repository 示例：

```dart
class UserApi {
  const UserApi(this._dio);

  final Dio _dio;

  Future<Map<String, dynamic>> fetchUser(String id) async {
    try {
      final response = await _dio.get<Map<String, dynamic>>('/users/$id');
      return response.data!;
    } on DioException catch (error) {
      throw ApiException.fromDioException(error);
    }
  }
}

class UserRepository {
  const UserRepository(this._api);

  final UserApi _api;

  Future<User> fetchUser(String id) async {
    final json = await _api.fetchUser(id);
    return User.fromJson(json);
  }
}

final userApiProvider = Provider<UserApi>((ref) {
  return UserApi(ref.watch(dioProvider));
});

final userRepositoryProvider = Provider<UserRepository>((ref) {
  return UserRepository(ref.watch(userApiProvider));
});
```

错误处理示例：

```dart
try {
  final user = await ref.read(userRepositoryProvider).fetchUser('123');
} on ApiException catch (error) {
  // 根据 error.type / statusCode 做业务处理。
}
```

## 日志

模板已接入 `logger`，并通过 `lib/core/logging/app_logger.dart` 暴露 `AppLogger` 抽象。业务代码应通过 `lib/core/providers/logger_provider.dart` 中的 `loggerProvider` 获取日志能力，避免直接依赖具体日志 SDK，方便后续替换为 `sentry_flutter` 或其他实现。

当前 `logger` 实现：

- `lib/core/logging/app_logger.dart`：定义项目自己的日志接口。
- `lib/core/logging/console_app_logger.dart`：把 `AppLogger` 转接到 `logger` package，用于本地控制台日志。
- `lib/core/providers/logger_provider.dart`：创建并暴露当前日志实现。
- `lib/core/network/dio_logging_interceptor.dart`：让 Dio 使用 `loggerProvider` 记录网络日志。

如果要把日志 SDK 切换为 `logger` package，做法是：

1. 在 `pubspec.yaml` 添加 `logger`。
2. 实现一个 `AppLogger` 的适配器，例如 `ConsoleAppLogger`。
3. 在 `loggerProvider` 中返回新的适配器。
4. 业务代码继续使用 `ref.read(loggerProvider)` 或 `ref.watch(loggerProvider)`，不要直接创建 `Logger()`。

如果以后要从 `logger` 切换到其他 SDK，只需要新增一个实现 `AppLogger` 的适配器，并替换 `loggerProvider` 中返回的对象。Dio 会继续通过 `loggerProvider` 记录网络日志，不需要改业务代码。

业务代码示例：

```dart
final logger = ref.read(loggerProvider);

logger.info('Todo demo page opened');
logger.error(
  'Failed to load user profile',
  error: error,
  stackTrace: stackTrace,
);
```

切换实现示例：

```dart
class MySdkAppLogger implements AppLogger {
  const MySdkAppLogger(this._sdk);

  final MyLoggingSdk _sdk;

  @override
  void info(String message, {Object? error, StackTrace? stackTrace}) {
    _sdk.logInfo(message);
  }

  // 继续实现 debug、warning、error。
}

final loggerProvider = Provider<AppLogger>((ref) {
  return MySdkAppLogger(MyLoggingSdk());
});
```

## 本地存储

模板预置了两套存储抽象，业务代码应通过 Riverpod 注入它们，不直接依赖具体实现。

| 抽象 | 文件 | 默认实现 | 适用场景 |
| --- | --- | --- | --- |
| `KeyValueStorage` | `lib/core/storage/key_value_storage.dart` | `SharedPreferencesKeyValueStorage`（`shared_preferences`） | 非敏感的偏好设置：主题、语言、引导页状态等 |
| `SecureStorage` | `lib/core/storage/secure_storage.dart` | `FlutterSecureStorageAdapter`（`flutter_secure_storage`） | 敏感数据：access token、refresh token、凭证等 |

### Provider

- `lib/core/providers/key_value_storage_provider.dart`：暴露 `keyValueStorageProvider` 和 `sharedPreferencesProvider`。
- `lib/core/providers/secure_storage_provider.dart`：暴露 `secureStorageProvider`。

`lib/main.dart` 在启动时 `await SharedPreferences.getInstance()`，并通过 `ProviderScope.overrides` 注入到 `sharedPreferencesProvider`。测试可以用 `SharedPreferences.setMockInitialValues({...})` 覆盖。

### 基础用法

```dart
final prefs = ref.read(keyValueStorageProvider);
await prefs.setString('locale', 'zh_CN');

final secure = ref.read(secureStorageProvider);
await secure.write('access_token', token);
final token = await secure.read('access_token');
```

### 页面中保存非敏感配置

```dart
class LocaleButton extends ConsumerWidget {
  const LocaleButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return FilledButton(
      onPressed: () async {
        final storage = ref.read(keyValueStorageProvider);
        await storage.setString('locale', 'zh_CN');
      },
      child: const Text('Use Chinese'),
    );
  }
}
```

### Repository 中保存和读取 token

```dart
class AuthRepository {
  const AuthRepository(this._secureStorage);

  final SecureStorage _secureStorage;

  Future<void> saveToken(String token) {
    return _secureStorage.write('access_token', token);
  }

  Future<String?> readToken() {
    return _secureStorage.read('access_token');
  }

  Future<void> signOut() {
    return _secureStorage.delete('access_token');
  }
}

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  return AuthRepository(ref.watch(secureStorageProvider));
});
```

### 测试中覆盖 `SharedPreferences`

```dart
testWidgets('reads locale from storage', (tester) async {
  SharedPreferences.setMockInitialValues({'locale': 'zh_CN'});
  final prefs = await SharedPreferences.getInstance();

  await tester.pumpWidget(
    ProviderScope(
      overrides: [
        sharedPreferencesProvider.overrideWithValue(prefs),
      ],
      child: const TemplateApp(),
    ),
  );
});
```

### 替换底层实现

切换底层实现时，只需新增一个实现 `KeyValueStorage` 或 `SecureStorage` 的类，并在对应的 provider 中返回它，业务代码无须改动。

## 后续扩展方向

- 接入 `sentry_flutter` 作为生产错误上报。
- 增加 Android flavor 与 iOS scheme。
- 增加 Mason 模板，用于生成 feature、page、service 和 model。
