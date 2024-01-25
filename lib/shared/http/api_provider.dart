// ignore_for_file: deprecated_member_use

import 'dart:async';
import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:test_app/shared/http/api_response.dart';
import 'package:test_app/shared/http/app_exception.dart';
import 'package:test_app/shared/http/interceptor/dio_connectivity_request_retrier.dart';
import 'package:test_app/shared/http/interceptor/retry_interceptor.dart';

import 'logger.dart';

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
    _dio.options.sendTimeout = const Duration(seconds: 5);
    _dio.options.connectTimeout = const Duration(seconds: 5);
    _dio.options.receiveTimeout = const Duration(seconds: 5);
    _dio.interceptors.add(
      RetryOnConnectionChangeInterceptor(
        requestRetrier: DioConnectivityRequestRetrier(
          dio: _dio,
          connectivity: Connectivity(),
        ),
      ),
    );

    if (kDebugMode) {
      _dio.interceptors.add(DioLogIntercepter());
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
      return const APIResponse.error(AppException.connectivity());
    }

    try {
      final response = await _dio.post(
        path,
        data: body,
        queryParameters: query,
        options: Options(validateStatus: (status) => true),
      );

      if (response.statusCode == null) {
        return const APIResponse.error(AppException.connectivity());
      }

      if (response.statusCode! < 300) {
        if (response.data['data'] != null) {
          return APIResponse.success(response.data['data']);
        } else {
          return APIResponse.success(response.data);
        }
      } else {
        // if (response.statusCode! == 404) {
        //   return const APIResponse.error(AppException.connectivity());
        // } else
        if (response.statusCode! == 401) {
          return const APIResponse.error(AppException.unauthorized());
        } else if (response.statusCode! == 502) {
          return const APIResponse.error(AppException.error());
        } else {
          if (response.data['message'] != null) {
            return APIResponse.error(AppException.errorWithMessage(
                response.data['message'] as String));
          } else {
            return const APIResponse.error(AppException.error());
          }
        }
      }
    } on DioError catch (e) {
      if (e.error is SocketException) {
        return const APIResponse.error(AppException.connectivity());
      }
      if (e.type == DioErrorType.connectionTimeout ||
          e.type == DioErrorType.receiveTimeout ||
          e.type == DioErrorType.sendTimeout) {
        return const APIResponse.error(AppException.connectivity());
      }

      if (e.response != null) {
        if (e.response!.data['message'] != null) {
          return APIResponse.error(AppException.errorWithMessage(
              e.response!.data['message'] as String));
        }
      }
      return APIResponse.error(AppException.errorWithMessage(e.message ?? ''));
    } on Error catch (e) {
      return APIResponse.error(
          AppException.errorWithMessage(e.stackTrace.toString()));
    }
  }

  Future<APIResponse> get(
    String path, {
    Map<String, dynamic>? query,
    ContentType contentType = ContentType.json,
  }) async {
    final connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      return const APIResponse.error(AppException.connectivity());
    }

    try {
      final response = await _dio.get(
        path,
        queryParameters: query,
        options: Options(validateStatus: (status) => true),
      );
      if (response.statusCode == null) {
        return const APIResponse.error(AppException.connectivity());
      }

      if (response.statusCode! < 300) {
        return APIResponse.success(response.data);
      } else {
        if (response.statusCode! == 404) {
          return const APIResponse.error(AppException.connectivity());
        } else if (response.statusCode! == 502) {
          return const APIResponse.error(AppException.error());
        } else {
          return APIResponse.error(
              AppException.errorWithMessage(response.data['message']));
        }
      }
    } on DioError catch (e) {
      if (e.error is SocketException) {
        return const APIResponse.error(AppException.connectivity());
      }
      if (e.type == DioErrorType.connectionTimeout ||
          e.type == DioErrorType.receiveTimeout ||
          e.type == DioErrorType.sendTimeout) {
        return const APIResponse.error(AppException.connectivity());
      }
      return const APIResponse.error(AppException.error());
    }
  }
}
