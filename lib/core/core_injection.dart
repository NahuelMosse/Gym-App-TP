import 'package:get_it/get_it.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'network/token_interceptor.dart';
import 'shared/app_config.dart';
import 'package:flutter/foundation.dart';

class CoreInjection {
  static Future<void> init(GetIt serviceLocator) async {

    final sharedPreferences = await SharedPreferences.getInstance();
    serviceLocator.registerSingleton<SharedPreferences>(sharedPreferences);

    final dio = Dio(BaseOptions(
      baseUrl: AppConfig.apiUrl,
      connectTimeout: AppConfig.httpTimeout,
      receiveTimeout: AppConfig.httpTimeout,
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
    ));

    // Dio logger config
    dio.interceptors.add(LogInterceptor(
      requestBody: kDebugMode, // debug only
      responseBody: kDebugMode, // debug only
      logPrint: (object) {
        if (kDebugMode) { // debug only
          print('[HTTP] $object');
        }
      },
    ));

    final secureStorage = const FlutterSecureStorage();
    serviceLocator.registerSingleton<FlutterSecureStorage>(secureStorage);

    dio.interceptors.add(TokenInterceptor(storage: secureStorage, dio: dio));

    serviceLocator.registerSingleton<Dio>(dio);
  }
}