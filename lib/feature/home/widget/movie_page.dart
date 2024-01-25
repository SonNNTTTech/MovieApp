// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:test_app/feature/home/provider/home_provider.dart';
import 'package:test_app/feature/home/state/home_state.dart';
import 'package:test_app/shared/app_enum.dart';
import 'package:test_app/shared/widget/my_error_widget.dart';
import 'package:test_app/shared/widget/my_loading.dart';

import 'movie_widget.dart';

class MoviePage extends ConsumerStatefulWidget {
  final MovieType type;
  const MoviePage({
    super.key,
    required this.type,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MoviePageState();
}

class _MoviePageState extends ConsumerState<MoviePage> {
  final scrollController = ScrollController();
  bool isNewPageLoading = false;
  late final HomeState homeNoti;
  @override
  void initState() {
    homeNoti = ref.read(homeNotifierProvider);
    loadPageTrigger();
    super.initState();
  }

  void loadPageTrigger() {
    scrollController.addListener(() async {
      if (isNewPageLoading) return;
      final mapState = homeNoti.mapState;
      if (mapState[widget.type]!.isNoMorePage) return;

      //when scroll to bottom
      if (scrollController.offset >
          (scrollController.position.maxScrollExtent * 0.9)) {
        isNewPageLoading = true;
        await ref.read(homeNotifierProvider.notifier).getNewPage(widget.type);
        isNewPageLoading = false;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final mapState =
        ref.watch(homeNotifierProvider.select((value) => value.mapState));
    if (!mapState.containsKey(widget.type)) return const SizedBox.shrink();

    if (mapState[widget.type]!.isLoading) return const MyLoading();
    if (mapState[widget.type]!.movies.isEmpty) {
      if (mapState[widget.type]!.error != null) {
        return MyErrorWidget(
          onRetry: () =>
              ref.read(homeNotifierProvider.notifier).reloadPage(widget.type),
          text: mapState[widget.type]!.error!,
        );
      }
      return const Center(
        child: Text('No data'),
      );
    }
    return RefreshIndicator(
        onRefresh: () async {
          await ref.read(homeNotifierProvider.notifier).reloadPage(widget.type);
        },
        child: Scrollbar(
          controller: scrollController,
          child: ListView(
            controller: scrollController,
            shrinkWrap: true,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    childAspectRatio: 2 / 3,
                    crossAxisCount: 2,
                    mainAxisSpacing: 12,
                    crossAxisSpacing: 12,
                  ),
                  itemCount: mapState[widget.type]!.movies.length,
                  itemBuilder: (context, index) =>
                      MovieWidget(entity: mapState[widget.type]!.movies[index]),
                ),
              ),
              //   data[widget.type]!.isNoMorePage
              //       ? const SizedBox(height: 44, child: Text('End content'))
              //       : Container()
            ],
          ),
        ));
  }
}
