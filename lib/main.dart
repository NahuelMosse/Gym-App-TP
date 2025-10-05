import 'package:flutter/material.dart';
import 'app.dart';
import 'injection_container.dart';
import 'core/shared/app_config.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await AppConfig.initialize();
  
  await initializeDependencies();
  
  runApp(const GymApp());
}