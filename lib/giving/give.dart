//import 'dart:html';

import 'package:flutter/material.dart';


class give_page extends StatefulWidget {
  give_page({Key key, this.title}) : super(key: key);

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

class _MyHomePageState extends State<give_page> {
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
      body: ListView(
        scrollDirection: Axis.vertical,
        children: <Widget>[
          //Container(
            //Column(
              //children: <Widget>[

                Padding(
                  padding: const EdgeInsets.fromLTRB(14, 3, 14, 10),
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          //mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: bright_,
                                  borderRadius: BorderRadius.circular(12)
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: Icon(Icons.monetization_on, size: 27,),
                                )
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text("Offerings", style: TextStyle(fontWeight: FontWeight.w600, fontSize: 19),),
                            )
                          ],
                        ),
                      ),
                      Divider(thickness: 2,),


                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          //mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: bright_,
                                  borderRadius: BorderRadius.circular(12)
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: Icon(Icons.payment, size: 27,),
                                )
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text("Tithes", style: TextStyle(fontWeight: FontWeight.w600, fontSize: 19),),
                            )
                          ],
                        ),
                      ),
                      Divider(thickness: 2,),


                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          //mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: bright_,
                                  borderRadius: BorderRadius.circular(12)
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: Icon(Icons.attach_money, size: 27,),
                                )
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text("Others", style: TextStyle(fontWeight: FontWeight.w600, fontSize: 19),),
                            )
                          ],
                        ),
                      ),
                      Divider(thickness: 2,),


                    ]
                  ),
                ),


                Column(
                  children: <Widget>[
                    Row(children: <Widget>[

                      Expanded(flex: 350, 
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text("I Kor. 18:8", style: TextStyle(fontWeight: FontWeight.w500,),),
                        )
                      ),
                      Expanded(flex: 650,
                       child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text("Love never fails. You know the story of adam and eve in the garden of edem. Nothing is free except God's love. So thank him today.", 
                            style: TextStyle(fontWeight: FontWeight.w500,),),
                        )
                      ),
                    ],),

                    Divider(thickness: 3),

                    Column(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(2.0),
                          child: Text("Account Number", style: TextStyle(fontWeight: FontWeight.w800, fontSize: 19),),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(2.0),
                          child: Text("GTB - 0125678900", style: TextStyle(fontSize: 16),),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(2.0),
                          child: Text("Access Bank - 0125678900", style: TextStyle(fontSize: 16),),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(2.0),
                          child: Text("Sterile Bank - 0125678900", style: TextStyle(fontSize: 16),),
                        ),
                      ],
                    ),

                    Divider(thickness: 3),
                  ]
                )
            //  ]
           // ),
          //),
        ],
      )
    );
  }
}
