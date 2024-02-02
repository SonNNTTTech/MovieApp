import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:test_app/shared/app_enum.dart';
import 'package:test_app/shared/app_helper.dart';

import '../../../repository/auth/auth_repository.dart';
import '../state/auth_state.dart';

part 'auth_provider.g.dart';

@riverpod
class AuthNotifier extends _$AuthNotifier {
  late final authRepo = ref.read(authRepoProvider);
  @override
  AuthState build() {
    return const AuthState(isLoading: false, authMode: AuthMode.notLoggedIn);
  }

  Future<String?> startAuthWithIMDB() async {
    state = state.copyWith(isLoading: true);
    AppHelper.myLog('Start call createRequestToken');
    final result = await authRepo.createRequestToken();
    AppHelper.myLog('Done call createRequestToken');
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

  Future<String?> startAuthAsGuest() async {
    state = state.copyWith(isLoading: true);
    final result = await authRepo.createGuestSession();
    return result.fold(
      (left) {
        state = state.copyWith(error: left, isLoading: false);
        return null;
      },
      (right) {
        state = state.copyWith(
            isLoading: false,
            userName: 'Logged in as guest',
            authMode: AuthMode.guest);
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
            state = state.copyWith(
                userName: 'Logged in as ${right.username}',
                isLoading: false,
                authMode: AuthMode.user);
          },
        );
      },
    );
  }
}
