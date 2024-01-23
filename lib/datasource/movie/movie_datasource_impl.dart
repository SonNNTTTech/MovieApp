import 'package:either_dart/either.dart';
import 'package:test_app/common/app_enum.dart';
import 'package:test_app/common/app_helper.dart';
import 'package:test_app/datasource/dio_singleton.dart';
import 'package:test_app/datasource/movie/model/movie_model.dart';
import 'package:test_app/datasource/movie/movie_datasource.dart';

class MovieDataSourceImpl implements MovieDataSource {
  final headUrl = '/movie';
  @override
  Future<Either<String, MovieResponse>> callMovieByType(MovieType type,
      {int? page}) async {
    var response = await DioSingleton.instance
        .get('$headUrl/${type.apiText}${page != null ? '?page=$page' : ''}');
    if (AppHelper.isSuccessApi(response.statusCode!)) {
      return Right(MovieResponse.fromJson(response.data));
    }
    return Left(response.statusMessage ?? 'Unknown error');
  }
}
