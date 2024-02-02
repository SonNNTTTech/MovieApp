import 'package:flutter/material.dart';

import '../../../shared/widget/my_network_image.dart';

class ImageWithTitle extends StatelessWidget {
  final String imageUrl;
  final String title;
  const ImageWithTitle({
    super.key,
    required this.imageUrl,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          flex: 5,
          child: ClipRRect(
            borderRadius: const BorderRadius.all(Radius.circular(8)),
            child: MyNetworkImage(
              url: imageUrl,
            ),
          ),
        ),
        Expanded(
          flex: 2,
          child: Container(
            padding:
                const EdgeInsets.symmetric(horizontal: 8).copyWith(top: 16),
            child: Text(title,
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style:
                    const TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
          ),
        ),
      ],
    );
  }
}
