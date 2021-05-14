//import 'dart:html';
import 'dart:convert';
import 'package:flutter/rendering.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:GLC/webview_screen.dart';
import 'package:GLC/generals.dart';
import 'package:GLC/intro.dart';

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
          bool registerComplete = await userRegister(CREATE_POST_URL, mapper);
          if (registerComplete) {
            bool email_sta = await check_in_SP("email");
            bool pass_sta = await check_in_SP("password");
            if( email_sta == false && pass_sta == false ){
                add_string_2_SP("email", email);
                add_string_2_SP("password", password);
                add_string_2_SP("checkValue", "true");
            }
            userLogin(Login_url,  mapper);
          }
        }else{
          display_result(" Passwords do not match. ");
        }
        
      }else{
        display_result("All Field are required.");
      }
  }

  
Future userLogin(String url, maper) async {
  //Map maper = Post(email: email, password: password).toMap();
  return http.post(
    Uri.parse(url),
    body: maper,
  ).then((http.Response response) async {
    final int statusCode = response.statusCode;
    
    if (statusCode < 200 || statusCode > 400) {
      display_result(" Problem connecting to the Server with this Credentials");
      //throw new Exception("Error while fetching data");
    }else if (response.body != ""){
      var json_received = json.decode(response.body);
      print(json_received);
      if ((response.body).contains("status")){
        if (json_received["status"] == "true"){
          //print(json_received["msg"]);
          display_result(json_received["msg"]);
          add_string_2_SP("token", json_received["token"]);
          add_string_2_SP("refreshToken", json_received["refresh"]);
  //add_string_2_SP(key, value)  //read_from_SP(key) //check_in_SP(key)

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


  Future userRegister<bool>(String url, mrMap) async {
    var sendMeBck = false;
    http.Response response = await http.post(Uri.parse(url), body: mrMap,);
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

          //Since the Sign_up is successful, lets sign-in the user.
          sendMeBck = true;

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
    
    return sendMeBck;
}

  static final CREATE_POST_URL = 'https://app.glclondon.church/api/auth/register/';
  static final Login_url = 'https://app.glclondon.church/api/auth/login/';
  TextEditingController emailer = TextEditingController();
  TextEditingController password_1 = TextEditingController();
  TextEditingController password_2 = TextEditingController();
  bool visiblityChecks = true;
  


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
                 /*  SizedBox(
                    height: 50,
                  ), */
                  /* Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(width: 2, color: Colors.black,)
                    ),
                    child: IconButton(iconSize: 70, icon: Icon(Icons.person), onPressed: null),
                  ), */
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
                    padding: const EdgeInsets.all(14.0),
                    child: Text(
                      //"Fill your details or continue with social media",
                      "Please, Fill your details below",
                      style: TextStyle(
                        fontSize: 17,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),

                  Padding(
                    padding: EdgeInsets.fromLTRB(17, 9, 17, 9),
                    child: TextFormField(
                      maxLines: 1,
                      controller: emailer,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        hintText: "Email Address",
                        suffixIcon: Icon(Icons.email_outlined),
                        border:OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors. white, width: 2.0),
                          borderRadius: BorderRadius. circular(15.0),
                        ),
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
                    child: TextFormField(
                      maxLines: 1,
                      controller: password_1,
                      keyboardType: TextInputType.visiblePassword,
                      obscureText: visiblityChecks,
                      decoration: InputDecoration(
                        hintText: "Password",
                        suffixIcon: IconButton(
                          onPressed: () {
                              print("the checks");
                              setState(() {
                                //this would toggle the visiblity from faslse to true and verse versa
                                visiblityChecks = !visiblityChecks;

                              });
                            }, 
                            icon: new Icon( (visiblityChecks) ? Icons.visibility_off : Icons.visibility ),
                          ),
                        border:OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors. white, width: 2.0),
                          borderRadius: BorderRadius. circular(15.0),
                        ),
                      )
                    ),
                  ),

                  Padding(
                    padding: EdgeInsets.fromLTRB(17, 9, 17, 9),
                    child: TextFormField(
                      maxLines: 1,
                      controller: password_2,
                      keyboardType: TextInputType.visiblePassword,
                      obscureText: visiblityChecks,
                      decoration: InputDecoration(
                        hintText: "Repeat Password",
                        suffixIcon: IconButton(
                          onPressed: () {
                              setState(() {
                                //this would toggle the visiblity from faslse to true and verse versa
                                visiblityChecks = !visiblityChecks;
                              });
                            }, 
                            icon: new Icon( (visiblityChecks) ? Icons.security : Icons.remove_red_eye_outlined ),
                          ),
                        border:OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors. white, width: 2.0),
                          borderRadius: BorderRadius. circular(15.0),
                        ),
                      )
                    ),
                  ),

                  Center(
                    child: Text(
                      the_msg,
                      style: TextStyle(
                        color: Colors.red,
                      ),
                    ),
                  ),


                  Padding(
                    padding: const EdgeInsets.fromLTRB(9.0, 31, 9.0, 21),
                    child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        gradient: LinearGradient(
                          colors: <Color>[Colors.orange[400], Colors.orange[500], Colors.orange[700]]
                        ),
                      ),
                      child: TextButton(
                        onPressed: return_back, 
                        child: Text(
                          "SIGN UP",
                          style: TextStyle( fontWeight: FontWeight.w800, color: Colors.white ),
                        )
                      ),
                    ),
                  ),


                  /* Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(" ~ or Continue with ~ "),
                  ),

                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            height: 62,
                            width: 62,
                            decoration: BoxDecoration(
                              //borderRadius: BorderRadius.circular(34),
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                image: AssetImage("assets/Google.jpg"),
                              )
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            height: 62,
                            width: 62,
                            decoration: BoxDecoration(
                              //color: Colors.amberAccent,
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                image: AssetImage("assets/Facebook.png"),
                              )
                            ),
                          ),
                        ),
                      ],
                    ),
                  ), */

                  Padding(
                    padding: const EdgeInsets.only(
                      left: 8.0,
                      right: 8.0,
                      top: 12.0,
                      bottom: 24.0,
                    ),
                    child: InkWell(
                      hoverColor: Colors.orange,
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                        builder: (BuildContext context) => GLCWebview(url: "https://a1in1.com/GLC/terms_and_agreement.php",)));
                      },
                      //"https://a1in1.com/GLC/terms_and_agreement.php"
                      child: Wrap(
                        alignment: WrapAlignment.center,
                        children: [
                          Text(
                            "By continuing you confirm that you agree with our ", 
                            textAlign: TextAlign.center,
                          ),

                          Text(
                            "Terms and Conditions", 
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ],
                      ),
                    ),
                    
                    
                    
                  ),
                ]
              ),
            ],
          ),
        ),
      )
    );
  }
}
