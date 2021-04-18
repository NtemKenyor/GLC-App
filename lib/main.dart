import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'intro.dart';
import 'others/user_part.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'GLC London',
      theme: ThemeData(
        primaryColor: Color(0xFF3eBACE),
        accentColor: Color(0xFFDBECF1),
        scaffoldBackgroundColor: Color(0xFF3F5F7),
      ),
      home: SplashScreen(),
      /* routes: <String, WidgetBuilder>{
        '/home': (BuildContext context) => MyHomePage(title: 'Uniuyo Nuesa')
      }, */
    );
  }
}

class SplashScreen extends StatefulWidget {
  SplashScreen({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _SplashScreenState createState() => _SplashScreenState();
}


class _SplashScreenState extends State<SplashScreen> {
  var splashicon = Icons.book;

  //final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();

  @override
  void initState(){
    super.initState();

    Timer(
        Duration(seconds: 7),
            () => Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (BuildContext context) => user_connect())));
  }

   // Timer(Duration(seconds: 5), () => Navigator.of(context).pop('/home'));
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        width: double.infinity,
        height: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Image.asset("assets/glc logo 1.png", width: 185, height: 185,),

            CircularProgressIndicator(),
          ],
        )
      ),
    );
  }
}




