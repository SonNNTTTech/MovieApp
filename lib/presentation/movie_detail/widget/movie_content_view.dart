import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:test_app/presentation/movie_detail/widget/image_with_title.dart';

import 'package:test_app/presentation/movie_detail/entity/movie_detail_entity.dart';
import 'package:test_app/shared/widget/my_network_image.dart';
import 'package:test_app/shared/widget/rating_widget.dart';

class MovieContentView extends StatelessWidget {
  final ScrollController scrollController;
  final MovieDetailEntity entity;
  final List<String> images;
  const MovieContentView({
    super.key,
    required this.scrollController,
    required this.entity,
    required this.images,
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
                      Text(
                        'Revenue: ${NumberFormat.decimalPattern().format(entity.revenue)}\$',
                        style: const TextStyle(fontWeight: FontWeight.bold),
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
            const Text(
              'Production',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 17,
              ),
            ),
            Column(
              children: List.generate(
                entity.productions.length,
                (index) => SizedBox(
                  height: 240,
                  child: ImageWithTitle(
                      imageUrl: entity.productions[index].imageUrl,
                      title: entity.productions[index].name),
                ),
              ),
            ),
            const Text(
              'Detail images',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 17,
              ),
            ),
            GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                childAspectRatio: 1 / 1.778,
                crossAxisCount: 2,
                mainAxisSpacing: 12,
                crossAxisSpacing: 12,
              ),
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (_, index) => MyNetworkImage(url: images[index]),
              itemCount: images.length,
            ),
          ],
        ),
      ),
    );
  }
}
