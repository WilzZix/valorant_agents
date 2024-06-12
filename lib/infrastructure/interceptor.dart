import 'dart:io';

import 'package:dio/dio.dart';

class DioInterceptor extends Interceptor {
//  final RetryRequest request;

  DioInterceptor();

  bool _shouldRetry(DioException err) {
    return err.type == DioExceptionType.unknown &&
        err.error != null &&
        err.error is SocketException;
  }

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    print('REQUEST[${options.method}] => PATH: ${options.path}');
    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    print(
        'RESPONSE[${response.statusCode}] => PATH: ${response.requestOptions.path}');
    super.onResponse(response, handler);
  }

  @override
  Future onError(DioException err, ErrorInterceptorHandler handler) async {
    print(
        'ERROR[${err.response?.statusCode}] => PATH: ${err.requestOptions.path}');
    super.onError(err, handler);
  }
// @override
// void onError(DioException err, ErrorInterceptorHandler handler) {
//
//   if (_shouldRetry(err)) {
//     request.retryRequest(err.requestOptions);
//   }
// }
//
// @override
// void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
//   // TODO: implement onRequest
//   super.onRequest(options, handler);
// }
//
// @override
// void onResponse(Response response, ResponseInterceptorHandler handler) {
//   // TODO: implement onResponse
//   super.onResponse(response, handler);
// }
}
