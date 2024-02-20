import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:test_app/generated/l10n.dart';
import 'package:test_app/presentation/auth/provider/auth_provider.dart';
import 'package:test_app/shared/app_enum.dart';
import 'package:test_app/shared/widget/app_webview.dart';
import 'package:test_app/shared/widget/auto_hide_keyboard.dart';
import 'package:test_app/shared/widget/my_text_field.dart';

import '../../../shared/widget/loading_overlay.dart';

class AuthView extends HookConsumerWidget {
  const AuthView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userNameController = useTextEditingController();
    final passwordController = useTextEditingController();
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
          authMode == AuthMode.user
              ? _buildForLoggedIn(userName ?? 'Unknown', ref)
              : _buildForNotLoggedIn(
                  authMode,
                  context,
                  ref,
                  userNameController,
                  passwordController,
                ),
          LoadingOverlay(
            isShow: isLoading,
          )
        ],
      ),
    );
  }

  Widget _buildForNotLoggedIn(
      AuthMode authMode,
      BuildContext context,
      WidgetRef ref,
      TextEditingController userNameController,
      TextEditingController passwordController) {
    return AutoHideKeyboard(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 12),
              const Text(
                'Use TMDB account to login',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 12),
              MyTextField(
                controller: userNameController,
                hintText: 'User name',
              ),
              const SizedBox(height: 12),
              MyTextField(
                controller: passwordController,
                hintText: 'Password',
              ),
              const SizedBox(height: 12),
              _buildError(ref),
              const SizedBox(height: 12),
              ElevatedButton(
                onPressed: () => ref
                    .read(authNotifierProvider.notifier)
                    .login(userNameController.text, passwordController.text),
                child: const Text('LOGIN'),
              ),
              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const AppWebView(
                                url:
                                    'https://www.themoviedb.org/reset-password')),
                      );
                    },
                    child: const Text(
                      'Forgot account? Click here!',
                      style: TextStyle(decoration: TextDecoration.underline),
                    ),
                  ),
                  OutlinedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const AppWebView(
                                url: 'https://www.themoviedb.org/signup')),
                      );
                    },
                    child: const Text('REGISTER'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildError(WidgetRef ref) {
    final error =
        ref.watch(authNotifierProvider.select((value) => value.error));
    return error != null
        ? Text(
            'Error: $error',
            style:
                const TextStyle(fontWeight: FontWeight.bold, color: Colors.red),
            maxLines: 5,
          )
        : Container();
  }

  Widget _buildForLoggedIn(String userName, WidgetRef ref) {
    return Center(
      child: Column(children: [
        Text(
          'Welcome back, $userName!',
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        const SizedBox(height: 12),
        ElevatedButton(
            onPressed: () {
              ref.read(authNotifierProvider.notifier).logout();
            },
            child: const Text('Log out')),
      ]),
    );
  }
}
