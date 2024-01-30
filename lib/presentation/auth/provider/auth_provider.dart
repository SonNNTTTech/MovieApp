import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../repository/auth/auth_repository.dart';
import '../state/auth_state.dart';

part 'auth_provider.g.dart';

@riverpod
class AuthNotifier extends _$AuthNotifier {
  late final authRepo = ref.read(authRepoProvider);
  @override
  AuthState build() {
    return const AuthState(isLoading: false);
  }

  Future<String?> startAuth() async {
    state = state.copyWith(isLoading: true);
    final result = await authRepo.createRequestToken();
    return result.fold(
      (left) {
        state = state.copyWith(error: left, isLoading: false);
        return null;
      },
      (right) {
        state = state.copyWith(isLoading: false);
        return right;
      },
    );
  }

  Future successAuth() async {
    state = state.copyWith(isLoading: true);
    final result = await authRepo.createSessionId();
    await result.fold(
      (left) {
        state = state.copyWith(error: left, isLoading: false);
        return null;
      },
      (right) async {
        final userResponse = await authRepo.getUser();
        userResponse.fold(
          (left) => state = state.copyWith(error: left, isLoading: false),
          (right) {
            state = state.copyWith(userName: right.username, isLoading: false);
          },
        );
      },
    );
  }
}
