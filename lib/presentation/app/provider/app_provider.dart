import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../state/app_state.dart';

part 'app_provider.g.dart';

@riverpod
class AppNotifier extends _$AppNotifier {
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
}
