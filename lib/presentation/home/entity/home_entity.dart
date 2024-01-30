
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
}
