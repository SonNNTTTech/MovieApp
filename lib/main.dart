import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:test_app/common/dependency.dart';
import 'package:test_app/presentation/my_app/my_app_view.dart';

void main() {
  Dependency.initDataSources();
  runApp(
    const ProviderScope(
      child: MyAppView(),
    ),
  );
}
