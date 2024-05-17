import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:volarant_agents/domain/routes/i_routes.dart';
import 'package:volarant_agents/infrastructure/interceptor.dart';
import 'package:volarant_agents/infrastructure/services/retry_request.dart';

class NetworkProvider {
  static IRoutes routes = const IRoutes();
  static late Dio dio;

  static Future<void> init() async {
    dio = Dio(
      BaseOptions(
        baseUrl: routes.baseUrl,
        connectTimeout: const Duration(
          seconds: 5,
        ),
        receiveTimeout: const Duration(seconds: 3),
      ),
    )..interceptors.addAll(
        [
          DioInterceptor(
            RetryRequest(
              dio: dio,
              connectivity: Connectivity(),
            ),
          ),
          if (kDebugMode)
            LogInterceptor(
              responseHeader: false,
              requestBody: false,
              responseBody: true,
            ),
        ],
      );
  }
}
