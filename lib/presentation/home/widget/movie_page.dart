import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:test_app/presentation/home/entity/home_entity.dart';
import 'package:test_app/shared/app_enum.dart';
import 'package:test_app/shared/hook_extension.dart';
import 'package:test_app/shared/widget/my_error_widget.dart';
import 'package:test_app/shared/widget/my_loading.dart';

import '../provider/home_provider.dart';
import 'movie_widget.dart';

class MoviePage extends HookConsumerWidget {
  final MovieType type;
  const MoviePage({
    super.key,
    required this.type,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final scrollController = useScrollController();
    final mapState =
        ref.watch(homeNotifierProvider.select((value) => value.mapState));
    final entity = mapState[type];
    bool isNewPageLoading = entity?.isNewPageLoading ?? false;
    usePostFrameCallback(() {
      ref.read(homeNotifierProvider.notifier).reloadPage(type);
      bool isBottom() =>
          scrollController.offset >
          (scrollController.position.maxScrollExtent * 0.9);

      void scrollToBottom() async {
        if (isNewPageLoading) return;
        if (entity?.isNoMorePage ?? true) return;
        if (isBottom()) {
          isNewPageLoading = true;
          await ref.read(homeNotifierProvider.notifier).getNewPage(type);
          isNewPageLoading = false;
        }
      }

      scrollController.addListener(scrollToBottom);
      return () => scrollController.removeListener(scrollToBottom);
    }, const []);
    if (entity == null) return Container();
    if (entity.isLoading) return const Center(child: MyLoading());
    if (entity.movies.isEmpty) {
      if (entity.error != null) {
        return MyErrorWidget(
          onRetry: () =>
              ref.read(homeNotifierProvider.notifier).reloadPage(type),
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
                await ref.read(homeNotifierProvider.notifier).reloadPage(type);
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
          padding: const EdgeInsets.only(
            bottom: 8,
          ),
          child: _buildBottom(entity, isNewPageLoading),
        ),
      ],
    );
  }

  Widget _buildBottom(HomeEntity entity, bool isNewPageLoading) {
    if (entity.isNoMorePage) return const Text('End content');
    return isNewPageLoading ? const MyLoading() : const SizedBox.shrink();
  }
}
