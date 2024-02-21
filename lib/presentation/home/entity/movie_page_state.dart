import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:test_app/presentation/home/entity/movie_entity.dart';

part 'movie_page_state.freezed.dart';

@Freezed(makeCollectionsUnmodifiable: false)
class MoviePageState with _$MoviePageState {
  const factory MoviePageState({
    required List<MovieEntity> movies,
    String? error,
    @Default(false) bool isNoMorePage,
    @Default(true) bool isLoading,
    @Default(false) bool isNewPageLoading,
  }) = _MoviePageState;
}
