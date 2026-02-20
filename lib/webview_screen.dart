import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebviewScreen extends StatefulWidget {
  const WebviewScreen({super.key});

  @override
  State<WebviewScreen> createState() => _WebviewScreenState();
}

class _WebviewScreenState extends State<WebviewScreen> {
  bool _canGoBack = false;

  final controller = WebViewController();

  @override
  void initState() {
    super.initState();
    controller
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(NavigationDelegate(
        onPageFinished: (url) async {
          final canGoBack = await controller.canGoBack();
          setState(() {
            _canGoBack = canGoBack;
          });
        },
      ))
      ..loadRequest(Uri.parse('https://easyisp24.com/'));
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) async {
        if (await controller.canGoBack()) {
          controller.goBack();
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text('Easy ISP 24'),
          backgroundColor: Colors.deepPurple.shade50,
          leading: _canGoBack
              ? IconButton(
            onPressed: () => controller.goBack(),
            icon: Icon(Icons.arrow_back_ios),
          )
              : null,
        ),
        body: WebViewWidget(controller: controller),
      ),
    );
  }
}
