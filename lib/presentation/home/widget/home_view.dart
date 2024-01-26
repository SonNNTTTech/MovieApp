import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:test_app/generated/l10n.dart';
import 'package:test_app/shared/app_enum.dart';
import 'package:test_app/shared/widget/dropdown_picker.dart';
import 'package:test_app/shared/widget/fade_indexed_stack.dart';

import '../../app/provider/app_provider.dart';
import '../provider/home_provider.dart';
import 'movie_page.dart';

class HomeView extends ConsumerWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tab = ref.watch(homeNotifierProvider.select((value) => value.tab));
    final locale =
        ref.watch(appNotifierProvider.select((value) => value.locale));
    return Scaffold(
        appBar: AppBar(
            title: Text(S.of(context).top_movie),
          backgroundColor: Colors.blue,
            actions: [
              Row(
                children: [
                  Text(
                    locale.toLanguageTag(),
                  ),
                  Switch(
                    value: ref.watch(appNotifierProvider.notifier).isEnglish(),
                    onChanged: (_) =>
                        ref.read(appNotifierProvider.notifier).change(),
                  )
                ],
              )
            ]
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
