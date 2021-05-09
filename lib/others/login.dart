//import 'dart:html';
import 'dart:io';

import 'package:GLC/intro.dart';
import 'package:GLC/utils/pallet.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:async';

//import 'package:path_provider/path_provider.dart';
//import 'package:path';
import 'package:shared_preferences/shared_preferences.dart';

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

class LoginPage extends StatefulWidget {
  LoginPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<LoginPage> {
  int _counter = 0;
  int _selectedIndex = 0;

  //Color yellow = Color(0xFFC50C);
  Color yellow_ = Color.fromRGBO(255, 197, 12, 1);

  //Color red = Color(0xF15922);
  Color red_color = Color.fromRGBO(241, 89, 34, 1);

  //Color bright = Color(0xC4C4C4);
  Color bright_ = Color.fromRGBO(196, 196, 196, 1);

  //Color dark = Color(0x776666);
  Color dark_ = Color.fromRGBO(119, 102, 102, 1);

  //Color.fromRGBO(255, 255, 255, 1)
  Color pure_ = Color.fromRGBO(255, 255, 255, 1);

  //Colors background_colors = Color.fromRGBO(254, 254, 254, 1);

  String the_msg = "";

  Function display_result(text_) {
    setState(() {
      the_msg = text_;
    });
  }

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

/*   Function read_from_file(path){
    File(path).readAsString().then((String contents) {
      return contents;
    });
  }

  void write_to_file(path, write_this) async{
    var file = await File(path).writeAsString(write_this);
  }

  Future<String> read_from_assets(path) async {
    return await rootBundle.loadString(path);
  }

  void write_to_assets(path, write_this) async{
    //await 
  } */

/*   Future<String> get _localPath async{
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  void write_to_file(path, write_this) async{
    var file = await File(path).writeAsString(write_this);
  }

  Future<String> read_from_assets(path) async {
    return await rootBundle.loadString(path);
  } */

  void return_back() async {
    display_result("Loading");
    String email = email_.text;
    String password = password_.text;

    if (email != "" && password != "") {
      //String login_endpoint = "https://a1in1.com/GLC/user_log_in.php?password="+password+"&email="+email;
      userLogin(Login_url, email, password);
    } else {
      display_result("All fields are required.");
    }
  }

  Future userLogin(String url, String email, String password) async {
    Map maper = Post(email: email, password: password).toMap();
    return http
        .post(
      Uri.parse(url),
      body: maper,
    )
        .then((http.Response response) async {
      final int statusCode = response.statusCode;

      if (statusCode < 200 || statusCode > 400) {
        throw new Exception("Error while fetching data");
      } else if (response.body != "") {
        var json_received = json.decode(response.body);
        print(json_received);
        if ((response.body).contains("status")) {
          if (json_received["status"] == "true") {
            print(json_received["msg"]);
            display_result(json_received["msg"]);
            bool email_sta = await check_in_SP("email");
            bool pass_sta = await check_in_SP("password");
            if (email_sta == false && pass_sta == false) {
              add_string_2_SP("email", email);
              add_string_2_SP("password", password);
              add_string_2_SP("token", json_received["token"]);
              add_string_2_SP("refreshToken", json_received["refresh"]);
            }
            //add_string_2_SP(key, value)  //read_from_SP(key) //check_in_SP(key)

            Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder: (BuildContext context) => HomePage()));
          } else if (json_received["status"] == "false") {
            print(json_received["msg"]);
            display_result(json_received["msg"]);
          }
          //display_result(error_gotten);
          //print(error_gotten);
        }
      } else {
        display_result("Connection Problem: Try Again later.");
      }
      //return json_received;
    });
  }

  static final Login_url = 'https://app.glclondon.church/api/auth/login/';
  TextEditingController email_ = TextEditingController();
  TextEditingController password_ = TextEditingController();
  bool keepMeLoggedIn = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: bright_,
        body: Container(
          width: double.infinity,
          decoration:
          BoxDecoration(color: pure_, borderRadius: BorderRadius.circular(15)),
          child: Center(
            child: ListView(
              children: <Widget>[
                Column(children: <Widget>[
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Text("Sign in to continue",
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 18, color: Colors.grey))),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                      maxLines: 1,
                      controller: email_,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                          suffixIcon: Icon(Icons.person_outline,
                              color: Colors.grey.shade400),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20.0),
                              borderSide: BorderSide(
                                  color: Colors.grey.shade400)),
                          hintText: "Email",
                          hintStyle: TextStyle(color: Colors.grey.shade400))),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                      maxLines: 1,
                      controller: password_,
                      keyboardType: TextInputType.visiblePassword,
                      decoration: InputDecoration(
                          suffixIcon: Icon(Icons.remove_red_eye,
                              color: Colors.grey.shade400),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20.0),
                              borderSide: BorderSide(
                                  color: Colors.grey.shade400)),
                          hintText: "Password",
                          hintStyle: TextStyle(color: Colors.grey.shade400))),
                  Text(
                    the_msg,
                    style: TextStyle(
                      color: Colors.red,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Checkbox(
                            value: keepMeLoggedIn,
                            onChanged: (newValue) {
                              setState(() {
                                keepMeLoggedIn = newValue;
                              });
                            },
                          ),
                          Text('Keep Me Logged In', style:TextStyle(color:Colors.grey, fontSize:12))

                        ],
                      ),
                      Text("Forgot Password?", style: TextStyle(
                          color: Pallet.primaryColor,
                          fontSize: 14,
                          fontWeight: FontWeight.w700))
                    ],
                  ),

                  Container(
                    margin: EdgeInsets.symmetric(vertical: 20),
                    padding: EdgeInsets.all(5),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: Pallet.primaryColor,
                    ),
                    child: FlatButton(
                        onPressed: return_back,
                        child: Text(
                          "LOG IN",
                          style: TextStyle(
                              fontWeight: FontWeight.w800,
                              color: Colors.white,
                              fontSize: 16),
                        )),
                  )
                ]),
              ],

            ),)
          ,
        )
    );
  }
}
