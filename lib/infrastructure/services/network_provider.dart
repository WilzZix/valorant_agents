import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:volarant_agents/domain/routes/i_routes.dart';
import 'package:volarant_agents/infrastructure/interceptor.dart';

class NetworkProvider {
  static IRoutes routes = const IRoutes();
  static late Dio dio;

  static Future<void> init() async {
    log('line 15 init');
    dio = Dio(
      BaseOptions(
        baseUrl: 'https://valorant-api.com/v1',

      ),
    )..interceptors.addAll(
        [
          DioInterceptor(),
          if (kDebugMode)
            LogInterceptor(
              responseHeader: true,
              requestBody: true,
              responseBody: true,
              logPrint: (e) {
                log(e.toString());
              },
            ),
        ],
      );
    log('line 39 initApp');
  }
}
