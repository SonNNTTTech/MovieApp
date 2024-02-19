import 'package:flutter/material.dart';
import 'package:test_app/shared/app_helper.dart';
import 'package:webview_flutter/webview_flutter.dart';

import 'back_floating_button.dart';

class AppWebView extends StatefulWidget {
  const AppWebView({super.key, required this.url});
  final String url;

  @override
  State<AppWebView> createState() => _AppWebViewState();
}

class _AppWebViewState extends State<AppWebView> {
  int progress = 0;
  late WebViewController controller;
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
        ),
      )
      ..loadRequest(Uri.parse(widget.url));
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
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 40),
                            child: LinearProgressIndicator(
                              value: progress / 100,
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Text('Loading ($progress%...)')
                        ],
                      ),
                    )
                  : Container()
            ],
          ),
        ),
        floatingActionButton: const BackFloatingButton());
  }
}
