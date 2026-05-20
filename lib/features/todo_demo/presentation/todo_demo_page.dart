import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/network/api_exception.dart';
import '../../../core/widgets/app_error_view.dart';
import '../../../core/widgets/app_loading_view.dart';
import '../../../core/widgets/app_scaffold.dart';
import '../providers/todo_demo_providers.dart';

class TodoDemoPage extends ConsumerWidget {
  const TodoDemoPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final todo = ref.watch(demoTodoProvider);
    final textTheme = Theme.of(context).textTheme;

    return AppScaffold(
      title: 'Todo Demo',
      body: todo.when(
        data: (todo) => Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Todo #${todo.id}', style: textTheme.headlineMedium),
            const SizedBox(height: 12),
            Text(todo.title, style: textTheme.bodyLarge),
            const SizedBox(height: 16),
            Text('Completed: ${todo.completed ? 'yes' : 'no'}'),
          ],
        ),
        error: (error, stackTrace) => _TodoErrorView(error: error),
        loading: () => const AppLoadingView(message: 'Loading todo...'),
      ),
    );
  }
}

class _TodoErrorView extends StatelessWidget {
  const _TodoErrorView({required this.error});

  final Object error;

  @override
  Widget build(BuildContext context) {
    final message = switch (error) {
      ApiException(:final message) => message,
      _ => 'Failed to load todo',
    };

    return AppErrorView(message: message);
  }
}
