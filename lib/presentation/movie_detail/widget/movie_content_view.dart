import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:test_app/presentation/movie_detail/entity/movie_detail_entity.dart';
import 'package:test_app/shared/widget/my_network_image.dart';
import 'package:test_app/shared/widget/rating_widget.dart';

class MovieContentView extends StatelessWidget {
  final ScrollController scrollController;
  final MovieDetailEntity entity;
  const MovieContentView({
    super.key,
    required this.scrollController,
    required this.entity,
  });

  @override
  Widget build(BuildContext context) {
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
