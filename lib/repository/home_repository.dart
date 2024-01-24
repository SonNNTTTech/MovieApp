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

  Future reloadPage(MovieType type) async {
    var state = ref.read(homeStateMap.notifier).state[type]!;
    state.isLoading = true;
    rebuildRiverpod();
    var state2 = ref.read(homeStateMap.notifier).state[type]!;
    state2.movies.clear();
    var result = await movieDataSource.callMovieByType(type);
    result.fold((left) => state2.error = left,
        (right) => state2.movies = toListMovieEntity(right));
    state2.isLoading = false;
    rebuildRiverpod();
  }

  Future getNewPage(MovieType type) async {
    var state = ref.read(homeStateMap.notifier).state[type]!;
    var result = await movieDataSource.callMovieByType(type,
        page: 1 + (state.movies.length / 20).floor());
    result.fold((left) => state.error = left, (right) {
      state.movies.addAll(toListMovieEntity(right));
      if (state.movies.length < 20) {
        state.isNoMorePage = true;
      }
    });
    rebuildRiverpod();
  }

  void rebuildRiverpod() {
    ref.read(homeStateMap.notifier).state =
        Map.from(ref.read(homeStateMap.notifier).state);
  }

  Future changeTab(MovieType type) async {
    var currentTab = ref.read(homeTab.notifier).state;
    if (currentTab == type) {
      return;
    }
    ref.read(homeTab.notifier).state = type;
    if (ref.read(homeStateMap.notifier).state[type]!.movies.isEmpty) {
      await reloadPage(type);
    }
  }

  List<MovieEntity> toListMovieEntity(MovieResponse movie) {
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
