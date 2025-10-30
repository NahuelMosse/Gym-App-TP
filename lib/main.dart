import 'package:flutter/material.dart';
import 'app.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'injection_container.dart';
import 'core/shared/app_config.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await AppConfig.initialize();
  
  await initializeDependencies();
  
  runApp(Phoenix(child: const GymApp()));
}