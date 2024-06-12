//import 'dart:nativewrappers/_internal/vm/lib/core_patch.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'dart:core';

class WebviewScreen extends StatefulWidget {
  const WebviewScreen({Key? key}) : super(key: key);

  @override
  State<WebviewScreen> createState() => _WebviewScreenState();
}

class _WebviewScreenState extends State<WebviewScreen> {
  InAppWebViewController?webViewController;
  PullToRefreshController?refreshController;

  late var url;
  var progress=0;
  var urlController=TextEditingController();
  var initialurl='https://backup1.goldenfishbh.website/';

  Future<bool> _goBack(BuildContext context) async {
    if (await webViewController!.canGoBack()) {
      webViewController!.goBack();
      return false;
    } else {
      return (await showDialog<bool>(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Exit App?"),
            content: Text("Are you sure you want to exit the app?"),
            actions: <Widget>[
              TextButton(
                child: Text("No"),
                onPressed: () {
                  Navigator.of(context).pop(false);
                },
              ),
              TextButton(
                child: Text("Yes"),
                onPressed: () {
                  Navigator.of(context).pop(true);
                },
              ),
            ],
          );
        },
      )) ?? false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WillPopScope(
        onWillPop:( )=>_goBack(context),
        child: Column(children: [Expanded(child: InAppWebView(
          onWebViewCreated:(controller)=>webViewController=controller,
          initialUrlRequest: URLRequest(url: WebUri(initialurl.toString())),
        ))],

        ),
      ),
    );
  }
}
