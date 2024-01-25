import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:test_app/feature/home/widget/home_view.dart';

class MyAppView extends ConsumerWidget {
  const MyAppView({super.key});

  @override
  Widget build(BuildContext context, ref) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeView(),
    );
  }
}
