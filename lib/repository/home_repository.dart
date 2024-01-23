// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:test_app/common/app_enum.dart';
import 'package:test_app/datasource/movie/model/movie_model.dart';
import 'package:test_app/datasource/movie/movie_datasource.dart';
import 'package:test_app/presentation/home/entity/movie_entity.dart';
import 'package:test_app/presentation/home/home_riverpod.dart';

class HomeRepository {
  final MovieDataSource movieDataSource;
  final WidgetRef ref;
  const HomeRepository({
    required this.movieDataSource,
    required this.ref,
  });

  Future reloadMovie(MovieType type) async {
    ref.read(homeMapMovieProvider.notifier).state[type]!.clear();
    var result = await movieDataSource.callMovieByType(type);
    result.fold(
        (left) => ref.read(homeMapErrorProvider.notifier).state[type] = left,
        (right) => ref.read(homeMapMovieProvider.notifier).state[type] =
            toListMovieEntity(right));
  }

  Future getNewPage(MovieType type) async {
    var result = await movieDataSource.callMovieByType(type,
        page: 1 +
            (ref.read(homeMapMovieProvider.notifier).state[type]!.length / 20)
                .floor());
    result.fold(
        (left) => ref.read(homeMapErrorProvider.notifier).state[type] = left,
        (right) {
      var parsedList = toListMovieEntity(right);
      ref.read(homeMapMovieProvider.notifier).state[type]!.addAll(parsedList);
      if (parsedList.length < 20) {
        ref.read(homeMapIsNoMorePageProvider.notifier).state[type] = true;
      }
    });
  }

  static List<MovieEntity> toListMovieEntity(MovieResponse movie) {
    var list = movie.results ?? [];
    return list
        .map((e) => MovieEntity(
            name: e.title ?? '',
            date: e.releaseDate != null
                ? DateTime.parse(e.releaseDate!)
                : DateTime.now(),
            imageUrl:
                'https://image.tmdb.org/t/p/w220_and_h330_face${e.posterPath ?? ''}',
            rate: ((e.voteAverage ?? 0) * 10).round()))
        .toList();
  }
}
