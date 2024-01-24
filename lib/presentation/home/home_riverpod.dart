import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:test_app/common/app_enum.dart';

import 'entity/home_page_state.dart';

final homeTab =
    StateProvider<MovieType>((ref) => MovieType.popular);

final homeStateMap = StateProvider<Map<MovieType, HomePageState>>((ref) =>
    // ignore: prefer_const_literals_to_create_immutables
    {for (var v in MovieType.values) v: HomePageState(movies: [])});
