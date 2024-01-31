import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:test_app/generated/l10n.dart';
import 'package:test_app/presentation/auth/provider/auth_provider.dart';
import 'package:test_app/shared/app_enum.dart';
import 'package:test_app/shared/widget/dialog_wrapper.dart';

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
    final authMode =
        ref.watch(authNotifierProvider.select((value) => value.authMode));
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).auth),
        backgroundColor: Colors.blue,
      ),
      body: Stack(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  userName ?? 'Not logged in',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                _buildLoginAsUser(authMode, context, ref),
                _buildLoginAsGuest(authMode, context, ref),
                const Text(
                  'You can use guest mode to use limited functional, or connect your IMDB account to login in this app and get unlimited funtional!',
                  textAlign: TextAlign.center,
                ),
                error != null
                    ? Text(
                        'Error: $error',
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.red),
                        maxLines: 5,
                      )
                    : Container(),
              ],
            ),
          ),
          LoadingOverlay(
            isShow: isLoading,
          )
        ],
      ),
    );
  }

  Widget _buildLoginAsGuest(
      AuthMode authMode, BuildContext context, WidgetRef ref) {
    return ElevatedButton(
      onPressed: () {
        if (authMode == AuthMode.guest) {
          showDialog(
              context: context,
              barrierDismissible: true,
              builder: (_) =>
                  const DialogWrapper(child: Text('You are guset already!')));
          return;
        }
        ref.read(authNotifierProvider.notifier).startAuthAsGuest();
      },
      child: const Text('Use guest mode'),
    );
  }

  Widget _buildLoginAsUser(
      AuthMode authMode, BuildContext context, WidgetRef ref) {
    return ElevatedButton(
      onPressed: () async {
        if (authMode == AuthMode.user) {
          showDialog(
              context: context,
              barrierDismissible: true,
              builder: (_) => const DialogWrapper(
                  child: Text('You are logged in already!')));
          return;
        }
        final result =
            await ref.read(authNotifierProvider.notifier).startAuthWithIMDB();
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => AuthWebView(
                    token: result!,
                  )),
        );
      },
      child: const Text('Login to IMDB'),
    );
  }
}
