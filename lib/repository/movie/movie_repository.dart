import 'package:either_dart/either.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:test_app/datasource/api_provider.dart';
import 'package:test_app/repository/movie/movie_model.dart';
import 'package:test_app/shared/app_enum.dart';

abstract class IMovieRepository {
  Future<Either<String, MovieResponse>> callMovieByType(MovieType type,
      {int? page});
}

final movieRepoProvider = Provider(MovieRepository.new);

class MovieRepository implements IMovieRepository {
  final Ref _ref;
  late final ApiProvider _api = _ref.read(apiProvider);

  final headUrl = '/movie';
  MovieRepository(this._ref);

  @override
  Future<Either<String, MovieResponse>> callMovieByType(MovieType type,
      {int? page}) async {
    var queryParameters = <String, dynamic>{};
    if (page != null) {
      queryParameters['page'] = page.toString();
    }
    final response =
        await _api.get('$headUrl/${type.apiText}', query: queryParameters);
    return response.when(success: (success) {
      return Right(MovieResponse.fromJson(success));
    }, error: (error) {
      return Left(error);
    });
  }
}
