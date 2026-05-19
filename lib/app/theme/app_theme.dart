import 'package:flutter/material.dart';

class AppTheme {
  const AppTheme._();

  static const _seedColor = Color(0xFF2563EB);

  static ThemeData light() {
    return ThemeData(
      colorScheme: ColorScheme.fromSeed(seedColor: _seedColor),
      useMaterial3: true,
    );
  }

  static ThemeData dark() {
    return ThemeData(
      colorScheme: ColorScheme.fromSeed(
        seedColor: _seedColor,
        brightness: Brightness.dark,
      ),
      useMaterial3: true,
    );
  }
}
