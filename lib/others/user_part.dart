
import 'package:GLC/utils/pallet.dart';
import 'package:flutter/material.dart';
import 'sign_up.dart';
import 'login.dart';


class AuthenticationPage extends StatefulWidget {
  AuthenticationPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  __ createState() => __();
}

class __ extends State<AuthenticationPage> {
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

  /* void swap(int unused){
    double temp = mr_small;
    mr_small = mr_big;
    mr_big = temp;

  } */
  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    final tab = TabBar(
      onTap: (int unused){
        setState(() {
          double temp = mr_big;
          mr_big = mr_small;
          mr_small = temp;
          currentIndex =unused;

          Color upColor = Colors.blue[800];
          Color inColor = Colors.green[800];
          posColor = (posColor == upColor) ? inColor : upColor;
        });
      },
      labelColor: Colors.black,
        indicatorColor: Pallet.primaryColor,
      //indicatorColor: dark_,
      //unselectedLabelColor: Colors.black,
      labelStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold,),
      tabs: [
      Tab( 
        child: Text("Sign Up", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25, color: currentIndex !=0 ? Colors.grey: null),),
      ),
      Tab( 
        child: Text("Log in", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25, color: currentIndex ==0 ? Colors.grey:null),),
      )
    ]);

    return DefaultTabController(length: 2,
        child: SafeArea(
          child: Scaffold(
          backgroundColor: Color(0xFEFEFEFE),
          body: Container(
            padding:EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  height: 50,
                ),
                Container(
                  padding: EdgeInsets.all(7),
                  child: tab,
                ),
                SizedBox(height: 10,),
                SizedBox(height: 10,),
                Expanded(
                  child: Container(
                    child: TabBarView(
                      children: <Widget>[
                        SignUpPage(),
                        LoginPage(),
                        ]
                      ),
                  ),
                ),
              ]
            )
          )
      ),
        ),
    );
  }
}
