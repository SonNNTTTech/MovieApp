import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:test_app/app/widget/app.dart';

void main() {
  runApp(
    const ProviderScope(
      child: MyAppView(),
    ),
  );
}
