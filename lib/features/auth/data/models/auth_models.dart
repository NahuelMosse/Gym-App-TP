import 'user_model.dart';
import '../../../../core/errors/exceptions.dart';

class LoginRequest {
  final String email;
  final String password;

  LoginRequest({
    required this.email,
    required this.password,
  });

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'password': password,
    };
  }
}

class LoginResponse {
  final String accessToken;
  final String refreshToken;
  final UserModel user;

  LoginResponse({
    required this.accessToken,
    required this.refreshToken,
    required this.user,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    final accessToken = json['accessToken'] as String?;
    final refreshToken = json['refreshToken'] as String?;
    final userData = json['user'] as Map<String, dynamic>?;

    if (accessToken == null || accessToken.isEmpty) {
      throw const InvalidResponseException(
        message: 'Access token is missing in server response',
      );
    }

    if (refreshToken == null || refreshToken.isEmpty) {
      throw const InvalidResponseException(
        message: 'Refresh token is missing in server response',
      );
    }

    if (userData == null || userData.isEmpty) {
      throw const InvalidResponseException(
        message: 'User data is missing in server response',
      );
    }

    return LoginResponse(
      accessToken: accessToken,
      refreshToken: refreshToken,
      user: UserModel.fromJson(userData),
    );
  }
}