import 'package:go_router/go_router.dart';
import '../../features/exercise/presentation/pages/exercise_list_page.dart';
import '../../features/workout/presentation/pages/workout_list_page.dart';
import '../presentation/page/creator_page.dart';

class CreatorRoutes {
  static const String creator = '/creator';
  static const String exerciseList = '${CreatorRoutes.creator}/${CreatorRoutes._exerciseListPath}';
  static const String workoutList = '${CreatorRoutes.creator}/${CreatorRoutes._workoutListPath}';

  static const String _exerciseListPath = 'exercise';
  static const String _workoutListPath = 'workout';
}

class CreatorRouter {
  static List<RouteBase> get routes => [
    GoRoute(
      path: CreatorRoutes.creator,
      pageBuilder: (context, state) => NoTransitionPage(
        key: state.pageKey,
        child: const CreatorPage(),
      ),
      routes: [
        GoRoute(
          path: CreatorRoutes._exerciseListPath,
          pageBuilder: (context, state) => NoTransitionPage(
            key: state.pageKey,
            child: const ExerciseListPage(),
          ),
        ),
        GoRoute(
          path: CreatorRoutes._workoutListPath,
          pageBuilder: (context, state) => NoTransitionPage(
            key: state.pageKey,
            child: const WorkoutListPage(),
          ),
        ),
      ],
    ),
  ];
}