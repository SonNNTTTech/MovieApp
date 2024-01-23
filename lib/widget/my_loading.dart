import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class MyLoading extends StatelessWidget {
  const MyLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return LoadingAnimationWidget.stretchedDots(
      color: Colors.orangeAccent,
      size: 24,
    );
  }
}
