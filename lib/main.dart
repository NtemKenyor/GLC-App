import 'dart:async';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'intro.dart';
import 'others/user_part.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart';
import 'dart:convert';
import 'package:GLC/sliders.dart';

void main() => runApp(MyApp());


class Post {
  final String email;
  //final int id;
  final String password;
  final String token; final String refresh_token;

  Post({this.email, this.password, this.token, this.refresh_token});

  factory Post.fromJson(Map json) {
    return Post(
      //userId: json['userId'],
      //email: json['email'],
      //password: json['password'],
      token: json['token'],
      refresh_token: json['refresh'],
    );
  }

  Map toMap() {
    var map = new Map();
    map["email"] = email;
    map["password"] = password;
    //map["password2"] = password2;

    return map;
  }
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'GLC London',
      theme: ThemeData(
        //primaryColor: Color(0xFF3eBACE),
        primaryColor: Colors.blue[700],
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
  static final Login_url = 'https://app.glclondon.church/api/auth/login/';
  
  firstTimer() async {
    String setValue = "seen";
    if (await check_in_SP("slide_screens") == false) {
        add_string_2_SP("slide_screens", setValue);
        Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (BuildContext context) => sliderApp()));
    }else{
      if (await read_from_SP("slide_screens") == setValue) {
        user_stands();
      }else{
        add_string_2_SP("slide_screens", setValue);
        Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (BuildContext context) => sliderApp()));
      }
    }
  }
  user_stands() async {
    if(await check_in_SP("email") && await check_in_SP("password")){
      print("case 1");
      //userLogin(String url, String email, String password)
      String password = await read_from_SP("password");
      String email = await read_from_SP("email");
      //String login_endpoint = "https://a1in1.com/GLC/user_log_in.php?password="+password+"&email="+email;
      bool loggedIn = await userLogin(Login_url, email, password);
      if (loggedIn == false) {
        Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (BuildContext context) => user_connect() ));
      }
    }else{
      print("case 2");
      Timer(
          Duration(seconds: 5),
              () => /* Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (BuildContext context) => sliderApp())) */
              Navigator.of(context).pushReplacement(MaterialPageRoute(
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

  check_in_SP(key) async{
    SharedPreferences pref = await SharedPreferences.getInstance();
    bool content = pref.containsKey(key);
    return content;
  }

void divert() {
  Navigator.of(context).pushReplacement(MaterialPageRoute(
  builder: (BuildContext context) => user_connect()));

  /* Navigator.of(context).pushReplacement(MaterialPageRoute(
  builder: (BuildContext context) => sliderApp())); */
}

  int timeout = 80;
  Future userLogin(String url, String email, String password) async {
    Map maper = Post(email: email, password: password).toMap();
    bool ret = false;
    try {
          Response response = await post(
            Uri.parse(url),
            body: maper,
          ).timeout(Duration(seconds: timeout));
        final int statusCode = response.statusCode;
        if (statusCode < 200 || statusCode > 400) {
          //print("here ok ok ok ");
          divert();

        }else if (response.body != ""){
          var json_received = jsonDecode(response.body);
          print(json_received);
          if ((response.body).contains("status")){
            if (json_received["status"] == "true"){
              ret = true;
              print(json_received["msg"]);
              //display_result(json_received["msg"]);
              bool email_sta = await check_in_SP("email");
              bool pass_sta = await check_in_SP("password");
              if( email_sta == false && pass_sta == false  ){
                add_string_2_SP("email", email);
                add_string_2_SP("password", password);
                add_string_2_SP("token", json_received["token"]);
                add_string_2_SP("refreshToken", json_received["refresh"]);
              }else{
                add_string_2_SP("token", json_received["token"]);
                add_string_2_SP("refreshToken", json_received["refresh"]);
              }
              if (await check_in_SP("email") && await check_in_SP("token")){
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder: (BuildContext context) => first_sides()));
              }
            }else if(json_received["status"] == "false"){
              //print(json_received["msg"]);
              divert();
              //display_result(json_received["msg"]);
            }
            //display_result(error_gotten);
            //print(error_gotten);
          }else{
            //print("here jiokm jkio ");
            divert();
          }
        }else{
          //print("yeah is the day of the goood");
          divert();
        }
    } on TimeoutException catch (e) {
      print("divert from timeout " );
      print(e);
      divert();
    } on SocketException catch (e) {
      print("divert based on socket error " );
      print(e);
      divert();
    } on Error catch (e) {
      print("divert based on general error" );
      print(e);
      divert();
    }
    

    
    //print("Could not reach here");
    return ret;
    //return json_received;
}

  
  @override
  void initState() {
    //user_stands();
    firstTimer();
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
            Image.asset(
              "assets/glc logo 1.png", width: 185, height: 185,
              //colorBlendMode: BlendMode.color,
              //color: Color.fromRGBO(242, 133, 56, 1),
              color: Colors.orange,
            ),
            CircularProgressIndicator(strokeWidth: 5, backgroundColor: Colors.blue[700],),
          ],
        )
      ),
    );
  }
}

