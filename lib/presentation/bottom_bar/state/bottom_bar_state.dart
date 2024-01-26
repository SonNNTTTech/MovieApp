import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

part 'bottom_bar_state.freezed.dart';

@freezed
class BottomBarState with _$BottomBarState {
  const factory BottomBarState(
      {required int indexTab,
      required PersistentTabController controller}) = _BottomBarState;
}
