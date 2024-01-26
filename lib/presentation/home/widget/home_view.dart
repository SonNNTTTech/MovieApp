import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:test_app/shared/app_enum.dart';
import 'package:test_app/shared/widget/dropdown_picker.dart';
import 'package:test_app/shared/widget/fade_indexed_stack.dart';

import '../provider/home_provider.dart';
import 'movie_page.dart';

class HomeView extends ConsumerWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tab = ref.watch(homeNotifierProvider.select((value) => value.tab));
    return Scaffold(
        appBar: AppBar(
          title: const Text('Top Movie'),
          backgroundColor: Colors.blue,
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
                  onPick: ref.read(homeNotifierProvider.notifier).changeTab,
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
                    return MoviePage(
                      type: tab,
                    );
                  })),
            )
          ],
        ));
  }
}
