import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../bottom_bar/widget/bottom_bar_widget.dart';

class MyAppView extends ConsumerWidget {
  const MyAppView({super.key});

  @override
  Widget build(BuildContext context, ref) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: BottomBarWidget(),
    );
  }
}
