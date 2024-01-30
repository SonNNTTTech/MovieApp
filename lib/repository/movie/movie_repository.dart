import 'package:either_dart/either.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:test_app/datasource/api_provider.dart';
import 'package:test_app/repository/movie/movie_model.dart';
import 'package:test_app/shared/app_enum.dart';

import '../../presentation/home/entity/movie_entity.dart';

final movieRepoProvider = Provider(MovieRepository.new);

class MovieRepository {
  final Ref _ref;
  late final ApiProvider _api = _ref.read(apiProvider);

  final headUrl = '/movie';
  MovieRepository(this._ref);

  Future<Either<String, List<MovieEntity>>> callMovieByType(
    MovieType type, {
    int? page,
  }) async {
    final queryParameters = <String, dynamic>{};
    if (page != null) {
      queryParameters['page'] = page.toString();
    }
    final response =
        await _api.get('$headUrl/${type.apiText}', query: queryParameters);
    return response.when(success: (json) {
      return Right(toListMovieEntity(MovieResponse.fromJson(json)));
    }, error: (error) {
      return Left(error);
    });
  }

  List<MovieEntity> toListMovieEntity(MovieResponse movie) {
    final list = movie.results ?? [];
    return list
        .map((e) => MovieEntity(
            name: e.title ?? '',
            date: e.releaseDate != null
                ? DateTime.tryParse(e.releaseDate!)
                : DateTime.now(),
            imageUrl:
                'https://image.tmdb.org/t/p/w220_and_h330_face${e.posterPath ?? ''}',
            rate: ((e.voteAverage ?? 0) * 10).round()))
        .toList();
  }
}
