import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:test_app/presentation/home/entity/home_entity.dart';
import 'package:test_app/shared/hook_extension.dart';
import 'package:test_app/shared/widget/my_error_widget.dart';
import 'package:test_app/shared/widget/my_loading.dart';

import 'movie_widget.dart';

class MoviePage extends HookConsumerWidget {
  final HomeEntity entity;
  final Future Function() onReload;
  final Future Function() onNewPage;
  final String? noDataText;
  const MoviePage({
    super.key,
    required this.entity,
    required this.onReload,
    required this.onNewPage,
    this.noDataText,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final scrollController = useScrollController();
    final isNewPageLoading = useState(false);
    usePostFrameCallback(() {
      onReload();
      bool isBottom() =>
          scrollController.offset >
          (scrollController.position.maxScrollExtent * 0.9);

      void scrollToBottom() async {
        if (!isBottom()) return;
        if (isNewPageLoading.value) return;
        if (entity.isNoMorePage) return;
        isNewPageLoading.value = true;
        await onNewPage();
        isNewPageLoading.value = false;
      }

      scrollController.addListener(scrollToBottom);
      return () => scrollController.removeListener(scrollToBottom);
    }, const []);
    if (entity.isLoading) return const Center(child: MyLoading());
    if (entity.movies.isEmpty) {
      if (entity.error != null) {
        return MyErrorWidget(
          onRetry: onReload,
          text: entity.error!,
        );
      }
      return Center(
        child: Text(noDataText ?? 'No data'),
      );
    }
    return RefreshIndicator(
      onRefresh: onReload,
      child: Scrollbar(
        controller: scrollController,
        child: Column(
          children: [
            Expanded(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: GridView.builder(
                  controller: scrollController,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    childAspectRatio: 2 / 3.8,
                    crossAxisCount: 2,
                    mainAxisSpacing: 12,
                    crossAxisSpacing: 12,
                  ),
                  itemCount: entity.movies.length,
                  itemBuilder: (context, index) =>
                      MovieWidget(entity: entity.movies[index]),
                ),
              ),
            ),
            Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.symmetric(
                vertical: 20,
              ),
              child: _buildBottom(entity, isNewPageLoading.value),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBottom(HomeEntity entity, bool isNewPageLoading) {
    if (entity.isNoMorePage) return const Text('End content');
    return isNewPageLoading ? const MyLoading() : const SizedBox.shrink();
  }
}
