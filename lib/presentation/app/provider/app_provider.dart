// ignore_for_file: avoid_public_notifier_properties, avoid_manual_providers_as_generated_provider_dependency
import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:test_app/presentation/favorite/provider/favorite_provider.dart';
import 'package:test_app/repository/account/account_repository.dart';
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
  late final accountRepo = ref.read(accountRepoProvider);
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
      final userResponse = await accountRepo.getUser();
      await userResponse.fold((left) async {
        AppGlobalData.authMode = AuthMode.guest;
        await authRepo.createGuestSession();
      }, (right) async {
        AppGlobalData.authMode = AuthMode.user;
        AppGlobalData.userName = right.username;
        initializeFavorite();
      });
    }
    state = state.copyWith(isLoading: false);
  }

  void initializeFavorite() {
    ref.read(favoriteNotifierProvider.notifier).reloadPage();
  }
}
