import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:test_app/presentation/home/state/home_state.dart';
import 'package:test_app/presentation/home/entity/home_entity.dart';
import 'package:test_app/repository/movie/movie_repository.dart';
import 'package:test_app/shared/app_enum.dart';

part 'home_provider.g.dart';

//Generated by @riverpod
// final homeNotifierProvider =
//     NotifierProvider<HomeNotifier, HomeState>(HomeNotifier.new);

@riverpod
class HomeNotifier extends _$HomeNotifier {
  late final movieRepo = ref.read(movieRepoProvider);
  @override
  HomeState build() {
    const initialTab = MovieType.popular;
    return HomeState(mapState: {
      for (final key in MovieType.values) key: const HomeEntity(movies: [])
    }, tab: initialTab);
  }

  Future reloadPage(MovieType type) async {
    Map<MovieType, HomeEntity> data = Map.from(state.mapState);
    final result = await movieRepo.callMovieByType(type);
    result.fold((left) => null, (list) {
      data[type] = data[type]!
          .copyWith(movies: list, isLoading: false, isNewPageLoading: false);
      state = state.copyWith(mapState: data);
    });
  }

  Future getNewPage(MovieType type) async {
    Map<MovieType, HomeEntity> data = Map.from(state.mapState);
    data[type] = data[type]!.copyWith(isNewPageLoading: true);
    state = state.copyWith(mapState: data);
    Map<MovieType, HomeEntity> data2 = Map.from(state.mapState);
    final result = await movieRepo.callMovieByType(type,
        page: 1 + ((data2[type]?.movies.length ?? 0) / 20).floor());
    result.fold((left) => null, (list) {
      data2[type]?.movies.addAll(list);
    });
    data2[type] = data2[type]!.copyWith(isNewPageLoading: false);
    state = state.copyWith(mapState: data2);
  }

  void changeTab(MovieType newTab) {
    if (state.tab == newTab) return;

    state = state.copyWith(tab: newTab);
  }
}
