import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../app/router/app_router.dart';
import '../../../app/theme/app_spacing.dart';
import '../../../core/providers/app_config_provider.dart';
import '../../../core/widgets/app_button.dart';
import '../../../core/widgets/app_scaffold.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final config = ref.watch(appConfigProvider);
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return AppScaffold(
      title: config.appName,
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.flutter_dash, size: 72, color: colorScheme.primary),
          const SizedBox(height: AppSpacing.s24),
          Text(
            config.appName,
            style: textTheme.headlineMedium,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: AppSpacing.s12),
          Text(
            'A reusable starter project for Flutter apps.',
            style: textTheme.bodyLarge,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: AppSpacing.s24),
          _InfoTile(label: 'Environment', value: config.environment.name),
          _InfoTile(label: 'API Base URL', value: config.apiBaseUrl),
          const SizedBox(height: AppSpacing.s24),
          const Wrap(
            spacing: AppSpacing.s12,
            runSpacing: AppSpacing.s12,
            alignment: WrapAlignment.center,
            children: [_TodoDemoNavigationButton()],
          ),
        ],
      ),
    );
  }
}

class _TodoDemoNavigationButton extends StatelessWidget {
  const _TodoDemoNavigationButton();

  @override
  Widget build(BuildContext context) {
    return AppButton(
      label: 'Open API demo',
      variant: AppButtonVariant.secondary,
      onPressed: () => context.pushNamed(AppRouteNames.todoDemo),
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
      padding: const EdgeInsets.only(top: AppSpacing.s8),
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
