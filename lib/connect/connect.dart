//import 'dart:html';

import 'package:flutter/material.dart';
import 'glc_room.dart';
import 'connect_side.dart';


class connect_page extends StatefulWidget {
  connect_page({Key key, this.title}) : super(key: key);

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

class _MyHomePageState extends State<connect_page> {
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
    final tab = TabBar(
      labelColor: red_color,
      //indicatorColor: dark_,
      unselectedLabelColor: Colors.black,
      labelStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold,),
      tabs: [
      Tab( text: "GLC Chat Room", ),
      Tab( text: "Coonect"),
    ]);

    return DefaultTabController(length: 2,
        child: Scaffold(
        backgroundColor: pure_,
        appBar: PreferredSize(
          child: Padding(
            padding: const EdgeInsets.all(2.0),
            child: Container(
              height: 200,
              padding: EdgeInsets.all(7),
              child: Card(
                elevation: 2,
                child: tab
              ),
            ),
          ), 
          preferredSize: Size(double.infinity, 80),
        ),
        body: TabBarView(
        children: <Widget>[
          glc_chat(),
          coonect_page(),
          //patient(),
          ]
        ),
        
        
      ),
    );
  }
}
