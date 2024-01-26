import 'package:dio/dio.dart';
import 'package:test_app/shared/app_helper.dart';

class DioLogIntercepter extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    AppHelper.myLog('<------------------------>\nCall: ${options.uri}');
    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    AppHelper.myLog(
        'Receive status code: ${response.statusCode}\n<--------------------------->');
    super.onResponse(response, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    AppHelper.myLog('Error: ${err.message}\n<--------------------------->');
    super.onError(err, handler);
  }
}
