import 'dart:async';

import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:test_app/presentation/bottom_bar/widget/app_route.dart';
import 'package:test_app/presentation/home/entity/home_entity.dart';
import 'package:test_app/presentation/search/search_movie_view.dart';
import 'package:test_app/repository/movie/movie_repository.dart';

import '../state/search_state.dart';

part 'search_provider.g.dart';

@riverpod
class SearchNotifier extends _$SearchNotifier {
  late final movieRepo = ref.read(movieRepoProvider);
  @override
  SearchState build() {
    const keyword = 'Marvel';
    return SearchState(
        entity: const HomeEntity(movies: []),
        keyword: keyword,
        controller: TextEditingController(text: keyword));
  }

  Future reloadPage() async {
    state = state.copyWith(entity: state.entity.copyWith(isLoading: true));
    final result = await movieRepo.searchMovie(state.keyword ?? '');
    result.fold((left) => null, (list) {
      if (list.length < 20) {
        state = state.copyWith(
          entity: state.entity.copyWith(isNoMorePage: true),
        );
      }
      state = state.copyWith(
          entity: state.entity.copyWith(
              movies: list, isLoading: false, isNewPageLoading: false));
    });
  }

  Future getNewPage() async {
    state = state.copyWith(
      entity: state.entity.copyWith(isNewPageLoading: true),
    );
    final result = await movieRepo.searchMovie(state.keyword ?? '',
        page: 1 + ((state.entity.movies.length) / 20).floor());
    result.fold((left) => null, (list) {
      state.entity.movies.addAll(list);
      if (list.length < 20) {
        state = state.copyWith(
          entity: state.entity.copyWith(isNoMorePage: true),
        );
      }
      state = state.copyWith(
        entity: state.entity.copyWith(isNewPageLoading: false),
      );
    });
  }

  Timer? _timer;

  void search(String newKeyword) {
    if (AppRoutes.lastRoute != SearchMovieView.route) {
      final context = searchKey.currentContext!;
      Navigator.of(context)
          .popUntil((route) => route.settings.name == SearchMovieView.route);
    }
    state.controller.text = newKeyword;
    state = state.copyWith(
        keyword: newKeyword, entity: state.entity.copyWith(isLoading: true));
    reloadPage();
  }

  void activeDebouce(String newKeyword) {
    if (_timer != null) {
      _timer!.cancel();
    }
    _timer = Timer(const Duration(milliseconds: 500), () {
      search(newKeyword);
    });
  }
}
