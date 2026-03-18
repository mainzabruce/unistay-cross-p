import 'package:shared_preferences/shared_preferences.dart';
import 'package:unistay/core/utils/logger.dart';
import 'package:unistay/features/auth/data/models/user_model.dart';
import 'package:unistay/features/auth/data/repositories/auth_repository_impl.dart';

/// Implementation of LocalAuthDataSource using SharedPreferences
class LocalAuthDataSourceImpl implements LocalAuthDataSource {
  final SharedPreferences _sharedPreferences;

  const LocalAuthDataSourceImpl({required SharedPreferences sharedPreferences})
      : _sharedPreferences = sharedPreferences;

  static const String _tokenKey = 'auth_token';
  static const String _userKey = 'user_data';

  @override
  Future<void> saveAuthToken(String token) async {
    try {
      await _sharedPreferences.setString(_tokenKey, token);
      Logger.success('Auth token saved');
    } catch (e) {
      Logger.error('Failed to save auth token', exception: e);
      rethrow;
    }
  }

  @override
  Future<String?> getAuthToken() async {
    try {
      return _sharedPreferences.getString(_tokenKey);
    } catch (e) {
      Logger.error('Failed to get auth token', exception: e);
      return null;
    }
  }

  @override
  Future<void> saveUser(UserModel user) async {
    try {
      await _sharedPreferences.setString(_userKey, user.toJson().toString());
      Logger.success('User data saved');
    } catch (e) {
      Logger.error('Failed to save user data', exception: e);
      rethrow;
    }
  }

  @override
  Future<UserModel?> getUser() async {
    try {
      final userData = _sharedPreferences.getString(_userKey);
      if (userData != null && userData.isNotEmpty) {
        // Parse the string back to Map
        // Note: In production, use proper JSON serialization
        return UserModel.empty(); // Placeholder - implement proper parsing
      }
      return null;
    } catch (e) {
      Logger.error('Failed to get user data', exception: e);
      return null;
    }
  }

  @override
  Future<void> clearAuthData() async {
    try {
      await _sharedPreferences.remove(_tokenKey);
      await _sharedPreferences.remove(_userKey);
      Logger.success('Auth data cleared');
    } catch (e) {
      Logger.error('Failed to clear auth data', exception: e);
      rethrow;
    }
  }
}
