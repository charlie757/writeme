import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';


class CommonWebView extends StatefulWidget {

  String url = "";
  String title = "";

  CommonWebView(this.url, this.title);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createElement
    return CommonWebViewState();
  }
}

class CommonWebViewState extends State<CommonWebView> {

  bool isLoading = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();

    // getWebView();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          // backgroundColor: Constants.primaryThemeColor,
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () => Navigator.of(context).pop(),
          ),
          title: Text(widget.title, style: Theme.of(context).textTheme.bodyText2!.copyWith(fontWeight: FontWeight.bold,).copyWith(color: Colors.black)),
        ),
        // body: isLoading ? Center(child: CircularProgressIndicator()) : getWebView());
        body:  Stack(
            children: <Widget>[getWebView(), isLoading ? Center( child: CircularProgressIndicator(),)
        : Stack(),]));
  }

  WebView getWebView() {
    return WebView(
      initialUrl: widget.url,
      javascriptMode: JavascriptMode.unrestricted,
      onWebViewCreated: (WebViewController webViewController) {
        // _controller.complete(webViewController);
      },
      onProgress: (int progress) {
        print('WebView is loading (progress : $progress%)');
      },
      onPageStarted: (String url) {
        print('Page started loading: $url');
      },
      onPageFinished: (String url) {
        print('Page finished loading: $url');

        setState(() {
          isLoading = false;
        });

      },
      gestureNavigationEnabled: true,
      backgroundColor: const Color(0x00000000),
    );
  }
}
