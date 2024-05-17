import 'dart:io';

import 'package:dio/dio.dart';
import 'package:volarant_agents/infrastructure/services/retry_request.dart';

class DioInterceptor extends Interceptor {
  final RetryRequest request;

  DioInterceptor(this.request);

  bool _shouldRetry(DioException err) {
    return err.type == DioExceptionType.unknown &&
        err.error != null &&
        err.error is SocketException;
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {

    if (_shouldRetry(err)) {
      request.retryRequest(err.requestOptions);
    }
  }

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    // TODO: implement onRequest
    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    // TODO: implement onResponse
    super.onResponse(response, handler);
  }
}
