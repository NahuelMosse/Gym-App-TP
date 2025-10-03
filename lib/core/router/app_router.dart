import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../features/auth/presentation/router/auth_router.dart';
import '../../features/auth/presentation/state/auth_bloc.dart';
import '../../features/auth/presentation/state/auth_state.dart';
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
  static final GoRouter router = GoRouter(
    initialLocation: AppRoutes.login,
    redirect: (context, state) {
      final authBloc = context.read<AuthBloc>();
      final isLoggedIn = authBloc.state is AuthenticatedState;
      final currentRoute = state.uri.toString();
      
      // If user is not logged in and trying to access protected routes
      if (!isLoggedIn && AppRoutes.protectedRoutes.contains(currentRoute)) {
        return AppRoutes.login;
      }
      
      // Allow all other navigation
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

