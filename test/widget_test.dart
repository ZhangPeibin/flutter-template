import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:flutter_template/app/app.dart';
import 'package:flutter_template/core/config/app_config.dart';
import 'package:flutter_template/core/providers/app_config_provider.dart';

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
        ],
        child: const TemplateApp(),
      ),
    );

    // The app name is shown in both the AppBar and the page headline.
    expect(find.text('Test App'), findsNWidgets(2));
    expect(find.text('Environment: '), findsOneWidget);
    expect(find.text('dev'), findsOneWidget);
    expect(find.text('https://api.test'), findsOneWidget);
  });
}
