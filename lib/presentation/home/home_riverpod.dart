import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:test_app/common/app_enum.dart';
import 'package:test_app/presentation/home/entity/movie_entity.dart';

final homeMovieTypeProvider =
    StateProvider<MovieType>((ref) => MovieType.popular);

final homeMapMovieProvider = StateProvider<Map<MovieType, List<MovieEntity>>>(
    (ref) => {for (var v in MovieType.values) v: []});

final homeMapErrorProvider = StateProvider<Map<MovieType, String?>>(
    (ref) => {for (var v in MovieType.values) v: null});

final homeMapIsNoMorePageProvider = StateProvider<Map<MovieType, bool>>(
    (ref) => {for (var v in MovieType.values) v: false});
