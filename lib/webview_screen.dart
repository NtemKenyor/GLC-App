import 'dart:async';
//import 'dart:html';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
//import 'package:webview_flutter/webview_flutter.dart' as theWeber;
//import 'package:webview_media/platform_interface.dart';
//import 'package:youtube_player_flutter/src/widgets/widgets.dart';
//import 'ytview';
//import 'package:ytview/ytview.dart';
import 'package:webview_media/webview_flutter.dart' as theWeber;


class GLCWebview extends StatefulWidget {
  final String url;

  GLCWebview({this.url});
  @override
  _GLCWebviewState createState() => _GLCWebviewState( where2go: url );
}

class _GLCWebviewState extends State<GLCWebview> {
  String where2go;
  _GLCWebviewState({this.where2go});
  Completer<theWeber.WebViewController> _controller = Completer<theWeber.WebViewController>();
  theWeber.WebViewController webViewController;

  _bookmarkButton() {
      return FutureBuilder<theWeber.WebViewController>(
      future: _controller.future,
      builder: (BuildContext context, AsyncSnapshot<theWeber.WebViewController> controller) {
        if (controller.hasData) {
          return FloatingActionButton(
            onPressed: () async {
              var url = await controller.data.currentUrl();
              _favorites.add(url);
              Scaffold.of(context).showSnackBar(
                SnackBar(content: Text('Saved $url for later reading.')),
              );
            },
            child: Icon(Icons.favorite),
          );
        }
        return Container();
      },
    );
  }

  final Set<String> _favorites = Set<String>();

  bool _isLoadingPage = true;
  //var progress = 

  String the_badguy = " ";

  turnersBad() async {
    var controller = await _controller.future;
    var url = await controller.currentUrl();
    if (url.contains("a1in1.com/GLC/bad_guy.php")){
      Navigator.of(context).pop();
    } 
    /* the_badguy = await webViewController.currentUrl();
    if (the_badguy.contains("a1in1.com/data.php")){
      Navigator.of(context).pop();
    } */
  }
  @override
  Widget build(BuildContext context) {
    if (where2go == null){
      where2go = "https://a1in1.com/GLC/webview.php";
    }

    /* var verticalGestures = Factory<VerticalDragGestureRecognizer>(
      () => VerticalDragGestureRecognizer());
    var gestureSet = Set.from([verticalGestures]); */

    return Scaffold(
      appBar: AppBar(
        //leading: Icon(Icons.menu),
        automaticallyImplyLeading: false,
        elevation: 0,
        backgroundColor: Color.fromRGBO(255, 255, 255, 1),
        title: Padding(
          padding: EdgeInsets.fromLTRB(4, 10, 4, 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              IconButton(
                icon: Icon(Icons.arrow_back_rounded, color: Colors.black,), 
                onPressed: (){
                  Navigator.of(context).pop();
                },
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image.asset("assets/glc logo 1.png", width: 120, height: 55,),
              ),

              CircleAvatar(
                backgroundColor: Color.fromRGBO(255, 255, 255, 1),
              )

             // CircularAvater()
              /* IconButton(
                onPressed: ()=> {userSide()},
                icon: Icon(Icons.person, ),
                color: dark_,
              ) */
            ]
          ),
        )
      ),
      body: theWeber.WebView(
        initialUrl: where2go,
        javascriptMode: theWeber.JavascriptMode.unrestricted,
        onWebViewCreated: (webViewController) {
          _controller.complete(webViewController);
        },
        onPageFinished: (finish) {
          turnersBad();
          /* setState(() {
            _isLoadingPage = false;
          }); */
        },
      )
      
      /* : (_isLoadingPage) ? Container(
            child: Center(child: CircularProgressIndicator(strokeWidth: 5, backgroundColor: Colors.orange[700], )),
          ) :  */
            
      
      /* Stack(
        children: [
          
          theWeber.WebView(
            initialUrl: where2go,
            javascriptMode: theWeber.JavascriptMode.unrestricted,
            /* gestureRecognizers: Set()
              ..add(Factory<VerticalDragGestureRecognizer>(
                () => VerticalDragGestureRecognizer())), */
            onWebViewCreated: (theWeber.WebViewController webViewController) {
              _controller.complete(webViewController);
/*               gestureRecognizers: Set()
    ..add(Factory<VerticalDragGestureRecognizer>(
      () => VerticalDragGestureRecognizer())), */
            },
            onPageFinished: (finish) {
              setState(() {
                _isLoadingPage = false;
              });
            },
          ),

      _isLoadingPage
        ? Container(
            alignment: FractionalOffset.center,
            child: CircularProgressIndicator(strokeWidth: 5, backgroundColor: Colors.orange[700], ),
          )
        : Container(
            color: Colors.transparent,
          ),
        ],
      ), */
    );
  }
}