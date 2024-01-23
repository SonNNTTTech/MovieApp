import 'package:either_dart/either.dart';
import 'package:test_app/common/app_enum.dart';
import 'package:test_app/datasource/movie/model/movie_model.dart';

abstract class MovieDataSource {
  Future<Either<String, MovieResponse>> callMovieByType(MovieType type,
      {int? page});
}
