import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:test_app/presentation/movie_detail/provider/movie_detail_provider.dart';
import 'package:test_app/shared/hook_extension.dart';
import 'package:test_app/shared/widget/my_error_widget.dart';
import 'package:test_app/shared/widget/my_loading.dart';


import '../entity/movie_detail_entity.dart';
import 'movie_content_view.dart';

class MovieDetailView extends HookConsumerWidget {
  final int id;
  const MovieDetailView({
    super.key,
    required this.id,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final scrollController = useScrollController();
    usePostFrameCallback(() {
      ref.read(movieDetailNotifierProvider.notifier).loadMovieDetail(id);
      return () => () {};
    }, const []);
    final error =
        ref.watch(movieDetailNotifierProvider.select((value) => value.error));
    final isLoading = ref
        .watch(movieDetailNotifierProvider.select((value) => value.isLoading));
    final entity =
        ref.watch(movieDetailNotifierProvider.select((value) => value.entity));
    final images =
        ref.watch(movieDetailNotifierProvider.select((value) => value.images));

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Movie Detail',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Colors.blue,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: SafeArea(
        child: _buildBody(
            isLoading, error, ref, scrollController, entity, images ?? []),
      ),
    );
  }

  Widget _buildBody(bool? isLoading, String? error, WidgetRef ref,
      ScrollController scrollController,
      MovieDetailEntity? entity,
      List<String> images) {
    if (isLoading ?? true) return const Center(child: MyLoading());
    if (error != null) {
      return Center(
        child: MyErrorWidget(
          text: error,
          onRetry: () => ref
              .read(movieDetailNotifierProvider.notifier)
              .loadMovieDetail(id),
        ),
      );
    }
    return _buildContent(scrollController, entity, images);
  }

  Widget _buildContent(
      ScrollController scrollController,
      MovieDetailEntity? entity, List<String> images) {
    if (entity == null) return Container();
    return MovieContentView(
      scrollController: scrollController,
      entity: entity,
      images: images,
    );
  }
}
