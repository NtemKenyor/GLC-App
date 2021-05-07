//import 'dart:html';
import 'dart:convert';
import 'package:GLC/utils/pallet.dart';
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

  Function display_result(text_) {
    setState(() {
      the_msg = text_;
    });
  }

  void return_back() async {
    String email, password, passwordRepeat;
    email = emailer.text;
    password = password_1.text;
    passwordRepeat = password_2.text;
    if (password != "" && email != "" && passwordRepeat != "") {
      if (password == passwordRepeat) {
        Map mapper =
            Post(email: email, password: password, password2: passwordRepeat)
                .toMap();
        userRegister(CREATE_POST_URL, mapper);
      } else {
        display_result(" Passwords do not match. ");
      }
    } else {
      display_result("All Field are required.");
    }
  }

  Future userRegister(String url, mrMap) async {
    return http
        .post(
      Uri.parse(url),
      body: mrMap,
    )
        .then((http.Response response) {
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
    });
  }

  static final CREATE_POST_URL =
      'https://app.glclondon.church/api/auth/register/';
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
            Column(children: <Widget>[

              Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Text("Fill your details or continue with social media",
                      textAlign: TextAlign.center,style:TextStyle(fontSize:18, color:Colors.grey ))),
              SizedBox(height: 10,),
              TextFormField(
                  maxLines: 1,
                  controller: emailer,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                      suffixIcon: Icon(Icons.person_outline,
                          color: Colors.grey.shade400),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.0),
                          borderSide: BorderSide(color: Colors.grey.shade400)),
                      hintText: "Name",
                      hintStyle: TextStyle(color: Colors.grey.shade400))),
              SizedBox(
                height: 10,
              ),
              TextFormField(
                  maxLines: 1,
                  controller: emailer,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                      suffixIcon:
                          Icon(Icons.mail_outline, color: Colors.grey.shade400),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.0),
                          borderSide: BorderSide(color: Colors.grey.shade400)),
                      hintText: "Email Address",
                      hintStyle: TextStyle(color: Colors.grey.shade400))),

              SizedBox(
                height: 10,
              ),
              TextFormField(
                  maxLines: 1,
                  controller: password_1,
                  keyboardType: TextInputType.visiblePassword,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.0),
                          borderSide: BorderSide(color: Colors.grey.shade400)),
                      hintText: "Password",
                      hintStyle: TextStyle(color: Colors.grey.shade400),
                      suffixIcon: Icon(Icons.remove_red_eye,
                          color: Colors.grey.shade400))),
              SizedBox(
                height: 10,
              ),

              TextField(
                  maxLines: 1,
                  controller: password_2,
                  keyboardType: TextInputType.visiblePassword,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.0),
                          borderSide: BorderSide(color: Colors.grey.shade400)),
                      hintText: " Repeat Password",
                      hintStyle: TextStyle(color: Colors.grey.shade400),
                      suffixIcon: Icon(Icons.remove_red_eye,
                          color: Colors.grey.shade400))),

              Text(
                the_msg,
                style: TextStyle(
                  color: Colors.red,
                ),
              ),

              SizedBox(
                height: 30,
              ),
              Container(
                padding: EdgeInsets.all(5),
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Pallet.primaryColor,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: FlatButton(
                    onPressed: return_back,
                    child: Text(
                      "SIGN UP",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w800,
                      ),
                    )),
              ),
              SizedBox(
                height: 30,
              ),
              Text(
                "Or continue With",
                style: TextStyle(
                  color: Colors.grey,
                  fontWeight: FontWeight.w800,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  InkWell(
                    onTap: (){

                    },
                    child: Container(
                      height: 50,
                      width: 50,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          image: DecorationImage(
                        image: AssetImage("assets/prayer.jpg"),
                        fit: BoxFit.cover,
                      )),
                    ),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  InkWell(
                    onTap: (){

                    },
                    child: Container(
                      height: 50,
                      width: 50,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          image: DecorationImage(
                        image: AssetImage("assets/prayer.jpg"),
                        fit: BoxFit.cover,
                      )),
                    ),
                  )
                ],
              ),

              SizedBox(height:20,),
              Padding(
                padding:EdgeInsets.all(10),
                child: RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    text: 'By continuing you confirm that you agree with our ',
                    style: TextStyle(fontSize: 16, color:Colors.grey),
                    children: <TextSpan>[
                      TextSpan(
                          text: 'Terms and Conditions',
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            decoration: TextDecoration.underline,
                          )),
                      // can add more TextSpans here...
                    ],
                  ),
                ),
              ),


            ]),
          ],
        ),
      ),
    ));
  }
}
