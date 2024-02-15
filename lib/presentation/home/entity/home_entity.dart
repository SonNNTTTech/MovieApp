import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:test_app/presentation/home/entity/movie_entity.dart';

part 'home_entity.freezed.dart';

@Freezed(makeCollectionsUnmodifiable: false)
class HomeEntity with _$HomeEntity {
  const factory HomeEntity({
    required List<MovieEntity> movies,
    String? error,
    @Default(false) bool isNoMorePage,
    @Default(true) bool isLoading,
    @Default(false) bool isNewPageLoading,
  }) = _HomeEntity;
}
