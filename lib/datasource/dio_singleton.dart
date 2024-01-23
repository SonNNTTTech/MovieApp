import 'package:dio/dio.dart';

class DioSingleton {
  DioSingleton._();

  static final Dio instance = _getDio();

  static Dio _getDio() {
    return Dio(
      BaseOptions(
        baseUrl: 'https://api.themoviedb.org/3',
        connectTimeout: const Duration(seconds: 20),
        receiveTimeout: const Duration(seconds: 20),
        headers: {
          'Authorization':
              r'Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI4MjcyMGJmN2VjZDgzYWRjZDI0Yjg4ODhjMDllYmVjNyIsInN1YiI6IjY1YWUzYmM5MDljMjRjMDBhZDAxOWY0MSIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.N9iLYcvpeqfqgBkpmqSMM_IDbM1lUq59pF1FMNqh-7c',
          'accept': 'application/json',
        },
      ),
    );
  }
}
