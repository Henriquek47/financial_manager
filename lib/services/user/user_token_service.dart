import 'package:shared_preferences/shared_preferences.dart';

class UserTokenService {
  static final UserTokenService instance = UserTokenService._internal();

  factory UserTokenService() {
    return instance;
  }

  UserTokenService._internal();

  final SharedPreferencesAsync asyncPrefs = SharedPreferencesAsync();

  void setToken(String token) {
    asyncPrefs.setString("token", token);
  }

  Future<String?> getToken() async {
    return asyncPrefs.getString("token");
  }

  Future<void> clearToken() async {
    await asyncPrefs.remove("token"); 
  }
}
