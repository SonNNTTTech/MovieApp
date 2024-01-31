// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:test_app/presentation/movie_detail/provider/movie_detail_provider.dart';
import 'package:test_app/shared/hook_extension.dart';
import 'package:test_app/shared/widget/my_error_widget.dart';
import 'package:test_app/shared/widget/my_loading.dart';

import 'package:test_app/shared/widget/my_network_image.dart';
import 'package:test_app/shared/widget/rating_widget.dart';

import '../entity/movie_detail_entity.dart';

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
    Widget body() {
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
      return _buildContent(scrollController, entity);
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Movie Detail'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: SafeArea(
        child: body(),
      ),
    );
  }

  Widget _buildContent(
      ScrollController scrollController, MovieDetailEntity? entity) {
    if (entity == null) return Container();
    return Scrollbar(
      controller: scrollController,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: ListView(
          controller: scrollController,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: AspectRatio(
                    aspectRatio: 2 / 3,
                    child: MyNetworkImage(url: entity.imageUrl),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      RichText(
                          text: TextSpan(
                              text: entity.title,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                                fontSize: 18,
                              ),
                              children: [
                            TextSpan(
                              text: entity.releaseDate?.year != null
                                  ? ' (${entity.releaseDate!.year})'
                                  : '',
                              style: const TextStyle(
                                fontWeight: FontWeight.normal,
                              ),
                            )
                          ])),
                      Text(
                          '${entity.releaseDate != null ? DateFormat('dd/MM/yyyy').format(entity.releaseDate!) : ''} (${entity.region.toUpperCase()})'),
                      Text(entity.kinds.join(', ')),
                      Text(entity.duration),
                      Text(
                        entity.slogan,
                        style: const TextStyle(fontStyle: FontStyle.italic),
                      ),
                      Row(
                        children: [
                          RatingWidget(rate: entity.rating),
                          IconButton.filled(
                              onPressed: () {},
                              icon: const Icon(Icons.favorite)),
                          IconButton.filled(
                              onPressed: () {}, icon: const Icon(Icons.list)),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 4),
            const Text(
              'Overview',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 17,
              ),
            ),
            Text(
              entity.overview,
            ),
          ],
        ),
      ),
    );
  }
}
