import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:test_app/generated/l10n.dart';
import 'package:test_app/shared/app_helper.dart';
import 'package:test_app/shared/widget/auto_hide_keyboard.dart';

import '../home/widget/movie_page.dart';
import 'provider/search_provider.dart';

class SeearchMovieView extends HookConsumerWidget {
  const SeearchMovieView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final entity =
        ref.watch(searchNotifierProvider.select((value) => value.entity));
    final keyword =
        ref.watch(searchNotifierProvider.select((value) => value.keyword));
    final controller = useTextEditingController(text: keyword);
    return AutoHideKeyboard(
      child: Scaffold(
          appBar: AppBar(
              title: Text(S.of(context).search),
              backgroundColor: Colors.blue,
              actions: [_buildSearchField(ref, controller)]),
          body: MoviePage(
            entity: entity,
            onReload: () async {
              await ref.watch(searchNotifierProvider.notifier).reloadPage();
            },
            onNewPage: () async {
              AppHelper.myLog('message');
              await ref.watch(searchNotifierProvider.notifier).getNewPage();
            },
            noDataText: keyword == null ? 'Search something' : 'No data found',
          )),
    );
  }

  Widget _buildSearchField(WidgetRef ref, TextEditingController controller) {
    return Container(
      width: 180,
      height: 32,
      padding: const EdgeInsets.only(right: 4),
      child: TextField(
        onChanged: (value) {
          ref.read(searchNotifierProvider.notifier).activeDebouce(value);
        },
        controller: controller,
        decoration: const InputDecoration(
            hintText: 'Enter keyword',
            contentPadding: EdgeInsets.only(left: 12),
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(12))),
            suffixIcon: Icon(Icons.search)),
      ),
    );
  }
}
