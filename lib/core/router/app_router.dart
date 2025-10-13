import 'package:go_router/go_router.dart';
import '../../features/auth/presentation/router/auth_router.dart';
import '../../features/auth/presentation/state/auth_bloc.dart';
import '../../features/auth/presentation/state/auth_state.dart';
import 'notify_on_refresh_stream.dart';
import '../presentation/page/home_page.dart';


/// App routes definition
class AppRoutes {
  static const String login = '/login';
  static const String home = '/home';
  
  /// Routes that require authentication
  static const List<String> protectedRoutes = [
    home,
  ];
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
        return AppRoutes.home;
      }

      return null;
    },
    routes: [
      GoRoute(
        path: AppRoutes.login,
        builder: (context, state) => const AuthRouter(),
      ),
      GoRoute(
        path: AppRoutes.home,
        builder: (context, state) => const HomePage(),
      ),
    ],
  );
}

