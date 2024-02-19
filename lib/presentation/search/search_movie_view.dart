import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:test_app/shared/widget/auto_hide_keyboard.dart';

import '../home/widget/movie_page.dart';
import 'provider/search_provider.dart';

class SeearchMovieView extends ConsumerWidget {
  const SeearchMovieView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final entity =
        ref.watch(searchNotifierProvider.select((value) => value.entity));
    final keyword =
        ref.watch(searchNotifierProvider.select((value) => value.keyword));
    final controller =
        ref.watch(searchNotifierProvider.select((value) => value.controller));
    return AutoHideKeyboard(
      child: Scaffold(
          appBar: AppBar(
            title: _buildSearchField(ref, controller),
          ),
          body: Column(
            children: [
              keyword?.isEmpty ?? true
                  ? const SizedBox()
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          'Search results for "$keyword":',
                          style: const TextStyle(fontStyle: FontStyle.italic),
                        ),
                        const SizedBox(width: 20),
                      ],
                    ),
              const SizedBox(height: 8),
              Expanded(
                child: MoviePage(
                  entity: entity,
                  onReload: () async {
                    await ref
                        .watch(searchNotifierProvider.notifier)
                        .reloadPage();
                  },
                  onNewPage: () async {
                    await ref
                        .watch(searchNotifierProvider.notifier)
                        .getNewPage();
                  },
                  noDataText: keyword?.isEmpty ?? true
                      ? 'Search something'
                      : 'No data found',
                  isHideEndContent: true,
                ),
              ),
            ],
          )),
    );
  }

  Widget _buildSearchField(WidgetRef ref, TextEditingController controller) {
    return Container(
      height: 32,
      padding: const EdgeInsets.only(right: 4),
      child: TextField(
        onChanged: (value) {
          ref.read(searchNotifierProvider.notifier).activeDebouce(value);
        },
        controller: controller,
        decoration: InputDecoration(
          hintText: 'Search for movie...',
          contentPadding: const EdgeInsets.only(left: 12),
          focusedBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(32))),
          enabledBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(32))),
          suffixIcon: Container(
            width: 76,
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 2),
            alignment: Alignment.center,
            decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(32)),
                color: Colors.blueGrey),
            child: const Text(
              'Search',
              style: TextStyle(color: Colors.white, fontSize: 11),
            ),
          ),
        ),
      ),
    );
  }
}
