import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:flutter_template/app/app.dart';
import 'package:flutter_template/core/config/app_config.dart';
import 'package:flutter_template/core/providers/app_config_provider.dart';
import 'package:flutter_template/features/todo_demo/domain/todo.dart';
import 'package:flutter_template/features/todo_demo/providers/todo_demo_providers.dart';

void main() {
  testWidgets('renders template home page', (WidgetTester tester) async {
    // Keep the widget test independent from --dart-define files by injecting
    // the runtime config directly.
    const config = AppConfig(
      appName: 'Test App',
      environment: AppEnvironment.dev,
      apiBaseUrl: 'https://api.test',
    );

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          appConfigProvider.overrideWithValue(config),
          demoTodoProvider.overrideWithValue(
            const AsyncValue.data(
              Todo(
                id: 1,
                userId: 1,
                title: 'Test todo',
                completed: false,
              ),
            ),
          ),
        ],
        child: const TemplateApp(),
      ),
    );

    // The app name is shown in both the AppBar and the page headline.
    expect(find.text('Test App'), findsNWidgets(2));
    expect(find.text('Environment: '), findsOneWidget);
    expect(find.text('dev'), findsOneWidget);
    expect(find.text('https://api.test'), findsOneWidget);
    expect(find.text('Open API demo'), findsOneWidget);

    // The home page includes a small go_router example route.
    await tester.tap(find.text('Open API demo'));
    await tester.pumpAndSettle();

    // Successful navigation proves TemplateApp is using MaterialApp.router and
    // the API demo route is registered.
    expect(find.text('Todo Demo'), findsOneWidget);
  });
}
