import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:test_app/presentation/movie_detail/widget/movie_detail_view.dart';

import 'package:test_app/shared/widget/my_network_image.dart';
import 'package:test_app/shared/widget/rating_widget.dart';

import '../entity/movie_entity.dart';

class MovieWidget extends StatelessWidget {
  final MovieEntity entity;
  const MovieWidget({
    super.key,
    required this.entity,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.of(context)
          .pushNamed(MovieDetailView.route, arguments: entity.id),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: Colors.white,
            boxShadow: const [BoxShadow(color: Colors.black38, blurRadius: 3)]),
        child: Stack(
          children: [
            Column(
              children: [
                Expanded(
                  flex: 5,
                  child: ClipRRect(
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(8),
                        topRight: Radius.circular(8)),
                    child: MyNetworkImage(
                      url: entity.imageUrl,
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8)
                            .copyWith(top: 16),
                        child: Text(entity.name,
                            textAlign: TextAlign.center,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                                fontSize: 15, fontWeight: FontWeight.bold)),
                      ),
                      Text(
                          entity.date != null
                              ? DateFormat('MMM dd, yyyy').format(entity.date!)
                              : '',
                          style: const TextStyle(fontSize: 14)),
                    ],
                  ),
                ),
              ],
            ),
            Positioned(
              bottom: 68,
              child: RatingWidget(
                rate: entity.rate,
              ),
            )
          ],
        ),
      ),
    );
  }
}
