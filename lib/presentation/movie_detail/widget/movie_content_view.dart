import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:readmore/readmore.dart';
import 'package:test_app/presentation/movie_detail/widget/image_with_title.dart';

import 'package:test_app/presentation/movie_detail/entity/movie_detail_entity.dart';
import 'package:test_app/presentation/movie_detail/widget/movie_detail_view.dart';
import 'package:test_app/shared/widget/avatar_widget.dart';
import 'package:test_app/shared/widget/my_network_image.dart';
import 'package:test_app/shared/widget/rating_widget.dart';
import 'package:test_app/shared/widget/scroll_row.dart';
import 'package:test_app/shared/widget/youtube_video_view.dart';

import '../provider/movie_detail_provider.dart';

class MovieContentView extends ConsumerWidget {
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
  Widget build(BuildContext context, WidgetRef ref) {
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
                  child: _buildDetailMovie(ref),
                ),
              ],
            ),
            const SizedBox(height: 4),
            _buildTitleText('Overview'),
            Text(
              entity.overview,
            ),
            const SizedBox(height: 12),
            _buildSocialMedia(),
            ..._buildTitlePart(
              'Keywords',
              entity.keywords.isNotEmpty,
              Wrap(
                spacing: 8.0,
                runSpacing: 8.0,
                children:
                    entity.keywords
                    .map((text) => _buildKeyWord(text, ref))
                    .toList(),
              ),
            ),
            ..._buildTitlePart(
              'Recommendations',
              entity.recommendations.isNotEmpty,
              ScrollRow(
                height: 180,
                children: entity.recommendations
                    .map((e) => _buildRecommendation(e, context))
                    .toList(),
              ),
            ),
            ..._buildTitlePart(
              'Videos',
              entity.youtubeVideoIds.isNotEmpty,
              ScrollRow(
                height: 180,
                children:
                    entity.youtubeVideoIds.map((e) => _buildVideo(e)).toList(),
              ),
            ),
            ..._buildTitlePart(
              'Reviews',
              entity.reviews.isNotEmpty,
              Column(
                children: entity.reviews.map((e) => _buildReview(e)).toList(),
              ),
            ),
            ..._buildTitlePart(
              'Production',
              entity.productions.isNotEmpty,
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
            ),
            ..._buildTitlePart(
              'Detail images',
              images.isNotEmpty,
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
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildSocialMedia() {
    return const Row(
      children: [
        Icon(FontAwesomeIcons.squareFacebook, color: Colors.purple, size: 32),
        SizedBox(width: 8),
        Icon(FontAwesomeIcons.squareTwitter, color: Colors.blue, size: 32),
        SizedBox(width: 8),
        Icon(FontAwesomeIcons.squareInstagram,
            color: Colors.pinkAccent, size: 32),
      ],
    );
  }

  Widget _buildDetailMovie(WidgetRef ref) {
    return Column(
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
                onPressed: () => ref
                    .read(movieDetailNotifierProvider(entity.id).notifier)
                    .onFavoriteClick(),
                icon: Icon(
                  Icons.favorite,
                  color: ref.watch(movieDetailNotifierProvider(entity.id)
                          .select((value) => value.isFavorited))
                      ? Colors.red
                      : null,
                )),
            // IconButton.filled(onPressed: () {}, icon: const Icon(Icons.list)),
          ],
        ),
      ],
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

  Widget _buildKeyWord(String text, WidgetRef ref) {
    return InkWell(
      onTap: () => ref
          .read(movieDetailNotifierProvider(entity.id).notifier)
          .onKeywordClick(text),
      child: Container(
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
      ),
    );
  }

  Widget _buildRecommendation(RecommendationMovie item, BuildContext context) {
    return InkWell(
      onTap: () => Navigator.of(context)
          .pushNamed(MovieDetailView.route, arguments: item.id),
      child: IntrinsicWidth(
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
      ),
    );
  }

  Widget _buildVideo(String youtubeId) {
    return SizedBox(width: 320, child: YoutubeVideoView(id: youtubeId));
  }

  Widget _buildReview(ReviewEntity item) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey, width: 1),
      ),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AvatarWidget(
                userName: item.name,
                imageUrl: item.avatarUrl,
              ),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.name,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                  Text(
                    item.date == null
                        ? 'Error date'
                        : DateFormat('dd/MM/yyyy').format(item.date!),
                    style: const TextStyle(
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 4),
          ReadMoreText(
            item.content,
            trimLines: 4,
            colorClickableText: Colors.pink,
            trimMode: TrimMode.Line,
            trimCollapsedText: 'Show more',
            trimExpandedText: 'Show less',
            moreStyle:
                const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
            lessStyle:
                const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  List<Widget> _buildTitlePart(String title, bool isShow, Widget child) {
    return isShow
        ? [
            const SizedBox(height: 12),
            _buildTitleText(title),
            child,
          ]
        : [];
  }
}
