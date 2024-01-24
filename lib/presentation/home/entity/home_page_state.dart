import 'movie_entity.dart';

class HomePageState {
  List<MovieEntity> movies;
  String? error;
  bool isNoMorePage;
  bool isLoading;
  HomePageState({
    required this.movies,
    this.error,
    this.isNoMorePage = false,
    this.isLoading = true,
  });
}
