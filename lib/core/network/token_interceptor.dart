import 'dart:async';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../constants/storage_keys.dart';

class TokenInterceptor extends Interceptor {
  final FlutterSecureStorage storage;
  final Dio dio;

  // Completer que indica un refresh en curso
  Completer<void>? _refreshCompleter;

  TokenInterceptor({required this.storage, required this.dio});

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    try {
      final token = await storage.read(key: SecureStorageKeys.accessToken);
      if (token != null) {
        options.headers['Authorization'] = 'Bearer $token';
      }
    } catch (_) {}
    handler.next(options);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    final status = err.response?.statusCode;
    final path = err.requestOptions.path;

    final isAuthPath = path.contains('/auth/refresh') || path.contains('/auth/login');

    if (status == 401 && !isAuthPath) {
      try {
        if (_refreshCompleter != null) { // Active refresh
          await _refreshCompleter!.future;
        } else { // No active refresh
          _refreshCompleter = Completer<void>();
          try {
            final refreshToken = await storage.read(key: SecureStorageKeys.refreshToken);
            if (refreshToken == null) throw Exception('No refresh token');

            final response = await dio.post('/api/v1/auth/refresh', data: {'refresh_token': refreshToken});
            final newAccessToken = response.data['accessToken'] as String?;
            final newRefreshToken = response.data['refreshToken'] as String?;

            if (newAccessToken == null || newRefreshToken == null) throw Exception('Invalid refresh response');

            await storage.write(key: SecureStorageKeys.accessToken, value: newAccessToken);
            await storage.write(key: SecureStorageKeys.refreshToken, value: newRefreshToken);

            _refreshCompleter!.complete();
          } catch (e) {
            _refreshCompleter!.completeError(e);
            rethrow;
          } finally {
            _refreshCompleter = null;
          }
        }

        // Retry original request
        final opts = err.requestOptions;
        final clonedOriginalRequest = await dio.fetch(opts);
        return handler.resolve(clonedOriginalRequest);
      } catch (e) {
        await storage.delete(key: SecureStorageKeys.accessToken);
        await storage.delete(key: SecureStorageKeys.refreshToken);
        return handler.next(err);
      }
    }

    handler.next(err);
  }
}
