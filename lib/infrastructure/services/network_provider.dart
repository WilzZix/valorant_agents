import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:volarant_agents/domain/routes/i_routes.dart';
import 'package:volarant_agents/infrastructure/interceptor.dart';

class NetworkProvider {
  static IRoutes routes = const IRoutes();
  static late Dio dio;

  static Future<void> init() async {
    dio = Dio(
      BaseOptions(
        baseUrl: routes.baseUrl,
      ),
    )..interceptors.addAll(
        [
          DioInterceptor(),
          if (kDebugMode)
            LogInterceptor(
              responseHeader: false,
              requestBody: true,
              responseBody: true,
              logPrint: (error) => log(
                error.toString(),
              ),
            ),
        ],
      );
  }
}
