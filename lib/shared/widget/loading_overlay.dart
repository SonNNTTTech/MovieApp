import 'package:flutter/material.dart';

import 'dialog_wrapper.dart';
import 'my_loading.dart';

class LoadingOverlay extends StatelessWidget {
  final bool isShow;
  const LoadingOverlay({super.key, required this.isShow});

  @override
  Widget build(BuildContext context) {
    return Visibility(
        visible: isShow,
        child: const Center(child: DialogWrapper(child: MyLoading())));
  }
}
