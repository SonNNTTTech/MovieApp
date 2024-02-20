import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:test_app/presentation/app/provider/app_provider.dart';
import 'package:test_app/presentation/bottom_bar/widget/bottom_bar_widget.dart';
import 'package:test_app/shared/hook_extension.dart';
import 'package:test_app/shared/widget/my_loading.dart';

class SplashView extends HookConsumerWidget {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    usePostFrameCallback(() {
      ref.read(appNotifierProvider.notifier).initializeAuth();
      return () => () {};
    }, const []);
    final isLoading =
        ref.watch(appNotifierProvider.select((value) => value.isLoading));
    return isLoading
        ? const Scaffold(body: Center(child: MyLoading()))
        : const BottomBarWidget();
  }
}
