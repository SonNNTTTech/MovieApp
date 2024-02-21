import 'package:either_dart/either.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:test_app/datasource/api_provider.dart';
import 'package:test_app/presentation/movie_detail/entity/movie_detail_entity.dart';
import 'package:test_app/repository/movie/image_model.dart';
import 'package:test_app/repository/movie/movie_model.dart';
import 'package:test_app/repository/shared_preferences/sp_repository.dart';
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
    return await response.when(success: (json) async {
      return Right(
          await toMovieDetailEntity(MovieDetailResponse.fromJson(json)));
    }, error: (error) async {
      return Left(error);
    });
  }

  Future<Either<String, List<String>>> callImages(int id) async {
    final response = await _api.get('$headUrl/$id/images');
    return response.when(success: (json) {
      final model = ImageResponse.fromJson(json);
      final list1 = model.backdrops!
          .where((e) => e.aspectRatio == 1.778)
          .map((e) => toVerticalImageUrl(e.filePath))
          .toList();
      final list2 = model.posters!
          .where((e) => e.aspectRatio == 1.778)
          .map((e) => toVerticalImageUrl(e.filePath))
          .toList();
      final list3 = model.logos!
          .where((e) => e.aspectRatio == 1.778)
          .map((e) => toVerticalImageUrl(e.filePath))
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
            imageUrl: toVerticalImageUrl(e.posterPath),
            rate: ((e.voteAverage ?? 0) * 10).round()))
        .toList();
  }

  Future<MovieDetailEntity> toMovieDetailEntity(
      MovieDetailResponse movie) async {
    final response = await Future.wait(
        [
      callKeyword(movie.id ?? 0),
      callRecommendation(movie.id ?? 0),
      callVideo(movie.id ?? 0),
      callReview(movie.id ?? 0),
    ]);
    return MovieDetailEntity(
      id: movie.id ?? 0,
      title: movie.title ?? '',
      releaseDate: DateTime.tryParse(movie.releaseDate ?? ''),
      imageUrl: toVerticalImageUrl(movie.posterPath),
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
      revenue: movie.revenue ?? 0,
      keywords: response[0].fold((left) => [], (r) => r as List<String>),
      recommendations:
          response[1].fold((left) => [], (r) => r as List<RecommendationMovie>),
      youtubeVideoIds: response[2].fold((left) => [], (r) => r as List<String>),
      reviews: response[3].fold((left) => [], (r) => r as List<ReviewEntity>),
    );
  }

  String toVerticalImageUrl(String? path) {
    return 'https://image.tmdb.org/t/p/w220_and_h330_face${path ?? ''}';
  }

  String toHorizontalImageUrl(String? path) {
    return 'https://image.tmdb.org/t/p/w500${path ?? ''}';
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

  Future<Either<String, List<String>>> callKeyword(int movieId) async {
    final response = await _api.get('$headUrl/$movieId/keywords');
    return response.when(success: (json) {
      final data = KeywordResponse.fromJson(json);
      return Right(data.keywords?.map((e) => e.name ?? '').toList() ?? []);
    }, error: (error) {
      return Left(error);
    });
  }

  Future<Either<String, List<RecommendationMovie>>> callRecommendation(
      int movieId) async {
    final response = await _api.get('$headUrl/$movieId/recommendations');
    return response.when(success: (json) {
      final data = RecommendationResponse.fromJson(json);
      return Right(data.results
              ?.map((e) => RecommendationMovie(
                  id: e.id ?? 0,
                  name: e.title ?? '',
                  rating: ((e.voteAverage ?? 0.0) * 10).round(),
                  imagerUrl: toImageOriginalUrl(e.posterPath)))
              .toList() ??
          []);
    }, error: (error) {
      return Left(error);
    });
  }

  Future<Either<String, List<String>>> callVideo(int movieId) async {
    final response = await _api.get('$headUrl/$movieId/videos');
    return response.when(success: (json) {
      final data = VideoResponse.fromJson(json);
      return Right(data.results
              ?.where((e) => e.site == 'YouTube')
              .map((e) => e.key ?? '')
              .toList() ??
          []);
    }, error: (error) {
      return Left(error);
    });
  }

  Future<Either<String, List<ReviewEntity>>> callReview(int movieId) async {
    final response = await _api.get('$headUrl/$movieId/reviews');
    return response.when(
      success: (json) {
        final data = ReviewResponse.fromJson(json);
        return Right(
          data.results
                  ?.map((e) => ReviewEntity(
                      name: e.author ?? '',
                      date: DateTime.tryParse(
                        (e.updatedAt ?? '').replaceAll('Z', ''),
                      )?.toUtc(),
                      content: e.content ?? '',
                      avatarUrl:
                          toImageOriginalUrl(e.authorDetails?.avatarPath)))
                  .toList() ??
              [],
        );
      },
      error: (error) {
        return Left(error);
      },
    );
  }

  Future<Either<String, List<MovieEntity>>> getFavoriteMovie({
    int? page,
  }) async {
    final spRepo = _ref.read(spRepoProvider);
    final queryParameters = <String, dynamic>{};
    if (page != null) {
      queryParameters['page'] = page;
    }
    queryParameters['session_id'] = await spRepo.getSessionId();
    final response = await _api.get('/account/20938939/favorite/movies',
        query: queryParameters);
    return response.when(success: (json) {
      return Right(toListMovieEntity(MovieResponse.fromJson(json)));
    }, error: (error) {
      return Left(error);
    });
  }
}
