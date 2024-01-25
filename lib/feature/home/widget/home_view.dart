import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:test_app/feature/home/provider/home_picker_provider.dart';
import 'package:test_app/shared/app_enum.dart';
import 'package:test_app/shared/app_helper.dart';
import 'package:test_app/shared/widget/dropdown_picker.dart';

import 'movie_page.dart';

class HomeView extends ConsumerWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tab =
        ref.watch(homePickerNotifierProvider.select((value) => value.type));
    AppHelper.myLog('tab>>>$tab');
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
                  onPick: ref.read(homePickerNotifierProvider.notifier).pick,
                ),
                const SizedBox(
                  width: 12,
                )
              ],
            ),
            Expanded(
              child: IndexedStack(
                  index: MovieType.values.indexOf(tab),
                  children: List.generate(MovieType.values.length, (index) {
                    AppHelper.myLog('picked >>>> $tab');
                    return MoviePage(
                      type: tab,
                    );
                  })),
            )
          ],
        ));
  }
}
