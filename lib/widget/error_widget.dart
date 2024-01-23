import 'package:flutter/material.dart';

class ErrorWidget extends StatelessWidget {
  final String text;
  final Function()? onRetry;
  const ErrorWidget({
    Key? key,
    required this.text,
    this.onRetry,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
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
