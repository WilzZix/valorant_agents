import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';

class ConnectivityService {
  static late StreamSubscription<ConnectivityResult> subscription;
  static bool _hasConnection = true;

  static bool get hasConnection => _hasConnection;

  static Future<void> initConnectionListener() async {
    subscription = Connectivity().onConnectivityChanged.listen((result) {
      if (result == ConnectivityResult.mobile ||
          result == ConnectivityResult.wifi) {
        _hasConnection = true;
      } else {
        _hasConnection = false;
      }
    });
  }

  static void dispose() => subscription.cancel();
}
