import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebviewScreen extends StatefulWidget {
  const WebviewScreen({super.key});

  @override
  State<WebviewScreen> createState() => _WebviewScreenState();
}

class _WebviewScreenState extends State<WebviewScreen> {
  final controller = WebViewController()
    ..setJavaScriptMode(JavaScriptMode.unrestricted)
    ..loadRequest(Uri.parse('https://easyisp24.com/'));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Easy ISP 24'),
        backgroundColor: Colors.deepPurple.shade50,
        leading: IconButton(
          onPressed: () {
            controller.goBack();
          },
          icon: Icon(Icons.arrow_back_ios),
        ),
      ),
      body: WebViewWidget(controller: controller),
    );
  }
}
