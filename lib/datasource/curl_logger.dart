import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:test_app/shared/app_helper.dart';

class CurlLoggerDioInterceptor extends Interceptor {
  final bool convertFormData;

  CurlLoggerDioInterceptor({this.convertFormData = true});

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    _renderCurlRepresentation(options);
    super.onRequest(options, handler);
  }
  @override
  void onResponse(
    Response response,
    ResponseInterceptorHandler handler,
  ) {
    AppHelper.limitLog('Responsee: ${response.data.toString()}');
    return super.onResponse(response, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    AppHelper.limitLog('Responsee error: ${err.response?.data.toString()}');
    super.onError(err, handler);
  }

  void _renderCurlRepresentation(RequestOptions requestOptions) {
    // add a breakpoint here so all errors can break
    try {
      AppHelper.myLog(_cURLRepresentation(requestOptions));
    } catch (err) {
      AppHelper.myLog(
          'unable to create a CURL representation of the requestOptions');
    }
  }

  String _cURLRepresentation(RequestOptions options) {
    List<String> components = ['curl -i'];
    if (options.method.toUpperCase() != 'GET') {
      components.add('-X ${options.method}');
    }

    options.headers.forEach((k, v) {
      if (k != 'Cookie') {
        components.add('-H "$k: $v"');
      }
    });

    if (options.data != null) {
      // FormData can't be JSON-serialized, so keep only their fields attributes
      if (options.data is FormData && convertFormData == true) {
        options.data = Map.fromEntries(options.data.fields);
      }

      final data = json.encode(options.data).replaceAll('"', '\\"');
      components.add('-d "$data"');
    }

    components.add('"${options.uri.toString()}"');

    return components.join(' \\\n\t');
  }
}
