import 'package:flutter/material.dart';
import 'package:test_app/shared/widget/my_network_image.dart';

class AvatarWidget extends StatelessWidget {
  final String? imageUrl;
  final String userName;

  const AvatarWidget({
    super.key,
    required this.userName,
    this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: 22,
      backgroundColor: Colors.grey[300],
      child: imageUrl != null
          ? ClipOval(
              child: MyNetworkImage(
                url: imageUrl!,
              ),
            )
          : Text(
              userName.isNotEmpty ? userName[0] : 'U',
              style: const TextStyle(fontSize: 30, color: Colors.black),
            ),
    );
  }
}
