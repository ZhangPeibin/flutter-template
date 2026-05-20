import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:flutter_template/features/not_found/presentation/not_found_page.dart';

void main() {
  testWidgets('renders not found details', (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: NotFoundPage(location: '/missing'),
      ),
    );

    expect(find.text('Page not found'), findsNWidgets(2));
    expect(find.text('No route matches /missing.'), findsOneWidget);
    expect(find.byType(BackButton), findsOneWidget);
  });
}
