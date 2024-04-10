import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import 'dart:io';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:webview_flutter/webview_flutter.dart';


class WebViewDoc extends StatefulWidget {

  String pathPDF = "";

  WebViewDoc(this.pathPDF);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createElement
    return WebViewDocState();
  }
}

class WebViewDocState extends State<WebViewDoc> {

  bool isLoading = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    // widget.pathPDF = "https://firebasestorage.googleapis.com/v0/b/writeme-cf580.appspot.com/o/chatImages%2FCBuXKxvRZLV0hY7yRpx0MU3VlHf2-lB1GOVZEFwRKCDgoWVdUABm4wZ93%2FHunter%20Hikers%20Camping%20Deck_Achrol.pdf?alt=media&token=c12a2bff-553c-417e-b32e-a8d68473b59c";

  }

  @override
  Widget build(BuildContext context) {
    print(widget.pathPDF);
    if (Platform.isAndroid) {
      if (widget.pathPDF.contains(".pdf")) {
        return Scaffold(
            resizeToAvoidBottomInset: false,
            appBar: AppBar(
              // backgroundColor: Constants.primaryThemeColor,
              leading: IconButton(
                icon: Icon(Icons.arrow_back, color: Colors.black),
                onPressed: () => Navigator.of(context).pop(),
              ),
              actions: <Widget>[
                IconButton(
                  icon: Icon(Icons.share),
                  onPressed: () {
                    Share.share(widget.pathPDF);
                  },
                ),
              ],
            ),
            // body: isLoading ? Center(child: CircularProgressIndicator()) : getWebView());
            body:  Container(
                child: SfPdfViewer.network(
                    widget.pathPDF)));;
      } else {

        if (widget.pathPDF.contains(".doc") || widget.pathPDF.contains(".docs") || widget.pathPDF.contains(".docx") || widget.pathPDF.contains(".csv")){

          widget.pathPDF = "https://docs.google.com/viewer?embedded=true&url="+widget.pathPDF;

        }

        if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();

        return Scaffold(
            resizeToAvoidBottomInset: false,
            appBar: AppBar(
              // backgroundColor: Constants.primaryThemeColor,
              leading: IconButton(
                icon: Icon(Icons.arrow_back, color: Colors.black),
                onPressed: () => Navigator.of(context).pop(),
              ),
              actions: <Widget>[
                IconButton(
                  icon: Icon(Icons.share),
                  onPressed: () {
                    Share.share(widget.pathPDF);
                  },
                ),
              ],
            ),
            // body: isLoading ? Center(child: CircularProgressIndicator()) : getWebView());
            body:  Stack(
                children: <Widget>[getWebView(), isLoading ? Center( child: CircularProgressIndicator(),)
                    : Stack(),]));
      }
    }else{
      return Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
            // backgroundColor: Constants.primaryThemeColor,
            leading: IconButton(
              icon: Icon(Icons.arrow_back, color: Colors.black),
              onPressed: () => Navigator.of(context).pop(),
            ),
            actions: <Widget>[
              IconButton(
                icon: Icon(Icons.share),
                onPressed: () {
                  Share.share(widget.pathPDF);
                },
              ),
            ],
          ),
          // body: isLoading ? Center(child: CircularProgressIndicator()) : getWebView());
          body:  Stack(
              children: <Widget>[getWebView(), isLoading ? Center( child: CircularProgressIndicator(),)
                  : Stack(),]));
    }
  }

  WebView getWebView() {
    return WebView(
      initialUrl: widget.pathPDF,
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

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

// @override
// void deactivate() {
//   // TODO: implement deactivate
//   super.deactivate();
// }


}