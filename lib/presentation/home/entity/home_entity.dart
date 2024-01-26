
import 'movie_entity.dart';

class HomeEntity {
  List<MovieEntity> movies;
  String? error;
  bool isNoMorePage;
  bool isLoading;
  HomeEntity({
    required this.movies,
    this.error,
    this.isNoMorePage = false,
    this.isLoading = true,
  });

  @override
  String toString() {
    return 'HomeEntity(movies: ${movies.length}, error: $error, isNoMorePage: $isNoMorePage, isLoading: $isLoading)';
  }
}
