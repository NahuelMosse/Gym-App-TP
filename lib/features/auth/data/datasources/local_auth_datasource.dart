import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../../../../core/interfaces/base_interfaces.dart';
import '../../../../core/shared/storage_keys.dart';

abstract class LocalAuthDataSource extends BaseDataSource {
  Future<void> saveToken(String token);
  Future<void> saveRefreshToken(String refreshToken);
  Future<void> saveUserInfo({required String id, required String name, required String email});
  Future<String?> getToken();
  Future<String?> getRefreshToken();
  Future<String?> getUserId();
  Future<String?> getUserName();
  Future<String?> getUserEmail();
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
  Future<void> saveUserInfo({required String id, required String name, required String email}) async {
    await Future.wait([
      sharedPreferences.setString(SharedPreferencesKeys.userId, id),
      sharedPreferences.setString(SharedPreferencesKeys.userName, name),
      sharedPreferences.setString(SharedPreferencesKeys.userEmail, email),
    ]);
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
  Future<String?> getUserId() async {
    return sharedPreferences.getString(SharedPreferencesKeys.userId);
  }

  @override
  Future<String?> getUserName() async {
    return sharedPreferences.getString(SharedPreferencesKeys.userName);
  }

  @override
  Future<String?> getUserEmail() async {
    return sharedPreferences.getString(SharedPreferencesKeys.userEmail);
  }

  @override
  Future<void> clearAuthData() async {
    await Future.wait([
      secureStorage.delete(key: SecureStorageKeys.accessToken),
      secureStorage.delete(key: SecureStorageKeys.refreshToken),
      sharedPreferences.remove(SharedPreferencesKeys.userId),
      sharedPreferences.remove(SharedPreferencesKeys.userName),
      sharedPreferences.remove(SharedPreferencesKeys.userEmail),
    ]);
  }

  @override
  void dispose() {}
}