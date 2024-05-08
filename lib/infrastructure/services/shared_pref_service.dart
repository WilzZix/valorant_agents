import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefService {
  static final SharedPrefService _sharedPrefService =
      SharedPrefService._internal();

  SharedPrefService._internal();

  factory SharedPrefService() {
    return _sharedPrefService;
  }

  late final SharedPreferences _prefs;

  Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  Future<void> setLoginState(String key, bool value) async {
    await _prefs.setBool(key, true);
  }

  Future<bool> getLoginState(String key) async {
    return _prefs.getBool(key)!;
  }
}
