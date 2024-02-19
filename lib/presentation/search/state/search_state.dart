import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:test_app/presentation/home/entity/home_entity.dart';

part 'search_state.freezed.dart';

@freezed
class SearchState with _$SearchState {
  const factory SearchState({
    String? keyword,
    required HomeEntity entity,
    required TextEditingController controller,
  }) =
      _SearchState;
}
