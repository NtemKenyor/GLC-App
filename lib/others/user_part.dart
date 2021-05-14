
import 'package:flutter/material.dart';
import 'sign_up.dart';
import 'login.dart';


class user_connect extends StatefulWidget {
  user_connect({Key key, this.title}) : super(key: key);

  final String title;

  @override
  __ createState() => __();
}

class __ extends State<user_connect> {
  double mr_small = 18;
  double mr_big = 25;
  Color posColor = Colors.blue[800];

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
      onTap: (int unused){
        setState(() {
          double temp = mr_big;
          mr_big = mr_small;
          mr_small = temp;

          Color upColor = Colors.blue[800];
          Color inColor = Colors.green[800];
          posColor = (posColor == upColor) ? inColor : upColor;
        });
      },
      indicatorColor: Color.fromRGBO(242, 133, 56, 1),
      labelColor: Colors.black,
      labelStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold,),
      tabs: [
      Tab( 
        child: Text("Sign up", style: TextStyle(fontWeight: FontWeight.bold, fontSize: mr_big),),
        
      ),
      Tab( 
        child: Text("Sign in", style: TextStyle(fontWeight: FontWeight.bold, fontSize: mr_small),),
      )
    ]);

    return DefaultTabController(length: 2,
        child: Scaffold(
        backgroundColor: Color(0xFEFEFEFE),
        appBar: 
        
        PreferredSize(
          child: Padding(
            padding: const EdgeInsets.all(2.0),
            child: Align(
              alignment: Alignment.center,
              child: Container(
                //color: Colors.amber,
                height: 60,
              ),
            ),
          ), 
          preferredSize: Size(double.infinity, 50),
        ),
        body: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Expanded(
                flex: 1300,
                child: Container(
                  //color: Colors.green,
                  padding: EdgeInsets.all(3),
                  child: tab,
                ),
              ),

              Expanded(
                flex: 8500,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(10.0, 1.0, 10.0, 2),
                  child: Container(
                    /* decoration: BoxDecoration(
                      boxShadow: [BoxShadow(
                      color: posColor, 
                      offset: Offset(1, 2), 
                      blurRadius: 3,
                      spreadRadius: 4,          
                    )],
                    ) , */
                    child: TabBarView(
                      children: <Widget>[
                        sign_up(),
                        log_in(),
                        ]
                      ),
                  ),
                ),
              ),
            ]
          )
        )        
      ),
    );
  }
}
