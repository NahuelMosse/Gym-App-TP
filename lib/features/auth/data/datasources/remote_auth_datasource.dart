import 'package:dio/dio.dart';
import '../models/auth_models.dart';
import '../models/user_model.dart';
import '../../../../core/interfaces/base_interfaces.dart';
import '../../../../core/errors/exceptions.dart';

abstract class RemoteAuthDataSource extends BaseDataSource {
  Future<LoginResponse> login(LoginRequest request);
  Future<UserModel> getCurrentUser();
  Future<void> refreshToken(String refreshToken);
}

class RemoteAuthDataSourceImpl implements RemoteAuthDataSource {
  final Dio dio;

  RemoteAuthDataSourceImpl({required this.dio});

  @override
  Future<LoginResponse> login(LoginRequest request) async {
    try {
      final response = await dio.post(
        '/auth/login',
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
  Future<UserModel> getCurrentUser() async {
    try {
      final response = await dio.get('/auth/me');
      
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
        '/auth/refresh',
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

  DomainException _handleDioError(DioException e) {
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return const TimeoutException();
      case DioExceptionType.badResponse:
        final statusCode = e.response?.statusCode;
        switch (statusCode) {
          case 400:
            return const BadRequestException();
          case 401:
            return const UnauthorizedException();
          case 403:
            return const ForbiddenException();
          case 404:
            return const NotFoundException();
          case 500:
            return const InternalServerException();
          default:
            return ServerException(message: 'Error HTTP: $statusCode', code: statusCode);
        }
      case DioExceptionType.cancel:
        return const CancelledException();
      case DioExceptionType.connectionError:
        return const ConnectionException();
      default:
        return NetworkException(message: 'Error de red: ${e.message}');
    }
  }

  @override
  void dispose() {}
}