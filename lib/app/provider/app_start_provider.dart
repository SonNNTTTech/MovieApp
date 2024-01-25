import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../state/app_start_state.dart';

part 'app_start_provider.g.dart';

@riverpod
class AppStartNotifier extends _$AppStartNotifier {
  @override
  FutureOr<AppStartState> build() async {
    return const AppStartState.initial();
  }
}
