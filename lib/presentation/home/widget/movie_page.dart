import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:test_app/presentation/home/entity/home_entity.dart';
import 'package:test_app/shared/scroll_helper.dart';
import 'package:test_app/shared/widget/my_error_widget.dart';
import 'package:test_app/shared/widget/my_loading.dart';

import 'movie_widget.dart';

class MoviePage extends ConsumerStatefulWidget {
  final HomeEntity entity;
  final Future Function() onReload;
  final Future Function() onNewPage;
  final String? noDataText;
  final bool isHideEndContent;
  final bool isNeedInitial;
  const MoviePage({
    super.key,
    required this.entity,
    required this.onReload,
    required this.onNewPage,
    this.noDataText,
    this.isHideEndContent = false,
    this.isNeedInitial = true,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MoviePageState();
}

class _MoviePageState extends ConsumerState<MoviePage> {
  late ScrollController scrollController;
  @override
  void initState() {
    if (widget.isNeedInitial) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        widget.onReload();
      });
    }
    scrollController = getScrollController(onBottomScroll);
    super.initState();
  }

  Future onBottomScroll() async {
    if (widget.entity.isNewPageLoading) return;
    if (widget.entity.isNoMorePage) return;
    await widget.onNewPage();
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.entity.isLoading) return const Center(child: MyLoading());
    if (widget.entity.movies.isEmpty) {
      if (widget.entity.error != null) {
        return MyErrorWidget(
          onRetry: widget.onReload,
          text: widget.entity.error!,
        );
      }
      return Center(
        child: Text(widget.noDataText ?? 'No data'),
      );
    }
    return RefreshIndicator(
      onRefresh: widget.onReload,
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
                  itemCount: widget.entity.movies.length,
                  itemBuilder: (context, index) =>
                      MovieWidget(entity: widget.entity.movies[index]),
                ),
              ),
            ),
            _buildBottom(),
          ],
        ),
      ),
    );
  }

  Widget _buildBottom() {
    Widget? child;
    if (widget.entity.isNoMorePage && !widget.isHideEndContent) {
      child = const Text('End content');
    }
    if (widget.entity.isNewPageLoading) {
      child = const MyLoading();
    }
    if (child == null) return Container();
    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.symmetric(
        vertical: 20,
      ),
      child: child,
    );
  }
}
