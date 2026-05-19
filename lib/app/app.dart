import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../core/config/app_config.dart';
import '../core/providers/app_config_provider.dart';
import 'router/app_router.dart';
import 'theme/app_theme.dart';

class TemplateApp extends ConsumerWidget {
  const TemplateApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final config = ref.watch(appConfigProvider);

    return MaterialApp.router(
      title: config.appName,
      debugShowCheckedModeBanner: config.environment != AppEnvironment.prod,
      theme: AppTheme.light(),
      darkTheme: AppTheme.dark(),
      routerConfig: appRouter,
    );
  }
}
