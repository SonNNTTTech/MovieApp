import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:test_app/presentation/movie_detail/widget/image_with_title.dart';

import 'package:test_app/presentation/movie_detail/entity/movie_detail_entity.dart';
import 'package:test_app/shared/widget/my_network_image.dart';
import 'package:test_app/shared/widget/rating_widget.dart';
import 'package:test_app/shared/widget/scroll_row.dart';
import 'package:test_app/shared/widget/youtube_video_view.dart';

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
                  child: _buildAspectRatioImage(2 / 3, entity.imageUrl),
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
            _buildTitleText('Overview'),
            Text(
              entity.overview,
            ),
            const SizedBox(height: 12),
            const Row(
              children: [
                Icon(FontAwesomeIcons.squareFacebook,
                    color: Colors.purple, size: 32),
                SizedBox(width: 8),
                Icon(FontAwesomeIcons.squareTwitter,
                    color: Colors.blue, size: 32),
                SizedBox(width: 8),
                Icon(FontAwesomeIcons.squareInstagram,
                    color: Colors.pinkAccent, size: 32),
              ],
            ),
            const SizedBox(height: 12),
            _buildTitleText('Keywords'),
            Wrap(
              spacing: 8.0,
              runSpacing: 8.0,
              children:
                  entity.keywords.map((text) => _buildKeyWord(text)).toList(),
            ),
            const SizedBox(height: 12),
            _buildTitleText('Recommendations'),
            ScrollRow(
              height: 180,
              children: entity.recommendations
                  .map((e) => _buildRecommendation(e))
                  .toList(),
            ),
            const SizedBox(height: 12),
            _buildTitleText('Videos'),
            ScrollRow(
              height: 180,
              children:
                  entity.youtubeVideoIds.map((e) => _buildVideo(e)).toList(),
            ),
            const SizedBox(height: 12),
            _buildTitleText('Production'),
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
            _buildTitleText('Detail images'),
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

  AspectRatio _buildAspectRatioImage(double aspectRatio, String url) {
    return AspectRatio(
      aspectRatio: aspectRatio,
      child: ClipRRect(
          borderRadius: const BorderRadius.all(Radius.circular(8)),
          child: MyNetworkImage(url: url)),
    );
  }

  Widget _buildTitleText(String text) {
    return Text(
      text,
      style: const TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 17,
      ),
    );
  }

  Widget _buildKeyWord(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4),
          color: const Color.fromARGB(255, 212, 210, 210)),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 14,
        ),
      ),
    );
  }

  Widget _buildRecommendation(RecommendationMovie item) {
    return IntrinsicWidth(
      child: Column(
        children: [
          Expanded(
            child: ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(8)),
              child: SizedBox(
                  width: 220, child: MyNetworkImage(url: item.imagerUrl)),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 160),
                child: Text(
                  item.name,
                  style: const TextStyle(fontSize: 14),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Text(
                '${item.rating}%',
                style: const TextStyle(fontSize: 14),
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget _buildVideo(String youtubeId) {
    return SizedBox(width: 320, child: YoutubeVideoView(id: youtubeId));
  }
}
