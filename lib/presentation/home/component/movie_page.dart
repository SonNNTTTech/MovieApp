import 'package:flutter/material.dart';

import 'package:test_app/presentation/home/component/movie_widget.dart';
import 'package:test_app/presentation/home/entity/home_page_state.dart';
import 'package:test_app/widget/my_error_widget.dart';
import 'package:test_app/widget/my_loading.dart';

class MoviePage extends StatefulWidget {
  final HomePageState pageState;
  final Future Function() onReload;
  final Future Function() onNewPage;
  const MoviePage({
    super.key,
    required this.onReload,
    required this.onNewPage,
    required this.pageState,
  });

  @override
  State<MoviePage> createState() => _MoviePageState();
}

class _MoviePageState extends State<MoviePage> {
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
      if (widget.pageState.isNoMorePage) return;

      //when scroll to bottom
      if (scrollController.offset >
          (scrollController.position.maxScrollExtent * 0.9)) {
        isNewPageLoading = true;
        await widget.onNewPage();
        isNewPageLoading = false;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    if (widget.pageState.isLoading) return const MyLoading();
    if (widget.pageState.movies.isEmpty) {
      if (widget.pageState.error != null) {
        return MyErrorWidget(
          onRetry: widget.onReload,
          text: widget.pageState.error!,
        );
      }
      return const Center(
        child: Text('No data'),
      );
    }
    return RefreshIndicator(
        onRefresh: widget.onReload,
        child: Scrollbar(
          controller: scrollController,
          child: ListView(
            controller: scrollController,
            shrinkWrap: true,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: GridView.count(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  childAspectRatio: 2 / 3,
                  crossAxisCount: 2,
                  mainAxisSpacing: 12,
                  crossAxisSpacing: 12,
                  children: List.generate(
                      widget.pageState.movies.length,
                      (index) =>
                          MovieWidget(entity: widget.pageState.movies[index])),
                ),
              ),
              //   widget.pageState.isNoMorePage
              //       ? const SizedBox(height: 44, child: Text('End content'))
              //       : Container()
            ],
          ),
        ));
  }
}
