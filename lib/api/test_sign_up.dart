/* //import 'dart:html';

import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart';
//import 'package:dio/dio.dart';

class test_api extends StatefulWidget {
  test_api({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<test_api> {
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

/* 
Future create_user(email, password) async{
  var dio = Dio();
  var formdetails = FormData.fromMap({
      //'id': 101,
      'email': email,
      'password': password,
      'password2': password,
  });
  var response = await dio.post(
    'http://164.90.139.70',
    data: formdetails);

  //await http.post(
    //Uri.http('164.90.139.70', ''),
  if (response.statusCode == 200) {
    //return Album.fromJson(jsonDecode(response.body));
    return (response.data);
  } else {
    throw Exception('Failed to create Account.');
  }
} */

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: pure_,
      body: Container(
        width: double.infinity,
        color: Colors.blue,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            FutureBuilder (
              future: create_user("try@gmail.com", "trybaba_me"),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Text(snapshot.data);
                } else if (snapshot.hasError) {
                  return Text("${snapshot.error}");
                }

                return CircularProgressIndicator();
              },
            ),
          ],
        ),
      )
    );
  }
}
 */