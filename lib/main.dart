import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:test_app/datasource/http_override.dart';

import 'presentation/app/widget/my_app_view.dart';

void main() {
  HttpOverrides.global = MyHttpOverrides(); 
  runApp(
    const ProviderScope(
      child: MyAppView(),
    ),
  );
}
