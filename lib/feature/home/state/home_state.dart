import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:test_app/feature/home/widget/entity/home_entity.dart';
import 'package:test_app/shared/app_enum.dart';

part 'home_state.freezed.dart';

@freezed
class HomeState with _$HomeState {
  const factory HomeState({
    @Default({}) Map<MovieType, HomeEntity> mapState,
  }) = _HomeState;
}
