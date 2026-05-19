import 'package:flutter_test/flutter_test.dart';

import 'package:flutter_template/app/app.dart';
import 'package:flutter_template/core/config/app_config.dart';

void main() {
  testWidgets('renders template home page', (WidgetTester tester) async {
    const config = AppConfig(
      appName: 'Test App',
      environment: AppEnvironment.dev,
      apiBaseUrl: 'https://api.test',
    );

    await tester.pumpWidget(const TemplateApp(config: config));

    expect(find.text('Test App'), findsNWidgets(2));
    expect(find.text('Environment: '), findsOneWidget);
    expect(find.text('dev'), findsOneWidget);
    expect(find.text('https://api.test'), findsOneWidget);
  });
}
