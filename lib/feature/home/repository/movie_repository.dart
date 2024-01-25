// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:test_app/feature/home/model/movie_model.dart';
import 'package:test_app/feature/home/state/movie_state.dart';
import 'package:test_app/shared/app_enum.dart';
import 'package:test_app/shared/http/api_provider.dart';

abstract class IMovieRepository {
  Future<MovieState> callMovieByType(MovieType type, {int? page});
}

final movieRepoProvider = Provider<MovieRepository>(MovieRepository.new);

class MovieRepository implements IMovieRepository {
  final Ref _ref;
  late final ApiProvider _api = _ref.read(apiProvider);

  final headUrl = '/movie';
  MovieRepository(this._ref);

  @override
  Future<MovieState> callMovieByType(MovieType type, {int? page}) async {
    var queryParameters = <String, dynamic>{};
    if (page != null) {
      queryParameters['page'] = page.toString();
    }
    final response =
        await _api.get('$headUrl/${type.apiText}', query: queryParameters);

    return response.when(success: (success) {
      return MovieState.movieLoaded(MovieResponse.fromJson(success));
    }, error: (error) {
      return MovieState.error(error);
    });
  }
}
