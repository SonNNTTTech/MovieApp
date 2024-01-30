import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:test_app/generated/l10n.dart';
import 'package:test_app/presentation/auth/provider/auth_provider.dart';

import '../../../shared/widget/loading_overlay.dart';
import 'auth_webview.dart';

class AuthView extends ConsumerWidget {
  const AuthView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final error =
        ref.watch(authNotifierProvider.select((value) => value.error));
    final userName =
        ref.watch(authNotifierProvider.select((value) => value.userName));
    final isLoading =
        ref.watch(authNotifierProvider.select((value) => value.isLoading));
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).auth),
        backgroundColor: Colors.blue,
      ),
      body: Center(
        child: Stack(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  userName ?? 'Not logged in',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                ElevatedButton(
                  onPressed: () async {
                    final result = await ref
                        .read(authNotifierProvider.notifier)
                        .startAuth();
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => AuthWebView(
                                token: result!,
                              )),
                    );
                  },
                  child: const Text('Login to IMDB'),
                ),
                error != null
                    ? Text(
                        error,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.red),
                        maxLines: 5,
                      )
                    : Container(),
              ],
            ),
            LoadingOverlay(
              isShow: isLoading,
            )
          ],
        ),
      ),
    );
  }
}
