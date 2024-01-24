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
    Future.delayed(Duration.zero, () {
      Get.find<HomeRepository>().reloadPage(MovieType.popular);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    MovieType tab = ref.watch(homeTab);
    var stateMap = ref.watch(homeStateMap);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Top Movie'),
      ),
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              DropdownPicker<MovieType>(
                items: MovieType.values,
                textBuilder: (value) => value.text,
                initialIndex: MovieType.values.indexOf(tab),
                onPick: Get.find<HomeRepository>().changeTab,
              ),
              const SizedBox(
                width: 12,
              )
            ],
          ),
          Expanded(
            child: FadeIndexedStack(
                index: MovieType.values.indexOf(tab),
                children: List.generate(MovieType.values.length, (index) {
                  MovieType type = MovieType.values[index];
                  return MoviePage(
                    pageState: stateMap[type]!,
                    onReload: () async {
                      await Get.find<HomeRepository>().reloadPage(type);
                    },
                    onNewPage: () async {
                      await Get.find<HomeRepository>().getNewPage(type);
                    },
                  );
                })),
          )
        ],
      ),
    );
  }
}
