import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'dart:convert';
import '../models/user_model.dart';
import '../../../../core/interfaces/base_interfaces.dart';
import '../../../../core/shared/storage_keys.dart';

abstract class LocalAuthDataSource extends BaseDataSource {
  Future<void> saveToken(String token);
  Future<void> saveRefreshToken(String refreshToken);
  Future<void> saveUser(UserModel user);
  Future<String?> getToken();
  Future<String?> getRefreshToken();
  Future<UserModel?> getUser();
  Future<void> clearAuthData();
}

class LocalAuthDataSourceImpl implements LocalAuthDataSource {
  final SharedPreferences sharedPreferences;
  final FlutterSecureStorage secureStorage;


  LocalAuthDataSourceImpl({
    required this.sharedPreferences, 
    required this.secureStorage,
  });

  @override
  Future<void> saveToken(String token) async {
    await secureStorage.write(key: SecureStorageKeys.accessToken, value: token);
  }

  @override
  Future<void> saveRefreshToken(String refreshToken) async {
    await secureStorage.write(key: SecureStorageKeys.refreshToken, value: refreshToken);
  }

  @override
  Future<void> saveUser(UserModel user) async {
    final userJson = json.encode(user.toJson());
    await sharedPreferences.setString(SharedPreferencesKeys.userData, userJson);
  }

  @override
  Future<String?> getToken() async {
    return await secureStorage.read(key: SecureStorageKeys.accessToken);
  }

  @override
  Future<String?> getRefreshToken() async {
    return await secureStorage.read(key: SecureStorageKeys.refreshToken);
  }

  @override
  Future<UserModel?> getUser() async {
    final userString = sharedPreferences.getString(SharedPreferencesKeys.userData);
    if (userString != null) {
      final userMap = json.decode(userString) as Map<String, dynamic>;
      return UserModel.fromJson(userMap);
    }
    return null;
  }

  @override
  Future<void> clearAuthData() async {
    await Future.wait([
      secureStorage.delete(key: SecureStorageKeys.accessToken),
      secureStorage.delete(key: SecureStorageKeys.refreshToken),
      sharedPreferences.remove(SharedPreferencesKeys.userData),
    ]);
  }

  @override
  void dispose() {}
}