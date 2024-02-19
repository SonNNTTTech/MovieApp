import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:test_app/repository/auth/auth_repository.dart';
import 'package:test_app/repository/shared_preferences/sp_repository.dart';
import 'package:test_app/shared/app_enum.dart';
import 'package:test_app/shared/app_global_data.dart';

import '../state/app_state.dart';

part 'app_provider.g.dart';

@riverpod
class AppNotifier extends _$AppNotifier {
  late final authRepo = ref.read(authRepoProvider);
  late final spRepo = ref.read(spRepoProvider);
  @override
  AppState build() {
    return const AppState(locale: Locale('vi'));
  }

  bool isEnglish() {
    return state.locale.languageCode == 'en';
  }

  void change() {
    if (isEnglish()) {
      state = state.copyWith(locale: const Locale('vi'));
    } else {
      state = state.copyWith(locale: const Locale('en'));
    }
  }

  Future initializeAuth() async {
    final sessionId = await spRepo.getSessionId();
    if (sessionId == null) {
      await authRepo.createGuestSession();
    } else {
      AppGlobalData.authMode = AuthMode.user;
    }
    state = state.copyWith(isLoading: false);
  }
}
