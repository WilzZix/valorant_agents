import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefService {
  String loginStatus = 'loginStatus';
  String displayName = 'displayName';
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

  Future<void> setLoginState(bool value) async {
    await _prefs.setBool(loginStatus, true);
  }

  Future<void> setDisplayName(String value) async {
    await _prefs.setString(displayName, value);
  }

  Future<bool> getLoginState() async {
    if (_prefs.getBool(loginStatus) == null) {
      return false;
    } else {
      return _prefs.getBool(loginStatus)!;
    }
  }

  Future<String> getDisplayName() async {
    return _prefs.getString(displayName)!;
  }
}
