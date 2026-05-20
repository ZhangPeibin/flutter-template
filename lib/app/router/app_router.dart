import 'package:go_router/go_router.dart';

import '../../features/home/presentation/home_page.dart';
import '../../features/not_found/presentation/not_found_page.dart';
import '../../features/todo_demo/presentation/todo_demo_page.dart';

class AppRoutePaths {
  const AppRoutePaths._();

  static const home = '/';
  static const todoDemo = '/todo-demo';
}

class AppRouteNames {
  const AppRouteNames._();
  static const home = 'home';
  static const todoDemo = 'todoDemo';
}

final appRouter = GoRouter(
  initialLocation: AppRoutePaths.home,
  errorBuilder: (context, state) => NotFoundPage(
    location: state.uri.toString(),
  ),
  routes: [
    GoRoute(
      path: AppRoutePaths.home,
      name: AppRouteNames.home,
      builder: (context, state) => const HomePage(),
    ),

    GoRoute(
      path: AppRoutePaths.todoDemo,
      name: AppRouteNames.todoDemo,
      builder: (context, state) => const TodoDemoPage(),
    ),
  ],
);
