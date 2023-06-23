import 'package:bwa_cozy/bloc/webview/webview_cubit.dart';
import 'package:bwa_cozy/widget/core/draggable_back_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:webview_flutter/webview_flutter.dart';

class CommonWebviewPage extends StatelessWidget {
  CommonWebviewPage({Key? key, this.url = "https://www.modernland.co.id/"})
      : super(key: key);
  final String url;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => WebViewCubit(),
      child: _CommonWebviewPageContent(url: url),
    );
  }
}

class _CommonWebviewPageContent extends StatefulWidget {
  final String url;

  const _CommonWebviewPageContent({Key? key, required this.url})
      : super(key: key);

  @override
  _CommonWebviewPageContentState createState() =>
      _CommonWebviewPageContentState();
}

class _CommonWebviewPageContentState extends State<_CommonWebviewPageContent> {
  late WebViewController _webViewController;
  late WebViewCubit _webViewCubit;

  @override
  void initState() {
    super.initState();
    _webViewCubit = BlocProvider.of<WebViewCubit>(context);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            WebView(
              initialUrl: widget.url,
              javascriptMode: JavascriptMode.unrestricted,
              onWebViewCreated: (controller) {
                _webViewController = controller;
              },
              onPageStarted: (url) {
                _webViewCubit.handleEvent(WebViewStarted());
              },
              onPageFinished: (url) {
                _webViewCubit.handleEvent(WebViewFinished());
              },
              navigationDelegate: (NavigationRequest request) {
                if (request.url.startsWith('https://www.youtube.com/')) {
                  return NavigationDecision.prevent;
                }
                return NavigationDecision.navigate;
              },
            ),
            BlocBuilder<WebViewCubit, bool>(
              builder: (context, isLoading) {
                if (isLoading) {
                  return Center(
                    child: CupertinoActivityIndicator(),
                  );
                } else {
                  return SizedBox.shrink();
                }
              },
            ),
            DraggableBackButton(),
          ],
        ),
      ),
    );
  }
}