import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:test_app/shared/app_enum.dart';

part 'auth_state.freezed.dart';

@freezed
class AuthState with _$AuthState {
  const factory AuthState({
    String? error,
    String? userName,
    required bool isLoading,
    required AuthMode authMode,
  }) = _AuthState;
}
