import 'package:flutter/material.dart';
import 'package:flutter_template/core/widgets/splash_widget.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('splash uses Flutter Template branding by default', (
    tester,
  ) async {
    await tester.pumpWidget(const MaterialApp(home: SplashWidget()));

    expect(find.text('Flutter Template'), findsOneWidget);
    expect(find.text('A reusable Flutter starter.'), findsOneWidget);
    expect(find.text('ArvoPay'), findsNothing);
    expect(find.textContaining('crypto'), findsNothing);
  });
}
