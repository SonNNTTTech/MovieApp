import 'package:either_dart/either.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:test_app/datasource/api_provider.dart';
import 'package:test_app/presentation/movie_detail/entity/movie_detail_entity.dart';
import 'package:test_app/repository/movie/image_model.dart';
import 'package:test_app/repository/movie/movie_model.dart';
import 'package:test_app/shared/app_enum.dart';

import '../../presentation/home/entity/movie_entity.dart';
import 'movie_detail_model.dart';

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
      queryParameters['page'] = page;
    }
    final response =
        await _api.get('$headUrl/${type.apiText}', query: queryParameters);
    return response.when(success: (json) {
      return Right(toListMovieEntity(MovieResponse.fromJson(json)));
    }, error: (error) {
      return Left(error);
    });
  }

  Future<Either<String, List<MovieEntity>>> searchMovie(
    String keyword, {
    int? page,
  }) async {
    final queryParameters = <String, dynamic>{};
    queryParameters['query'] = keyword;
    if (page != null) {
      queryParameters['page'] = page;
    }
    final response = await _api.get('/search/movie', query: queryParameters);
    return response.when(success: (json) {
      return Right(toListMovieEntity(MovieResponse.fromJson(json)));
    }, error: (error) {
      return Left(error);
    });
  }

  Future<Either<String, MovieDetailEntity>> callMovieDetail(int id) async {
    final response = await _api.get('$headUrl/$id');
    return response.when(success: (json) {
      return Right(toMovieDetailEntity(MovieDetailResponse.fromJson(json)));
    }, error: (error) {
      return Left(error);
    });
  }

  Future<Either<String, List<String>>> callImages(int id) async {
    final response = await _api.get('$headUrl/$id/images');
    return response.when(success: (json) {
      final model = ImageResponse.fromJson(json);
      final list1 = model.backdrops!
          .where((e) => e.aspectRatio == 1.778)
          .map((e) => toImageUrl(e.filePath))
          .toList();
      final list2 = model.posters!
          .where((e) => e.aspectRatio == 1.778)
          .map((e) => toImageUrl(e.filePath))
          .toList();
      final list3 = model.logos!
          .where((e) => e.aspectRatio == 1.778)
          .map((e) => toImageUrl(e.filePath))
          .toList();
      return Right(list1 + list2 + list3);
    }, error: (error) {
      return Left(error);
    });
  }

  List<MovieEntity> toListMovieEntity(MovieResponse movie) {
    final list = movie.results ?? [];
    return list
        .map((e) => MovieEntity(
            id: e.id!,
            name: e.title ?? '',
            date: e.releaseDate != null
                ? DateTime.tryParse(e.releaseDate!)
                : DateTime.now(),
            imageUrl: toImageUrl(e.posterPath),
            rate: ((e.voteAverage ?? 0) * 10).round()))
        .toList();
  }

  MovieDetailEntity toMovieDetailEntity(MovieDetailResponse movie) {
    return MovieDetailEntity(
        id: movie.id ?? 0,
        title: movie.title ?? '',
        releaseDate: DateTime.tryParse(movie.releaseDate ?? ''),
        imageUrl: toImageUrl(movie.posterPath),
        rating: ((movie.voteAverage ?? 0) * 10).round(),
        overview: movie.overview ?? '',
        kinds: (movie.genres ?? []).map((e) => e.name ?? '').toList(),
        region: movie.originalLanguage ?? '',
        duration: runtimeToDuration(movie.runtime ?? 0),
        slogan: movie.tagline ?? '',
        productions: (movie.productionCompanies ?? [])
            .where((e) => e.logoPath != null)
            .map((e) => Production(
                name: e.name ?? '', imageUrl: toImageOriginalUrl(e.logoPath)))
            .toList(),
        revenue: movie.revenue ?? 0);
  }

  String toImageUrl(String? path) {
    return 'https://image.tmdb.org/t/p/w220_and_h330_face${path ?? ''}';
  }

  String toImageOriginalUrl(String? path) {
    return 'https://image.tmdb.org/t/p/original${path ?? ''}';
  }

  //117 => 1h57p
  String runtimeToDuration(int runtime) {
    String result = '';
    int hours = runtime ~/ 60;
    int minutes = runtime % 60;
    if (hours > 0) {
      result += '${hours}h';
    }
    if (minutes > 0) {
      result += '${minutes}m';
    }
    return result;
  }
}
