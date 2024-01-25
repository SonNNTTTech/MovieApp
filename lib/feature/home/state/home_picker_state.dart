import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:test_app/shared/app_enum.dart';

part 'home_picker_state.freezed.dart';

@freezed
class HomePickerState with _$HomePickerState {
  const factory HomePickerState({
    required MovieType type,
  }) = _HomePickerState;
}
