import 'package:flutter/material.dart';
import 'package:test_app/presentation/home/widget/home_view.dart';
import 'package:test_app/presentation/movie_detail/widget/movie_detail_view.dart';
import 'package:test_app/presentation/search/search_movie_view.dart';

class AppRoutes {
  static String _lastRoute = "/";

  static Route? onGenerated(RouteSettings settings) {
    _lastRoute = settings.name ?? "/";
    if (settings.name == HomeView.route) {
      return MaterialPageRoute(
        builder: (context) {
          return const HomeView();
        },
      );
    }
    if (settings.name == SearchMovieView.route) {
      return MaterialPageRoute(
        builder: (context) {
          return const SearchMovieView();
        },
      );
    }
    if (settings.name == MovieDetailView.route) {
      final args = settings.arguments as int;
      return MaterialPageRoute(
        builder: (context) {
          return MovieDetailView(id: args);
        },
      );
    }
    assert(false, 'Need to implement ${settings.name}');
    return null;
  }

  static String get lastRoute => _lastRoute;
}
