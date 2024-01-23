import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:test_app/common/app_enum.dart';
import 'package:test_app/datasource/movie/movie_datasource_impl.dart';
import 'package:test_app/presentation/home/component/movie_page.dart';
import 'package:test_app/presentation/home/home_riverpod.dart';
import 'package:test_app/repository/home_repository.dart';
import 'package:test_app/widget/dropdown_picker.dart';
import 'package:test_app/widget/fade_indexed_stack.dart';

class HomeView extends ConsumerStatefulWidget {
  static const route = '/home';
  const HomeView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomeViewState();
}

class _HomeViewState extends ConsumerState<HomeView> {
  @override
  void initState() {
    Get.put(HomeRepository(
        movieDataSource: Get.find<MovieDataSourceImpl>(), ref: ref));
    Get.find<HomeRepository>().getNewPage(MovieType.popular);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    MovieType typePicking = ref.watch(homeMovieTypeProvider);
    var data = ref.watch(homeMapMovieProvider);
    return Scaffold(
      appBar: AppBar(
        title: Text(typePicking.text),
      ),
      body: Column(
        children: [
          DropdownPicker<MovieType>(
            items: MovieType.values,
            textBuilder: (value) => value.text,
            onPick: (value) =>
                ref.read(homeMovieTypeProvider.notifier).state = value,
          ),
          Expanded(
            child: FadeIndexedStack(
                index: MovieType.values.indexOf(typePicking),
                children: List.generate(MovieType.values.length, (index) {
                  MovieType type = MovieType.values[index];
                  return MoviePage(
                      items: data[type]!,
                      errorText: ref.watch(homeMapErrorProvider)[type],
                      onReload: () async {
                        await Get.find<HomeRepository>().reloadMovie(type);
                      },
                      onNewPage: () async {
                        await Get.find<HomeRepository>().getNewPage(type);
                      },
                      isNoMorePage:
                          ref.watch(homeMapIsNoMorePageProvider)[type]!);
                })),
          )
        ],
      ),
    );
  }
}
