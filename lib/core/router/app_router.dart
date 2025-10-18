import 'package:go_router/go_router.dart';
import '../../features/auth/presentation/router/auth_router.dart';
import '../../features/auth/presentation/state/auth_bloc.dart';
import '../../features/auth/presentation/state/auth_state.dart';
import '../presentation/widgets/main_navigation_bar.dart';
import 'notify_on_refresh_stream.dart';

/// App routes definition
class AppRoutes {
  static const String login = '/login';
  static const String mainNavigation = '/mainNavigation';

  /// Routes that require authentication
  static const List<String> protectedRoutes = [mainNavigation];
}

/// GoRouter configuration
class AppRouter {
  static GoRouter router(AuthBloc authBloc) => GoRouter(
    initialLocation: AppRoutes.login,
    refreshListenable: NotifyOnRefreshStream(authBloc.stream),
    redirect: (context, state) {
      final isLoggedIn = authBloc.state is AuthenticatedState;
      final currentRoute = state.uri.toString();

      // If user is not logged in and trying to access protected routes
      if (!isLoggedIn && AppRoutes.protectedRoutes.contains(currentRoute)) {
        return AppRoutes.login;
      }

      // If user is logged in and on the login page, send to home
      if (isLoggedIn && currentRoute == AppRoutes.login) {
        return AppRoutes.mainNavigation;
      }

      return null;
    },
    routes: [
      GoRoute(
        path: AppRoutes.login,
        builder: (context, state) => const AuthRouter(),
      ),
      GoRoute(
        path: AppRoutes.mainNavigation,
        builder: (context, state) => const MainNavigation(),
      ),
    ],
  );
}
