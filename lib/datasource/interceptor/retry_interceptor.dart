import 'dart:io';

import 'package:dio/dio.dart';
import 'package:test_app/shared/app_helper.dart';

import 'dio_connectivity_request_retrier.dart';

class RetryOnConnectionChangeInterceptor extends Interceptor {
  final DioConnectivityRequestRetrier requestRetrier;

  RetryOnConnectionChangeInterceptor({
    required this.requestRetrier,
  });

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    try {
      if (_shouldRetry(err)) {
        requestRetrier.scheduleRequestRetry(err.requestOptions);
      }
    } catch (e) {
      AppHelper.myLog('Error API: $e');
    }
    super.onError(err, handler);
  }

  bool _shouldRetry(DioException err) {
    return err.type == DioExceptionType.connectionTimeout &&
        err.error != null &&
        err.error is SocketException;
  }
}
