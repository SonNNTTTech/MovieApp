import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../repository/movie/movie_repository.dart';
import '../state/movie_detail_state.dart';

part 'movie_detail_provider.g.dart';

@riverpod
class MovieDetailNotifier extends _$MovieDetailNotifier {
  late final movieRepo = ref.read(movieRepoProvider);
  @override
  MovieDetailState build() {
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
}