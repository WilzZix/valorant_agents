import 'dart:io';

import 'package:dio/dio.dart';
import 'package:volarant_agents/infrastructure/services/connectivity_service.dart';

class DioInterceptor extends Interceptor {
  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    if (ConnectivityService.hasConnection) {
      return super.onRequest(options, handler);
    } else {
      return handler.reject(DioException(
        requestOptions: options,
        error: 'Вы в оффлайне 🙈',
      ));
    }
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {}

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {}
}
