import 'package:flutter/material.dart';

import '../core/config/app_config.dart';
import '../features/home/presentation/home_page.dart';
import 'theme/app_theme.dart';

class TemplateApp extends StatelessWidget {
  const TemplateApp({required this.config, super.key});

  final AppConfig config;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: config.appName,
      debugShowCheckedModeBanner: config.environment != AppEnvironment.prod,
      theme: AppTheme.light(),
      darkTheme: AppTheme.dark(),
      home: HomePage(config: config),
    );
  }
}
