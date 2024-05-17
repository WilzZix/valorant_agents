import 'dart:async';
import 'dart:developer';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';

class RetryRequest {
  final Dio dio;
  final Connectivity connectivity;

  RetryRequest({
    required this.dio,
    required this.connectivity,
  });

  Future<Completer<Response>> retryRequest(
      RequestOptions requestOptions) async {
    StreamSubscription? streamSubscription;
    final responseCompleter = Completer<Response>();
    streamSubscription =
        connectivity.onConnectivityChanged.listen((event) async {
      if (event != ConnectivityResult.none) {
        log('line 23');
        streamSubscription!.cancel();
        responseCompleter.complete(
          dio.request(
            requestOptions.path,
            cancelToken: requestOptions.cancelToken,
            data: requestOptions.data,
            onReceiveProgress: requestOptions.onReceiveProgress,
            onSendProgress: requestOptions.onSendProgress,
            queryParameters: requestOptions.queryParameters,
          ),
        );
      }
    });
    return responseCompleter;
  }
}
