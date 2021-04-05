//import 'dart:html';

import 'package:flutter/material.dart';


class glc_chat extends StatefulWidget {
  glc_chat({Key key, this.title}) : super(key: key);

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

class _MyHomePageState extends State<glc_chat> {
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
        //color: Colors.green,
        child: ListView.builder(
          itemCount: 7,
          itemBuilder: (BuildContext context, int){
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                color: bright_,
                height: 180,
                //the height would make this would make the design complete
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Expanded(
                      flex: 1500,
                      child: Container(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text("Sun"),
                            Text("11 - 15"),
                          ],
                        )
                      ),
                    ),
                    Expanded(
                      child: VerticalDivider(
                        width: 15,
                        thickness: 6,
                        color: Colors.red
                      ),
                    ),
                    Expanded(
                      flex: 8500,
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Column(
                          //mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: <Widget>[
                            Container(
                              child: Expanded(
                                flex: 200,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    Padding(
                                      padding: const EdgeInsets.all(3.0),
                                      child: ClipOval(
                                        //borderRadius: BorderRadius.circular(  ),
                                        child: Image.asset("assets/person.jpg", width: 60, height: 60, fit: BoxFit.fill,),
                                      ),
                                    ),
                                    Text("Tope Alao", style: (TextStyle(fontWeight: FontWeight.w700, fontSize: 16)),),
                                  ],
                                ),
                              )
                            ),
                            
                            Expanded(
                              flex: 600,
                              child: Column(
                                //scrollDirection: Axis.vertical,
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.fromLTRB(2.0, 8.0, 2.0, 8.0),
                                    child: Text("Write up and the other stuffs here htajbbbbb thejhet    jehjethejh enn jkejn jebjbjkbja,bvjabkbre ejjtgajnjnrbjrb..", maxLines: 4, textAlign: TextAlign.justify,),
                                  ),

                                  Text("15 Likes and 15 comments...", style: (TextStyle(fontWeight: FontWeight.w200,)),),
                                ],
                              )
                            ),

                            Expanded(
                              flex: 200,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[

                                  Row(
                                    children: <Widget>[
                                      FlatButton.icon(
                                        onPressed: null, 
                                        icon: Icon(Icons.thumb_up), 
                                        label: Text("Like")
                                      ),
                                    ]
                                  ),
                                  
                                  Row(
                                    children: <Widget>[
                                    FlatButton.icon(
                                        onPressed: null, 
                                        icon: Icon(Icons.mode_comment), 
                                        label: Text("Comment")
                                      ),
                                    ]
                                  )
                                ]
                              ),
                            )

                          ]
                        ),
                      ),
                    )
                  ],
                )
              ),
            );
          }
        )
      )
    );
  }
}
