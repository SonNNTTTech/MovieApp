import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:test_app/presentation/auth/provider/auth_provider.dart';
import 'package:test_app/presentation/bottom_bar/provider/bottom_bar_provider.dart';
import 'package:test_app/shared/app_enum.dart';

import '../home/widget/movie_page.dart';
import 'provider/favorite_provider.dart';

class FavoriteView extends ConsumerWidget {
  static const route = '/favorite';
  const FavoriteView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(favoriteNotifierProvider);
    final authMode = ref.watch(authNotifierProvider).authMode;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorite'),
      ),
      body: authMode == AuthMode.guest
          ? _buildGuestMode(ref)
          : MoviePage(
              entity: state,
              onReload: () async {
                await ref.watch(favoriteNotifierProvider.notifier).reloadPage();
              },
              onNewPage: () async {
                await ref.watch(favoriteNotifierProvider.notifier).getNewPage();
              },
              noDataText: 'No data found',
              isHideEndContent: true,
            ),
    );
  }

  Widget _buildGuestMode(WidgetRef ref) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('Login to use favorite!'),
          ElevatedButton(
            onPressed: () =>
                ref.read(bottomBarNotifierProvider.notifier).changeTab(3),
            child: const Text('LOGIN'),
          ),
        ],
      ),
    );
  }
}
