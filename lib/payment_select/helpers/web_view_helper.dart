import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

import 'str_encoding.dart';

class MyWebView extends StatefulWidget {
  final String url;

  const MyWebView({
    super.key,
    required this.url,
  });

  @override
  State<MyWebView> createState() => _MyWebViewState();
}

class _MyWebViewState extends State<MyWebView> {
  late final WebViewController controller;

  @override
  void initState() {
    super.initState();

    final url = StrEncoding.I.dataUri(widget.url);

    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            debugPrint("progress ---> $progress");
          },
          onPageStarted: (String url) {
            debugPrint("page start ---> $url");
          },
          onPageFinished: (String url) {
            debugPrint("page finished ---> $url");
          },
          onHttpError: (HttpResponseError error) {
            debugPrint("http response error ---> $error");
          },
          onWebResourceError: (WebResourceError error) {
            debugPrint("web resource error ---> $error");
          },
        ),
      )
      ..loadRequest(Uri.parse(url));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: WebViewWidget(controller: controller),
      ),
    );
  }
}
