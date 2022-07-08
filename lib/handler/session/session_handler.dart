import 'package:shared_preferences/shared_preferences.dart';

class SessionHandler {
  SharedPreferences? _preferences;

  SessionHandler._();

  static Future<SessionHandler> getInstance() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return SessionHandler._().._preferences = preferences;
  }

  /// Method to store token
  Future<bool?> storeToken(String token) async {
    return _preferences?.setString("token", token);
  }

  /// Getter to store token
  bool get newUser =>
      _preferences?.getBool("used") == null ||
      _preferences?.getBool("used") == false;

  Future<bool?> used(bool v) async {
    return _preferences?.setBool("used", v);
  }
}
