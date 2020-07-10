import 'dart:async';

import 'package:flutter/material.dart';
import 'package:webview_flutter/platform_interface.dart';
import 'package:webview_flutter/webview_flutter.dart';

class News_view extends StatefulWidget {

  final tieude;
  final url;
  const News_view({Key key,this.tieude,this.url}) : super(key: key);
  @override
  _News_viewState createState() => _News_viewState();
}

class _News_viewState extends State<News_view> {
  final Completer<WebViewController> _controller=Completer<WebViewController>();


  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
        title: Text(widget.tieude,style: TextStyle(color: Colors.white,fontSize: 20),),

    ),
    body: Container(
    child:

    WebView(

    initialUrl: widget.url,
    javascriptMode: JavascriptMode.unrestricted,

    onWebViewCreated: (WebViewController webViewController){
    _controller.complete(webViewController);

    },
    onWebResourceError: (WebResourceError webviewerrr) {
    print("Handle your Error Page here"+webviewerrr.description);
    },


    ),

    ));

  }
}
