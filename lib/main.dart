import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'presentation/app/widget/my_app_view.dart';

void main() {
  runApp(
    const ProviderScope(
      child: MyAppView(),
    ),
  );
}
