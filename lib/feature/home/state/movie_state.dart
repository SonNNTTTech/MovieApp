import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:test_app/feature/home/model/movie_model.dart';
import 'package:test_app/shared/http/app_exception.dart';
part 'movie_state.freezed.dart';

@freezed
class MovieState with _$MovieState {
  const factory MovieState.loading() = _Loading;

  const factory MovieState.movieLoaded(MovieResponse movie) = _Loaded;

  const factory MovieState.error(AppException error) = _Error;
}
