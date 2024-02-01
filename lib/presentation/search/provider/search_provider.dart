import 'dart:async';

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:test_app/presentation/home/entity/home_entity.dart';
import 'package:test_app/repository/movie/movie_repository.dart';
import 'package:test_app/shared/app_helper.dart';

import '../state/search_state.dart';

part 'search_provider.g.dart';

@riverpod
class SearchNotifier extends _$SearchNotifier {
  late final movieRepo = ref.read(movieRepoProvider);
  @override
  SearchState build() {
    return const SearchState(entity: HomeEntity(movies: []), keyword: 'Marvel');
  }

  Future reloadPage() async {
    state = state.copyWith(entity: state.entity.copyWith(isLoading: true));
    final result = await movieRepo.searchMovie(state.keyword ?? '');
    result.fold((left) => null, (list) {
      if (list.length < 20) {
        AppHelper.myLog('list.length < 20');
        state = state.copyWith(
          entity: state.entity.copyWith(isNoMorePage: true),
        );
      }
      state = state.copyWith(
          entity: state.entity.copyWith(movies: list, isLoading: false));
    });
  }

  Future getNewPage() async {
    final result = await movieRepo.searchMovie(state.keyword ?? '',
        page: 1 + ((state.entity.movies.length) / 20).floor());
    result.fold((left) => null, (list) {
      state.entity.movies.addAll(list);
      if (list.length < 20) {
        state = state.copyWith(
          entity: state.entity.copyWith(isNoMorePage: true),
        );
      }
    });
  }

  Timer? _timer;

  void search(String newKeyword) {
    state = state.copyWith(
        keyword: newKeyword, entity: state.entity.copyWith(isLoading: true));
    reloadPage();
  }

  void activeDebouce(String newKeyword) {
    if (newKeyword.isEmpty) return;
    if (_timer != null) {
      _timer!.cancel();
    }
    _timer = Timer(const Duration(milliseconds: 500), () {
      search(newKeyword);
    });
  }
}
