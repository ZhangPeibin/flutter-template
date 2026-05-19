import 'package:go_router/go_router.dart';

import '../../features/home/presentation/home_page.dart';

class AppRoutePaths {
  const AppRoutePaths._();

  static const home = '/';
}

class AppRouteNames {
  const AppRouteNames._();

  static const home = 'home';
}

final appRouter = GoRouter(
  initialLocation: AppRoutePaths.home,
  routes: [
    GoRoute(
      path: AppRoutePaths.home,
      name: AppRouteNames.home,
      builder: (context, state) => const HomePage(),
    ),
  ],
);
