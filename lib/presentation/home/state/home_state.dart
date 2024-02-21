import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:test_app/shared/app_enum.dart';

import '../entity/movie_page_state.dart';

part 'home_state.freezed.dart';

@Freezed(makeCollectionsUnmodifiable: false)
class HomeState with _$HomeState {
  const factory HomeState({
    required Map<MovieType, MoviePageState> mapState,
    required MovieType tab,
  }) = _HomeState;
}
