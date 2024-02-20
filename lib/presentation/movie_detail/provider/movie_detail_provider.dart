// ignore_for_file: avoid_public_notifier_properties, avoid_manual_providers_as_generated_provider_dependency
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:test_app/presentation/bottom_bar/provider/bottom_bar_provider.dart';
import 'package:test_app/presentation/favorite/provider/favorite_provider.dart';
import 'package:test_app/presentation/search/provider/search_provider.dart';
import 'package:test_app/repository/account/account_repository.dart';

import '../../../repository/movie/movie_repository.dart';
import '../state/movie_detail_state.dart';

part 'movie_detail_provider.g.dart';

@riverpod
class MovieDetailNotifier extends _$MovieDetailNotifier {
  late final movieRepo = ref.read(movieRepoProvider);
  @override
  MovieDetailState build(int id) {
    final isFavorited =
        ref.read(favoriteNotifierProvider).movies.map((e) => e.id).firstWhere(
                  (e) => e == id,
                  orElse: () => -1,
                ) !=
            -1;
    return MovieDetailState(isFavorited: isFavorited);
  }

  Future loadMovieDetail(int id) async {
    state = state.copyWith(isLoading: true);
    final movie = await movieRepo.callMovieDetail(id);
    await movie.fold((left) async {
      state = state.copyWith(error: left, isLoading: false);
    }, (right) async {
      final imagesResponse = await movieRepo.callImages(id);
      imagesResponse.fold(
          (left) => state = state.copyWith(error: left, isLoading: false),
          (image) => state = state.copyWith(
              entity: right, isLoading: false, error: null, images: image));
    });
  }

  void onKeywordClick(String keyword) {
    ref.read(bottomBarNotifierProvider.notifier).changeTab(1);
    if (isSearchInitialized) {
      ref.read(searchNotifierProvider.notifier).search(keyword);
    } else {
      //delay for initialize searchNotifierProvider
      Future.delayed(const Duration(seconds: 1), () {
        ref.read(searchNotifierProvider.notifier).search(keyword);
      });
    }
  }

  void onFavoriteClick() {
    ref.read(accountRepoProvider).favoriteMovie(id, !state.isFavorited);
    state = state.copyWith(isFavorited: !state.isFavorited);
  }
}
