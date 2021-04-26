//import 'dart:html';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'package:flutter/material.dart';

class Post {
  final String email;
  final String password;
  final String password2;

  Post({this.email, this.password, this.password2});

  factory Post.fromJson(Map json) {
    return Post(
      //userId: json['userId'],
      email: json['email'],
      password: json['password'],
      password2: json['password2'],
    );
  }

  Map toMap() {
    var map = new Map();
    map["email"] = email;
    map["password"] = password;
    map["password2"] = password2;

    return map;
  }
}

class sign_up extends StatefulWidget {
  sign_up({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<sign_up> {
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


  String the_msg = "  ";
  Function display_result(text_){
    setState(() {
      the_msg = text_;
    });
  }

  void return_back() async {
      String email, password, passwordRepeat;
      email = emailer.text;
      password = password_1.text;
      passwordRepeat = password_2.text;
      if (password != "" && email != "" && passwordRepeat != ""){
        if (password == passwordRepeat){
          Map mapper = Post(email: email, password: password, password2: passwordRepeat).toMap();
          userRegister(CREATE_POST_URL, mapper);
        }else{
          display_result(" Passwords do not match. ");
        }
        
      }else{
        display_result("All Field are required.");
      }
  }

  

  Future userRegister(String url, mrMap) async {
  return http.post(
    Uri.parse(url), 
    body: mrMap,
    ).then((http.Response response) {
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
    
  });
}

  static final CREATE_POST_URL = 'http://164.90.139.70/api/auth/register/';
  TextEditingController emailer = TextEditingController();
  TextEditingController password_1 = TextEditingController();
  TextEditingController password_2 = TextEditingController();
  


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: bright_,
      body: Container(
        decoration: BoxDecoration(
          color: pure_,
          borderRadius: BorderRadius.circular(15),
          //border: Border.all(color: Colors.teal, width: 5),
          
        ),

        width: double.infinity,
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
                  //Text("Please, Fill the Form"),

                  /* Padding(
                    padding: EdgeInsets.fromLTRB(17, 9, 17, 9),
                    child: TextField(
                      maxLines: 1,
                      decoration: InputDecoration(
                        hintText: "FullName",
                      )
                    ),
                  ), */

                  Padding(
                    padding: EdgeInsets.fromLTRB(17, 9, 17, 9),
                    child: TextField(
                      maxLines: 1,
                      controller: emailer,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        hintText: "Email Address",
                      )
                    ),
                  ),

                  /* Padding(
                    padding: EdgeInsets.fromLTRB(17, 9, 17, 9),
                    child: TextField(
                      maxLines: 1,
                      decoration: InputDecoration(
                        hintText: "Phone No",
                      )
                    ),
                  ), */

                  Padding(
                    padding: EdgeInsets.fromLTRB(17, 9, 17, 9),
                    child: TextField(
                      maxLines: 1,
                      controller: password_1,
                      keyboardType: TextInputType.visiblePassword,
                      decoration: InputDecoration(
                        hintText: "Password",
                        suffixIcon: Icon(Icons.remove_red_eye)
                      )
                    ),
                  ),

                  Padding(
                    padding: EdgeInsets.fromLTRB(17, 9, 17, 9),
                    child: TextField(
                      maxLines: 1,
                      controller: password_2,
                      keyboardType: TextInputType.visiblePassword,
                      decoration: InputDecoration(
                        hintText: "Repeat Password",
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
                          "SIGN UP",
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
