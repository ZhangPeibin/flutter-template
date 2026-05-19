import 'package:flutter/material.dart';

import '../../../core/config/app_config.dart';

class HomePage extends StatelessWidget {
  const HomePage({required this.config, super.key});

  final AppConfig config;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(title: Text(config.appName)),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 480),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.flutter_dash, size: 72, color: colorScheme.primary),
                const SizedBox(height: 24),
                Text(
                  'Flutter Template',
                  style: textTheme.headlineMedium,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 12),
                Text(
                  'A reusable starter project for Flutter apps.',
                  style: textTheme.bodyLarge,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 24),
                _InfoTile(label: 'Environment', value: config.environment.name),
                _InfoTile(label: 'API Base URL', value: config.apiBaseUrl),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _InfoTile extends StatelessWidget {
  const _InfoTile({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Padding(
      padding: const EdgeInsets.only(top: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('$label: ', style: textTheme.labelLarge),
          Flexible(child: Text(value, overflow: TextOverflow.ellipsis)),
        ],
      ),
    );
  }
}
