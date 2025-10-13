import 'package:dio/dio.dart';
import '../models/auth_models.dart';
import '../models/user_model.dart';
import '../../../../core/interfaces/base_interfaces.dart';

abstract class RemoteAuthDataSource extends BaseDataSource {
  Future<LoginResponse> login(LoginRequest request);
  Future<void> logout();
  Future<UserModel> getCurrentUser();
  Future<void> refreshToken(String refreshToken);
}

class RemoteAuthDataSourceImpl implements RemoteAuthDataSource {
  final Dio dio;
  static const String baseUrl = 'https://your-api-url.com/api/v1';

  RemoteAuthDataSourceImpl({required this.dio}) {
    // Configurar interceptores para el token
    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          // Aquí puedes agregar el token a todas las requests automáticamente
          // final token = await getStoredToken();
          // if (token != null) {
          //   options.headers['Authorization'] = 'Bearer $token';
          // }
          handler.next(options);
        },
        onError: (error, handler) async {
          // Manejar errores de autenticación
          if (error.response?.statusCode == 401) {
            // Token expirado, intentar refresh
            // await refreshTokenLogic();
          }
          handler.next(error);
        },
      ),
    );
  }

  @override
  Future<LoginResponse> login(LoginRequest request) async {
    try {
      final response = await dio.post(
        '$baseUrl/auth/login',
        data: request.toJson(),
      );

      if (response.statusCode == 200) {
        return LoginResponse.fromJson(response.data);
      } else {
        throw DioException(
          requestOptions: response.requestOptions,
          response: response,
          message: 'Login failed',
        );
      }
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }

  @override
  Future<void> logout() async {
    try {
      await dio.post('$baseUrl/auth/logout');
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }

  @override
  Future<UserModel> getCurrentUser() async {
    try {
      final response = await dio.get('$baseUrl/auth/me');
      
      if (response.statusCode == 200) {
        return UserModel.fromJson(response.data);
      } else {
        throw DioException(
          requestOptions: response.requestOptions,
          response: response,
          message: 'Failed to get current user',
        );
      }
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }

  @override
  Future<void> refreshToken(String refreshToken) async {
    try {
      final response = await dio.post(
        '$baseUrl/auth/refresh',
        data: {'refresh_token': refreshToken},
      );

      if (response.statusCode != 200) {
        throw DioException(
          requestOptions: response.requestOptions,
          response: response,
          message: 'Token refresh failed',
        );
      }
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }

  Exception _handleDioError(DioException e) {
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return Exception('Timeout de conexión');
      case DioExceptionType.badResponse:
        final statusCode = e.response?.statusCode;
        switch (statusCode) {
          case 400:
            return Exception('Datos inválidos');
          case 401:
            return Exception('Credenciales incorrectas');
          case 403:
            return Exception('Acceso denegado');
          case 404:
            return Exception('Endpoint no encontrado');
          case 500:
            return Exception('Error del servidor');
          default:
            return Exception('Error HTTP: $statusCode');
        }
      case DioExceptionType.cancel:
        return Exception('Petición cancelada');
      case DioExceptionType.connectionError:
        return Exception('Error de conexión');
      default:
        return Exception('Error desconocido: ${e.message}');
    }
  }

  @override
  void dispose() {
    // Dio no necesita limpieza específica en este caso
    // pero podríamos cancelar requests pendientes si los tuviéramos
  }
}