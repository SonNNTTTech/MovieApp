import 'package:freezed_annotation/freezed_annotation.dart';

part 'app_start_state.freezed.dart';

@freezed
class AppStartState with _$AppStartState {
  const factory AppStartState.initial() = _Initial;
}
