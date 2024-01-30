import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:webview_flutter/webview_flutter.dart';

import 'package:test_app/shared/app_helper.dart';

import '../../../shared/widget/back_floating_button.dart';
import '../../../shared/widget/loading_overlay.dart';
import '../provider/auth_provider.dart';

class AuthWebView extends ConsumerStatefulWidget {
  final String token;
  const AuthWebView({
    super.key,
    required this.token,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AuthWebViewState();
}

class _AuthWebViewState extends ConsumerState<AuthWebView> {
  int progress = 0;
  late WebViewController controller;
  bool isLoading = false;
  @override
  void initState() {
    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onWebResourceError: (WebResourceError error) {
            AppHelper.myLog('error webview: ${error.description}');
          },
          onProgress: (int progress) {
            AppHelper.myLog('progress $progress');
            setState(() {
              this.progress = progress;
            });
          },
          onNavigationRequest: (request) async {
            if (request.url.contains(
                'https://www.themoviedb.org/authenticate/${widget.token}/allow')) {
              isLoading = true;
              setState(() {});

              await ref.read(authNotifierProvider.notifier).successAuth();
              isLoading = false;
              setState(() {});
              Navigator.pop(context);
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(
          Uri.parse('https://www.themoviedb.org/authenticate/${widget.token}'));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
          child: Stack(
            children: [
              progress == 100
                  ? WebViewWidget(controller: controller)
                  : Container(),
              progress != 100
                  ? Container(
                      padding: const EdgeInsets.symmetric(horizontal: 40),
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            LinearProgressIndicator(
                              value: progress / 100,
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Text('Loading ($progress%...)')
                          ],
                        ),
                      ),
                    )
                  : Container(),
              LoadingOverlay(
                isShow: isLoading,
              )
            ],
          ),
        ),
        floatingActionButton: const BackFloatingButton());
  }
}
