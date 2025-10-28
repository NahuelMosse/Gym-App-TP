import 'package:get_it/get_it.dart';
import 'core/core_injection.dart';
import 'features/auth/auth_injection.dart';
import 'features/exercise/exercise_injection.dart';
import 'features/internationalization/internationalization_injection.dart';
import 'features/workout/workout_injection.dart';

final serviceLocator = GetIt.instance;

Future<void> initializeDependencies() async {
  // SharedPreferences and Dio
  await CoreInjection.init(serviceLocator);

  // Features
  AuthInjection.init(serviceLocator);
  InternationalizationInjection.init(serviceLocator);
  ExerciseInjection.init(serviceLocator);
  WorkoutInjection.init(serviceLocator);
}
