import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:test_app/shared/app_enum.dart';

import '../entity/home_entity.dart';

part 'home_state.freezed.dart';

@freezed
class HomeState with _$HomeState {
  const factory HomeState({
    required Map<MovieType, HomeEntity> mapState,
    required MovieType tab,
  }) = _HomeState;
}
