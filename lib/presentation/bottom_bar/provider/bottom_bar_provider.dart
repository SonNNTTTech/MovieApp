import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../state/bottom_bar_state.dart';

part 'bottom_bar_provider.g.dart';

//Generated by @riverpod
// final bottomBarNotifierProvider =
//     NotifierProvider<BottomBarNotifier, BottomBarState>(BottomBarNotifier.new);

@riverpod
class BottomBarNotifier extends _$BottomBarNotifier {
  @override
  BottomBarState build() {
    return BottomBarState(
        indexTab: 0, controller: PersistentTabController(initialIndex: 0));
  }

  void changeTab(int index) {
    state.controller.jumpToTab(index);
    state = state.copyWith(indexTab: index);
  }
}
