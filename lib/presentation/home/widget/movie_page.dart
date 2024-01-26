import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:test_app/presentation/home/entity/home_entity.dart';
import 'package:test_app/shared/app_enum.dart';
import 'package:test_app/shared/widget/my_error_widget.dart';
import 'package:test_app/shared/widget/my_loading.dart';

import '../provider/home_provider.dart';
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
  @override
  void initState() {
    loadPageTrigger();
    super.initState();
  }

  void loadPageTrigger() {
    scrollController.addListener(() async {
      if (isNewPageLoading) return;
      final mapState = ref.read(homeNotifierProvider).mapState;
      if (mapState[widget.type]!.isNoMorePage) return;

      //when scroll to bottom
      if (scrollController.offset >
          (scrollController.position.maxScrollExtent * 0.9)) {
        isNewPageLoading = true;
        setState(() {});
        await ref.read(homeNotifierProvider.notifier).getNewPage(widget.type);
        isNewPageLoading = false;
        setState(() {});
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final mapState =
        ref.watch(homeNotifierProvider.select((value) => value.mapState));
    final entity = mapState[widget.type]!;
    if (entity.isLoading) return const MyLoading();
    if (entity.movies.isEmpty) {
      if (entity.error != null) {
        return MyErrorWidget(
          onRetry: () =>
              ref.read(homeNotifierProvider.notifier).reloadPage(widget.type),
          text: entity.error!,
        );
      }
      return const Center(
        child: Text('No data'),
      );
    }
    return Column(
      children: [
        Expanded(
          child: RefreshIndicator(
              onRefresh: () async {
                await ref
                    .read(homeNotifierProvider.notifier)
                    .reloadPage(widget.type);
              },
              child: Scrollbar(
                controller: scrollController,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: GridView.builder(
                    controller: scrollController,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      childAspectRatio: 2 / 3,
                      crossAxisCount: 2,
                      mainAxisSpacing: 12,
                      crossAxisSpacing: 12,
                    ),
                    itemCount: entity.movies.length,
                    itemBuilder: (context, index) =>
                        MovieWidget(entity: entity.movies[index]),
                  ),
                ),
              )),
        ),
        Container(
            padding: const EdgeInsets.only(bottom: 8),
            child: _buildBottom(entity)),
      ],
    );
  }

  Widget _buildBottom(HomeEntity entity) {
    if (entity.isNoMorePage) return const Text('End content');
    return isNewPageLoading ? const MyLoading() : const SizedBox.shrink();
  }
}
