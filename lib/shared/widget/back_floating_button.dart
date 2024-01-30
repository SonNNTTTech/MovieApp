import 'package:flutter/material.dart';

class BackFloatingButton extends StatelessWidget {
  const BackFloatingButton({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: Navigator.of(context).pop,
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
            shape: BoxShape.circle, color: Colors.black.withOpacity(0.5)),
        child: const Icon(
          Icons.arrow_back,
          color: Colors.white,
          size: 24,
        ),
      ),
    );
  }
}
