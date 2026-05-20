import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';

import '../../../app/theme/app_spacing.dart';
import '../../../core/widgets/app_scaffold.dart';

class NotFoundPage extends StatelessWidget {
  const NotFoundPage({super.key, this.location});

  final String? location;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final requestedLocation = location;

    return AppScaffold(
      title: 'Page not found',
      leading: BackButton(onPressed: () => _goBack(context)),
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.travel_explore, size: 72, color: colorScheme.primary),
          const SizedBox(height: AppSpacing.s24),
          Text(
            'Page not found',
            style: textTheme.headlineMedium,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: AppSpacing.s12),
          Text(
            requestedLocation == null
                ? 'The page you requested does not exist.'
                : 'No route matches $requestedLocation.',
            style: textTheme.bodyLarge,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  void _goBack(BuildContext context) {
    if (context.canPop()) {
      context.pop();
      return;
    }

    SystemNavigator.pop();
  }
}
