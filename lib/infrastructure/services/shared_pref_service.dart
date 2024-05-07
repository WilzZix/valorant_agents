import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefService {
  static SharedPreferences? sharedPrefService;

  static Future<SharedPreferences> init() async {
    sharedPrefService = await SharedPreferences.getInstance();
    return sharedPrefService!;
  }

  static Future<void> setLoginState(String key, bool value) async {
    await sharedPrefService!.setBool(key, true);
  }

  static Future<bool> getLoginState(String key) async {
    return sharedPrefService!.getBool(key)!;
  }
}
