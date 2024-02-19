import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:test_app/presentation/app/provider/app_provider.dart';
import 'package:test_app/presentation/bottom_bar/widget/bottom_bar_widget.dart';
import 'package:test_app/shared/widget/my_loading.dart';

class SplashView extends ConsumerWidget {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isLoading =
        ref.watch(appNotifierProvider.select((value) => value.isLoading));
    return isLoading
        ? const Scaffold(body: MyLoading())
        : const BottomBarWidget();
  }
}
