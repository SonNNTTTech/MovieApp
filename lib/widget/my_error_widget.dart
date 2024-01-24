import 'package:flutter/material.dart';

class MyErrorWidget extends StatelessWidget {
  final String text;
  final Function()? onRetry;
  const MyErrorWidget({
    super.key,
    required this.text,
    this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          text,
          style: const TextStyle(
            color: Colors.red,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        IconButton(onPressed: onRetry, icon: const Icon(Icons.refresh))
      ],
    );
  }
}
