import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefService {
  static SharedPreferences? sharedPrefService;

  static Future<SharedPreferences> init() async {
    sharedPrefService = await SharedPreferences.getInstance();
    return sharedPrefService!;
  }
}
