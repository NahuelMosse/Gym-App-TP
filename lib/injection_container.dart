import 'package:get_it/get_it.dart';
import 'core/injection/core_injection.dart';
import 'features/auth/injection/auth_injection.dart';

final serviceLocator = GetIt.instance;

Future<void> initializeDependencies() async {
  // SharedPreferences and Dio
  await CoreInjection.init(serviceLocator);

  // Features
  AuthInjection.init(serviceLocator);
}