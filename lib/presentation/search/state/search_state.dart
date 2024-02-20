import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:test_app/presentation/home/entity/movie_page_state.dart';

part 'search_state.freezed.dart';

@freezed
class SearchState with _$SearchState {
  const factory SearchState({
    String? keyword,
    required MoviePageState entity,
    required TextEditingController controller,
  }) =
      _SearchState;
}
