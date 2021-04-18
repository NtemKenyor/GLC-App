import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'intro.dart';
import 'others/user_part.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

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
  int condition = 0;
  
  user_stands() async {
    print("here");
    if(await check_in_SP("email") && await check_in_SP("password")){
      print("case 1");
      //userLogin(String url, String email, String password)
      String password = await read_from_SP("password");
      String email = await read_from_SP("email");
      String login_endpoint = "https://a1in1.com/GLC/user_log_in.php?password="+password+"&email="+email;
      userLogin(login_endpoint, email, password);
    }else{
      print("case 2");
      Timer(
          Duration(seconds: 7),
              () => Navigator.of(context).pushReplacement(MaterialPageRoute(
              builder: (BuildContext context) => user_connect() ))
      );
    }
  }
  //final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  add_string_2_SP(key, value) async{
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setString(key, value);
  }

  read_from_SP(key) async{
    SharedPreferences pref = await SharedPreferences.getInstance();
    String content = pref.getString(key);
    return content;
  }

  check_in_SP (key) async{
    SharedPreferences pref = await SharedPreferences.getInstance();
    bool content = pref.containsKey(key);
    return content;
  }

  Future userLogin(String url, String email, String password) async {
  //var whereTo = false;
  return http.get(Uri.parse(url)).then((http.Response response) {
    final int statusCode = response.statusCode;

    if (statusCode < 200 || statusCode > 400) {
      throw new Exception("Error while fetching data");
    }else if (response.body != ""){
      var json_received = json.decode(response.body);
      if ((response.body).contains("status")){
        if (json_received["status"] == "true"){
            Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (BuildContext context) => first_sides() ));
        }
      }
    }
    //return whereTo;
  });

}
  
  @override
  void initState() {
    user_stands();
    super.initState();
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

