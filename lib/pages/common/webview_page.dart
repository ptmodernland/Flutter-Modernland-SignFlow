import 'package:bwa_cozy/widget/core/draggable_back_button.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class CommonWebviewPage extends StatefulWidget {
  CommonWebviewPage({Key? key, this.url = "https://www.modernland.co.id/"})
      : super(key: key);
  final String url;

  @override
  _CommonWebviewPageState createState() => _CommonWebviewPageState();
}

class _CommonWebviewPageState extends State<CommonWebviewPage> {

  @override
  Widget build(BuildContext context) {
    var webViewcontroller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            // Update loading bar.
          },
          onPageStarted: (String url) {},
          onPageFinished: (String url) {},
          onWebResourceError: (WebResourceError error) {},
          onNavigationRequest: (NavigationRequest request) {
            if (request.url.startsWith('https://www.youtube.com/')) {
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse(widget.url));

    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            WebViewWidget(controller: webViewcontroller),
            DraggableBackButton()
          ],
        ),
      ),
    );
  }
}
