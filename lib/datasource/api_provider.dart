import 'dart:async';
import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:test_app/shared/constants/app_string.dart';

import 'api_response.dart';
import 'curl_logger.dart';
import 'interceptor/dio_connectivity_request_retrier.dart';
import 'interceptor/retry_interceptor.dart';

//part 'api_provider.g.dart';

enum ContentType { urlEncoded, json }

// @riverpod
// ApiProvider apiProvider(ApiProviderRef ref) {
//   return ApiProvider(ref);
// }

final apiProvider = Provider<ApiProvider>(ApiProvider.new);

class ApiProvider {
  ApiProvider(this._ref) {
    _dio = Dio(
      BaseOptions(
        baseUrl: 'https://api.themoviedb.org/3',
        headers: {
          'Authorization':
              r'Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI4MjcyMGJmN2VjZDgzYWRjZDI0Yjg4ODhjMDllYmVjNyIsInN1YiI6IjY1YWUzYmM5MDljMjRjMDBhZDAxOWY0MSIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.N9iLYcvpeqfqgBkpmqSMM_IDbM1lUq59pF1FMNqh-7c',
          'accept': 'application/json',
        },
      ),
    );
    _dio.options.sendTimeout = const Duration(seconds: 20);
    _dio.options.connectTimeout = const Duration(seconds: 20);
    _dio.options.receiveTimeout = const Duration(seconds: 20);
    _dio.interceptors.add(
      RetryOnConnectionChangeInterceptor(
        requestRetrier: DioConnectivityRequestRetrier(
          dio: _dio,
          connectivity: Connectivity(),
        ),
      ),
    );

    if (kDebugMode) {
      _dio.interceptors.add(CurlLoggerDioInterceptor());
    }
  }

  // ignore: unused_field
  final Ref _ref;

  late Dio _dio;

  Future<APIResponse> post(
    String path,
    dynamic body, {
    Map<String, String?>? query,
    ContentType contentType = ContentType.json,
  }) async {
    final connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      return const APIResponse.error(AppString.NO_INTERNET);
    }

    try {
      final response = await _dio.post(
        path,
        data: body,
        queryParameters: query,
        options: Options(validateStatus: (status) => true),
      );

      if (response.statusCode == null) {
        return const APIResponse.error(AppString.NO_INTERNET);
      }

      if (response.statusCode! < 300) {
        return APIResponse.success(response.data);
      } else {
        return APIResponse.error(response.data['status_message'] as String);
      }
    } on DioException catch (e) {
      if (e.error is SocketException) {
        return const APIResponse.error(AppString.NO_INTERNET);
      }
      if (e.type == DioExceptionType.connectionTimeout ||
          e.type == DioExceptionType.receiveTimeout ||
          e.type == DioExceptionType.sendTimeout) {
        return const APIResponse.error(AppString.NO_INTERNET);
      }

      if (e.response != null) {
        if (e.response!.data['status_message'] != null) {
          return APIResponse.error(
              e.response!.data['status_message'] as String);
        }
      }
      return APIResponse.error(e.message ?? AppString.UNKNOWN_ERROR);
    } on Error catch (e) {
      return APIResponse.error(e.stackTrace.toString());
    }
  }

  Future<APIResponse> get(
    String path, {
    Map<String, dynamic>? query,
    ContentType contentType = ContentType.json,
  }) async {
    final connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      return const APIResponse.error(AppString.NO_INTERNET);
    }

    try {
      final response = await _dio.get(
        path,
        queryParameters: query,
        options: Options(validateStatus: (status) => true),
      );
      if (response.statusCode == null) {
        return const APIResponse.error(AppString.NO_INTERNET);
      }

      if (response.statusCode! < 300) {
        return APIResponse.success(response.data);
      } else {
          return APIResponse.error(
            response.data['status_message'] ?? AppString.UNKNOWN_ERROR);
      }
    } on DioException catch (e) {
      if (e.error is SocketException) {
        return const APIResponse.error(AppString.NO_INTERNET);
      }
      if (e.type == DioExceptionType.connectionTimeout ||
          e.type == DioExceptionType.receiveTimeout ||
          e.type == DioExceptionType.sendTimeout) {
        return const APIResponse.error(AppString.NO_INTERNET);
      }
      return APIResponse.error(e.message ?? AppString.UNKNOWN_ERROR);
    }
  }
}
