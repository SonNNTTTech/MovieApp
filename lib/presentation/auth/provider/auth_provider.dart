import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:test_app/shared/app_enum.dart';
import 'package:test_app/shared/app_global_data.dart';

import '../../../repository/auth/auth_repository.dart';
import '../state/auth_state.dart';

part 'auth_provider.g.dart';

@riverpod
class AuthNotifier extends _$AuthNotifier {
  late final authRepo = ref.read(authRepoProvider);
  @override
  AuthState build() {
    return AuthState(isLoading: false, authMode: AppGlobalData.authMode);
  }

  Future login(String userName, String password) async {
    if (userName.isEmpty || password.isEmpty) {
      state = state.copyWith(error: 'User name and password is required!');
      return null;
    } else {
      state = state.copyWith(error: null);
    }
    state = state.copyWith(isLoading: true);
    final createRequestTokenResult = await authRepo.createRequestToken();
    createRequestTokenResult
        .fold((left) => state = state.copyWith(error: left, isLoading: false),
            (right) async {
      final validateResult = await authRepo.validateWithLogin(
        userName: userName,
        password: password,
      );
      validateResult
          .fold((left) => state = state.copyWith(error: left, isLoading: false),
              (right) async {
        final createSessionResult = await authRepo.createSessionId();
        createSessionResult.fold(
            (left) => state = state.copyWith(error: left, isLoading: false),
            (right) async {
          final getUserResult = await authRepo.getUser();
          getUserResult.fold(
              (left) => state = state.copyWith(error: left, isLoading: false),
              (right) {
            state = state.copyWith(
                isLoading: false,
                authMode: AuthMode.user,
                userName: right.username);
          });
        });
      });
    });
  }

  Future<String?> enterGuestMode() async {
    state = state.copyWith(isLoading: true);
    final result = await authRepo.createGuestSession();
    return result.fold(
      (left) {
        state = state.copyWith(error: left, isLoading: false);
        return null;
      },
      (right) {
        state = state.copyWith(isLoading: false, authMode: AuthMode.guest);
        return right;
      },
    );
  }

  Future logout() async {
    state = state.copyWith(isLoading: true);
    final result = await authRepo.deleteSession();
    result.fold(
      (left) => state = state.copyWith(error: left, isLoading: false),
      (right) {
        enterGuestMode();
      },
    );
  }

//   Future successAuth() async {
//     state = state.copyWith(isLoading: true);
//     final result = await authRepo.createSessionId();
//     await result.fold(
//       (left) {
//         state = state.copyWith(error: left, isLoading: false);
//         return null;
//       },
//       (right) async {
//         final userResponse = await authRepo.getUser();
//         userResponse.fold(
//           (left) => state = state.copyWith(error: left, isLoading: false),
//           (right) {
//             state = state.copyWith(
//                 userName: 'Logged in as ${right.username}',
//                 isLoading: false,
//                 authMode: AuthMode.user);
//           },
//         );
//       },
//     );
//   }
}
