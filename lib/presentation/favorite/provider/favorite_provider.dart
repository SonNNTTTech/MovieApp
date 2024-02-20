// ignore_for_file: avoid_public_notifier_properties, avoid_manual_providers_as_generated_provider_dependency
import 'dart:async';

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:test_app/presentation/home/entity/movie_page_state.dart';
import 'package:test_app/repository/movie/movie_repository.dart';

part 'favorite_provider.g.dart';

@riverpod
class FavoriteNotifier extends _$FavoriteNotifier {
  late final movieRepo = ref.read(movieRepoProvider);
  @override
  MoviePageState build() {
    return const MoviePageState(movies: []);
  }

  Future reloadPage() async {
    state = state.copyWith(isLoading: true);
    final result = await movieRepo.getFavoriteMovie();
    result.fold((left) => null, (list) {
      if (list.length < 20) {
        state = state.copyWith(isNoMorePage: true);
      }
      state = state.copyWith(
          movies: list, isLoading: false, isNewPageLoading: false);
    });
  }

  Future getNewPage() async {
    state = state.copyWith(
      isNewPageLoading: true,
    );
    final result = await movieRepo.getFavoriteMovie(
        page: 1 + ((state.movies.length) / 20).floor());
    result.fold((left) => null, (list) {
      state.movies.addAll(list);
      if (list.length < 20) {
        state = state.copyWith(isNoMorePage: true);
      }
      state = state.copyWith(isNewPageLoading: false);
    });
  }
}
