import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefsHelper {
  static SharedPreferences? _preferences;

  static Future<void> init() async {
    _preferences = await SharedPreferences.getInstance();
  }

  static SharedPreferences get prefs {
    if (_preferences == null) {
      throw Exception('SharedPreferences not initialized.');
    }
    return _preferences!;
  }

  static Future<void> setUserInfo(String emailOrMobile,String password) async {
    await prefs.setStringList('user', [emailOrMobile,password]);
  }

  static List getUserInfo() {
    return prefs.getStringList('user') ?? [];
  }

  static Future<void> setLoggedIn(bool value) async {
    await prefs.setBool('isLoggedIn', value);
  }

  static bool getLoggedIn() {
    return prefs.getBool('isLoggedIn') ?? false;
  }

  static Future<void> clear() async {
    await prefs.clear();
  }
}
