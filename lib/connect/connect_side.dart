//import 'dart:html';

import 'package:flutter/material.dart';


class coonect_page extends StatefulWidget {
  coonect_page({Key key, this.title}) : super(key: key);

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

class _MyHomePageState extends State<coonect_page> {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: pure_,
      body: Container(
        child: ListView.builder(
          //scrollDirection: Axis.vertical,
          itemCount: 7,
          itemBuilder: (BuildContext context, int){
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.red.withOpacity(0.2),
                  //borderRadius: BorderRadius.circular(12),
                  //would drop an error...
                  border: Border(
                    left: BorderSide(
                      color: red_color,
                      width: 5,
                    )
                  ),

                ),
                height: 130,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children : <Widget>[
                    Expanded(child: 
                      Padding(
                        padding: EdgeInsets.fromLTRB(20, 10, 10, 15),
                        child:  Text("The grace and mercy of our Lord and saviour Jesus christ rest with you all in the power of the saved Lord. The power of grace."),
                      )
                    ),

                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text("-GLC(@GreatLightChurch) January 2021"),
                    ),
                  ]
                )
              ),
            );
          }
        ),
      )
    );
  }
}
