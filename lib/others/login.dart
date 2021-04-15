//import 'dart:html';
import 'dart:io';

import 'package:GLC/intro.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'package:path_provider/path_provider.dart';
//import 'package:path';
import 'package:shared_preferences/shared_preferences.dart';

class Post {
  final String email;
  //final int id;
  final String password;
  final String token; final String refresh_token;

  Post({this.email, this.password, this.token, this.refresh_token});

  factory Post.fromJson(Map json) {
    return Post(
      //userId: json['userId'],
      email: json['email'],
      password: json['password'],
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

class log_in extends StatefulWidget {
  log_in({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<log_in> {
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
  Function display_result(text_){
    setState(() {
      the_msg = text_;
    });
  }

  /* add_string_2_SF(key, value) async{
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setString(key, value);
  } */

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

  
  Future<String> get _localPath async{
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  void write_to_file(path, write_this) async{
    var file = await File(path).writeAsString(write_this);
  }

  Future<String> read_from_assets(path) async {
    return await rootBundle.loadString(path);
  }

  void return_back() async {
    String email = email_.text;
    String password = password_.text;

    if(email != "" && password != ""){

      String login_endpoint = "https://a1in1.com/GLC/user_log_in.php?password="+password+"&email="+email;
      userLogin(login_endpoint);
    }else{
      display_result("All fields are required.");
    }
  }

  

  Future userLogin(String url) async {
  return http.get(url).then((http.Response response) {
    final int statusCode = response.statusCode;

    if (statusCode < 200 || statusCode > 400) {
      throw new Exception("Error while fetching data");
    }else if (response.body != ""){
      var json_received = json.decode(response.body);
      print(json_received);
      if ((response.body).contains("status")){
        if (json_received["status"] == "true"){
          print(json_received["msg"]);
          display_result(json_received["msg"]);

          Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (BuildContext context) => first_sides()));
        }else if(json_received["status"] == "false"){
          print(json_received["msg"]);
          display_result(json_received["msg"]);
        }
        //display_result(error_gotten);
        //print(error_gotten);
      }
    }else{
      display_result("Connection Problem: Try Again later.");
    }
    
    
    //return json_received;
  });
}
 static final Login_url = 'http://164.90.139.70/api/auth/login/';
  TextEditingController email_ = TextEditingController();
  TextEditingController password_ = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: bright_,
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: pure_,
          borderRadius: BorderRadius.circular(15)
        ),
        child: Center(
          child: ListView(
            children: <Widget>[
              Column(
                children:  <Widget> [
                  SizedBox(
                    height: 50,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(width: 2, color: Colors.black,)
                    ),
                    child: IconButton(iconSize: 70, icon: Icon(Icons.person), onPressed: null),
                  ),
                  Text("Log-in"),

                  Padding(
                    padding: EdgeInsets.fromLTRB(17, 9, 17, 9),
                    child: TextField(
                      maxLines: 1,
                      controller: email_,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        hintText: "Email Address",
                      )
                    ),
                  ),

                  Padding(
                    padding: EdgeInsets.fromLTRB(17, 9, 17, 9),
                    child: TextField(
                      maxLines: 1,
                      controller: password_,
                      keyboardType: TextInputType.visiblePassword,
                      decoration: InputDecoration(
                        hintText: "Password",
                        suffixIcon: Icon(Icons.remove_red_eye)
                      )
                    ),
                  ),

                  Text(
                    the_msg,
                    style: TextStyle(
                      color: Colors.red,
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.fromLTRB(9.0, 31, 9.0, 21),
                    child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all( width: 1)
                      ),
                      child: FlatButton(
                        onPressed: return_back, 
                        child: Text(
                          "LOG IN",
                          style: TextStyle( fontWeight: FontWeight.w800, ),
                        )
                      ),
                    ),
                  )


                ]
              ),
            ],
          ),
        ),
      )
    );
  }
}
