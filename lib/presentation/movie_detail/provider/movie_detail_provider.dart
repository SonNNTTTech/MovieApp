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
    movie.fold(
        (left) => state = state.copyWith(error: left, isLoading: false),
        (right) => state =
            state.copyWith(entity: right, isLoading: false, error: null));
  }
}
