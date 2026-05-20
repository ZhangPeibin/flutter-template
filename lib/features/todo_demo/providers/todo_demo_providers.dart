import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/providers/dio_provider.dart';
import '../data/api/todo_api.dart';
import '../data/repositories/todo_repository.dart';
import '../domain/todo.dart';

final todoApiProvider = Provider<TodoApi>((ref) {
  final dio = ref.watch(dioProvider);
  return TodoApi(dio);
});

final todoRepositoryProvider = Provider<TodoRepository>((ref) {
  final api = ref.watch(todoApiProvider);
  return TodoRepository(api);
});

final demoTodoProvider = FutureProvider<Todo>((ref) {
  final repository = ref.watch(todoRepositoryProvider);
  return repository.fetchTodo(1);
});
