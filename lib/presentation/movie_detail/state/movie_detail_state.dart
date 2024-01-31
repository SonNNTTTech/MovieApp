import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:test_app/presentation/movie_detail/entity/movie_detail_entity.dart';

part 'movie_detail_state.freezed.dart';

@freezed
class MovieDetailState with _$MovieDetailState {
  const factory MovieDetailState({
    MovieDetailEntity? entity,
    String? error,
    bool? isLoading,
  }) = _MovieDetailState;
}
