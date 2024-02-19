import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:test_app/presentation/bottom_bar/provider/bottom_bar_provider.dart';
import 'package:test_app/presentation/search/provider/search_provider.dart';

import '../../../repository/movie/movie_repository.dart';
import '../state/movie_detail_state.dart';

part 'movie_detail_provider.g.dart';

@riverpod
class MovieDetailNotifier extends _$MovieDetailNotifier {
  late final movieRepo = ref.read(movieRepoProvider);
  @override
  MovieDetailState build(int id) {
    return const MovieDetailState();
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
    //delay for initialize searchNotifierProvider
    Future.delayed(const Duration(seconds: 1), () {
      ref.read(searchNotifierProvider.notifier).search(keyword);
    });
  }
}
