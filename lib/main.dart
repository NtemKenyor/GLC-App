import 'dart:async';
import 'package:GLC/ui/donations/data/payment_utils.dart';
import 'package:GLC/ui/intro_screen/screens/intro_screen.dart';
import 'package:GLC/widgets/splash_screen_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'intro.dart';
import 'others/user_part.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart';
import 'dart:convert';

//var isFirstTime;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // var prefs = await SharedPreferences.getInstance();
  // var boolKey = 'isFirstTime';
  // isFirstTime = prefs.getBool(boolKey) ?? true;

  runApp(ChangeNotifierProvider(
    create: (_) => PaymentProvider(),
    child: ScreenUtilInit(
        designSize: Size(392, 850),
      builder:()=>MaterialApp(
        debugShowCheckedModeBanner: false,
        home: //!isFirstTime ?
         MyApp()
              //: IntroductionScreen(prefs, boolKey),
      )
    ),
  ));
}

class Post {
  final String email;

  //final int id;
  final String password;
  final String token;
  final String refresh_token;

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
    return SplashScreen();
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

  user_stands() async {
    print("here");
    if (await check_in_SP("email") && await check_in_SP("password")) {
      print("case 1");
      //userLogin(String url, String email, String password)
      String password = await read_from_SP("password");
      String email = await read_from_SP("email");
      print(email);
      print(password);
      //String login_endpoint = "https://a1in1.com/GLC/user_log_in.php?password="+password+"&email="+email;
      userLogin(Login_url, email, password);
    } else {
      print("case 2");
      Timer(
          Duration(seconds: 7),
          () => Navigator.of(context).pushReplacement(MaterialPageRoute(
              builder: (BuildContext context) => AuthenticationPage())));
    }
  }

  //final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  add_string_2_SP(key, value) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setString(key, value);
  }

  read_from_SP(key) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String content = pref.getString(key);
    return content;
  }

  check_in_SP(key) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    bool content = pref.containsKey(key);
    return content;
  }

  divert() {
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (BuildContext context) => AuthenticationPage()));
  }

  Future userLogin(String url, String email, String password) async {
    Map maper = Post(email: email, password: password).toMap();
    return post(
      Uri.parse(url),
      body: maper,
    ).then((Response response) async {
      final int statusCode = response.statusCode;

      if (statusCode < 200 || statusCode > 400) {
        divert();
        //throw new Exception("Error while fetching data");
      } else if (response.body != "") {
        var json_received = jsonDecode(response.body);
        print(json_received);
        if ((response.body).contains("status")) {
          if (json_received["status"] == "true") {
            print(json_received["msg"]);
            //display_result(json_received["msg"]);
            bool email_sta = await check_in_SP("email");
            bool pass_sta = await check_in_SP("password");
            if (email_sta == false && pass_sta == false) {
              add_string_2_SP("email", email);
              add_string_2_SP("password", password);
              add_string_2_SP("token", json_received["token"]);
              add_string_2_SP("refreshToken", json_received["refresh"]);
            } else {
              add_string_2_SP("token", json_received["token"]);
              add_string_2_SP("refreshToken", json_received["refresh"]);
            }
            //add_string_2_SP(key, value)  //read_from_SP(key) //check_in_SP(key)

            Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder: (BuildContext context) => HomePage()));
          } else if (json_received["status"] == "false") {
            print(json_received["msg"]);
            divert();
            //display_result(json_received["msg"]);
          }
          //display_result(error_gotten);
          //print(error_gotten);
        }
      } else {
        divert();
        //display_result("Connection Problem: Try Again later.");
      }
      //return json_received;
    });
  }

  @override
  void initState() {
    user_stands();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print(MediaQuery.of(context).size.height);
    print(MediaQuery.of(context).size.width);
    return SplashWidget();

  }
}
