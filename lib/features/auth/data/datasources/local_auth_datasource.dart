import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../models/user_model.dart';
import '../../../../core/interfaces/base_interfaces.dart';

abstract class LocalAuthDataSource extends BaseDataSource {
  Future<void> saveToken(String token);
  Future<void> saveRefreshToken(String refreshToken);
  Future<void> saveUser(UserModel user);
  Future<String?> getToken();
  Future<String?> getRefreshToken();
  Future<UserModel?> getUser();
  Future<bool> isLoggedIn();
  Future<void> clearAuthData();
}

class LocalAuthDataSourceImpl implements LocalAuthDataSource {
  final SharedPreferences sharedPreferences;

  static const String _tokenKey = 'auth_token';
  static const String _refreshTokenKey = 'refresh_token';
  static const String _userKey = 'user_data';

  LocalAuthDataSourceImpl({required this.sharedPreferences});

  @override
  Future<void> saveToken(String token) async {
    await sharedPreferences.setString(_tokenKey, token);
  }

  @override
  Future<void> saveRefreshToken(String refreshToken) async {
    await sharedPreferences.setString(_refreshTokenKey, refreshToken);
  }

  @override
  Future<void> saveUser(UserModel user) async {
    final userJson = json.encode(user.toJson());
    await sharedPreferences.setString(_userKey, userJson);
  }

  @override
  Future<String?> getToken() async {
    return sharedPreferences.getString(_tokenKey);
  }

  @override
  Future<String?> getRefreshToken() async {
    return sharedPreferences.getString(_refreshTokenKey);
  }

  @override
  Future<UserModel?> getUser() async {
    final userString = sharedPreferences.getString(_userKey);
    if (userString != null) {
      final userMap = json.decode(userString) as Map<String, dynamic>;
      return UserModel.fromJson(userMap);
    }
    return null;
  }

  @override
  Future<bool> isLoggedIn() async {
    final token = await getToken();
    return token != null && token.isNotEmpty;
  }

  @override
  Future<void> clearAuthData() async {
    await Future.wait([
      sharedPreferences.remove(_tokenKey),
      sharedPreferences.remove(_refreshTokenKey),
      sharedPreferences.remove(_userKey),
    ]);
  }

  @override
  void dispose() {
    // SharedPreferences no necesita limpieza específica
    // pero podríamos limpiar datos en cache si los tuviéramos
  }
}