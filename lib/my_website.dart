import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class MyWebsite extends StatefulWidget {
  @override
  State<MyWebsite> createState() => _MyWebsite();
}

class _MyWebsite extends State<MyWebsite> {
  late InAppWebViewController inAppWebViewController;
  bool isLoading = true;
  double _progress = 0;

  @override
  Widget build(BuildContext context) {

    return WillPopScope(
      onWillPop: ()async {
        var isLastpage = await inAppWebViewController.canGoBack();

        if(isLastpage){
          inAppWebViewController.goBack();
          return false;
        }

        return true;
      },
      child : SafeArea(
        child: Scaffold(

       body: Stack(
        children: [
          InAppWebView(
            initialUrlRequest: URLRequest(
              url: WebUri("https://flutter.dev/")
            ),
                onWebViewCreated: ( controller){
              inAppWebViewController = controller;
                },
            onLoadStart: (controller, url) {
              print("Started loading: $url");
            },
            onLoadStop: (controller, url) async {
              print("Stopped loading: $url");
            },
            onReceivedError: (controller, request, error) {
              print("Error: ${error.description}");
            },

            onProgressChanged: (controller, int progress){
              setState(() {
                _progress = progress/100;
              });
            },
          ),
          _progress < 0 ? Container(
            child: LinearProgressIndicator (
              value: _progress,
            ),
          ) : SizedBox()
        ],
      )


    ),
    ),
    );
  }

}