import '../models/user_model.dart';

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
    final accessToken = json['accessToken'];
    final refreshToken = json['refreshToken'];
    final userData = json['user'];

    if (accessToken == null) {
      throw Exception('accessToken is required but was null. JSON: $json');
    }
    if (refreshToken == null) {
      throw Exception('refreshToken is required but was null. JSON: $json');
    }
    if (userData == null) {
      throw Exception('user data is required but was null. JSON: $json');
    }

    return LoginResponse(
      accessToken: accessToken as String,
      refreshToken: refreshToken as String,
      user: UserModel.fromJson(userData as Map<String, dynamic>),
    );
  }
}