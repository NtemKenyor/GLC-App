//import 'dart:html';

import 'package:GLC/others/user_part.dart' hide user_connect;
import 'package:flutter/material.dart';
import 'connect/connect.dart';
import 'ui/donations/screens/giving_page.dart';
import 'home_page/home.dart';
import 'package:GLC/ui/media/media_republic.dart';
import 'watch/anything_video.dart';
import 'others/user_part.dart';
import 'events/all_events.dart';
import 'prayer/prayer_request.dart';
import 'package:shared_preferences/shared_preferences.dart';

/* void main() {
  runApp(MyApp());
} */

class _Intro_MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'GLC App',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
        // This makes the visual density adapt to the platform that you run
        // the app on. For desktop platforms, the controls will be smaller and
        // closer together (more dense) than on mobile platforms.
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: HomePage(title: 'The GLC Church'),
    );
  }
}

class HomePage extends StatefulWidget {
  HomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<HomePage> {
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
  Color background_color = Color.fromRGBO(196, 196, 196, 1);


  void _onItemTapped(int where_index){
    setState(() {
      if (where_index != 0 ){
        background_color = Color.fromRGBO(255, 255, 255, 1);
      }else{
        background_color = Color.fromRGBO(196, 196, 196, 1);
      }
      //background_color = Color.fromRGBO(255, 255, 255, 1);
      _selectedIndex = where_index;
      
    });
  }
  
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  List<Widget> tabs_show_side = [
    home_page(),
    media_Republic(),
    all_videos(),
    give_page(),
    ConnectPage(),
  ];

  read_from_SP(key) async{
    SharedPreferences pref = await SharedPreferences.getInstance();
    String content = pref.getString(key);
    return content;
  }

  getMeOut() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    //bool state = await pref.clear();
    bool state = await pref.remove("email");
    bool pass = await pref.remove("password");
    if (state == true && pass == true){
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (BuildContext context) => user_connect() ),
        (Route<dynamic> route ) => false
      );
    }
  }

  userSide() async {
    String email_ = await read_from_SP("email");
    showDialog(
      context: context, 
      builder: (BuildContext context){
        return Scaffold(
          body: Center(
            child: Container(
              height: 220,
              decoration: BoxDecoration(
                color: Colors.indigo,
                borderRadius: BorderRadius.circular(21),
              ),
              
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Icon(Icons.person, size: 42,),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text("Hello, You are logged in as " + email_  ,
                      style: TextStyle(
                        fontSize: 21,
                      ),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding: EdgeInsets.all(9),
                    child: TextButton(
                      onPressed: getMeOut, 
                      child: Text("Logout"),
                    ),
                  )
                  
                ]
              ),
            ),
          ),
        );
      }
    );
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      backgroundColor: bright_,
      key: _scaffoldKey,
      drawer: Drawer(
          child: Container(
          //width: 300,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(17)
          ),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(8.0, 40, 8.0, 10),
              child: Column(
                //Navigator.of(context).pop();
                children: <Widget>[
                  Padding(
                  padding: EdgeInsets.fromLTRB(4, 10, 4, 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      IconButton(
                        icon: Icon(Icons.arrow_back, color: dark_,), 
                        onPressed: (){
                          Navigator.of(context).pop();
                        },
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Image.asset("assets/glc logo 1.png", 
                          width: 120, 
                          height: 55,
                          color: Colors.orange,
                        ),
                      ),
                      
                      CircleAvatar(backgroundColor: Colors.white),
                    ]
                  ),
                ),

                  Padding(
                    padding: const EdgeInsets.fromLTRB(1, 10, 1, 10),
                    child: Container(
                      child: Row(
                        //mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          FlatButton.icon(
                            onPressed: (){
                              _onItemTapped(0);
                              Navigator.of(context).pop();
                              /* Navigator.of(context).pop();

                              Navigator.of(context).push(MaterialPageRoute(
                              builder: (BuildContext context) => test_api())); */
                              //Navigator.of(context).pop();
                            }, 
                            icon: Container(
                              decoration: BoxDecoration(
                                color: bright_,
                                borderRadius: BorderRadius.circular(12)
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Icon(Icons.home),
                              )
                            ), 
                            label: Text("Home")
                          ),

                          IconButton(icon: Icon(Icons.arrow_forward_ios, color: bright_,), onPressed: null)
                        ]
                      ),
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.fromLTRB(1, 10, 1, 10),
                    child: Container(
                      child: Row(
                        //mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          FlatButton.icon(
                            onPressed: (){
                              _onItemTapped(1);
                              Navigator.of(context).pop();
                            }, 
                            icon: Container(
                              decoration: BoxDecoration(
                                color: bright_,
                                borderRadius: BorderRadius.circular(12)
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Icon(Icons.perm_camera_mic),
                              )
                            ), 
                            label: Text("Media")
                          ),

                          IconButton(icon: Icon(Icons.arrow_forward_ios, color: bright_,), onPressed: null)
                        ]
                      ),
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.fromLTRB(1, 10, 1, 10),
                    child: Container(
                      child: Row(
                        //mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          FlatButton.icon(
                            onPressed: (){
                              _onItemTapped(2);
                              Navigator.of(context).pop();
                            }, 
                            icon: Container(
                              decoration: BoxDecoration(
                                color: bright_,
                                borderRadius: BorderRadius.circular(12)
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Icon(Icons.live_tv),
                              )
                            ), 
                            label: Text("Watch Live")
                          ),

                          IconButton(icon: Icon(Icons.arrow_forward_ios, color: bright_,), onPressed: null)
                        ]
                      ),
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.fromLTRB(1, 10, 1, 10),
                    child: Container(
                      child: Row(
                        //mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          FlatButton.icon(
                            onPressed: (){
                              _onItemTapped(3);
                              Navigator.of(context).pop();
                            }, 
                            icon: Container(
                              decoration: BoxDecoration(
                                color: bright_,
                                borderRadius: BorderRadius.circular(12)
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Icon(Icons.payment),
                              )
                            ), 
                            label: Text("Giving")
                          ),

                          IconButton(icon: Icon(Icons.arrow_forward_ios, color: bright_,), onPressed: null)
                        ]
                      ),
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.fromLTRB(1, 10, 1, 10),
                    child: Container(
                      child: Row(
                        //mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          FlatButton.icon(
                            onPressed: (){
                              Navigator.of(context).pop();
                              Navigator.of(context).push(MaterialPageRoute(
                              builder: (BuildContext context) => Prayer()));
                              //Navigator.of(context).pop();
                            }, 
                            icon: Container(
                              decoration: BoxDecoration(
                                color: bright_,
                                borderRadius: BorderRadius.circular(12)
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Icon(Icons.notifications,),
                              )
                            ), 
                            label: Text("Prayer Request")
                          ),

                          IconButton(icon: Icon(Icons.arrow_forward_ios, color: bright_,), onPressed: null)
                        ]
                      ),
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.fromLTRB(1, 10, 1, 10),
                    child: Container(
                      child: Row(
                        //mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          FlatButton.icon(
                            onPressed: (){
                              Navigator.of(context).pop();
                              Navigator.of(context).push(MaterialPageRoute(
                              builder: (BuildContext context) => EventsGLCLondon()));
                            }, 
                            icon: Container(
                              decoration: BoxDecoration(
                                color: bright_,
                                borderRadius: BorderRadius.circular(12)
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Icon(Icons.event),
                              )
                            ), 
                            label: Text("Events")
                          ),

                          IconButton(icon: Icon(Icons.arrow_forward_ios, color: bright_,), onPressed: null)
                        ]
                      ),
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.fromLTRB(1, 10, 1, 10),
                    child: Container(
                      child: Row(
                        //mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          FlatButton.icon(
                            onPressed: (){
                              Navigator.of(context).pop();
                              Navigator.of(context).push(MaterialPageRoute(
                              builder: (BuildContext context) => user_connect()));
                            }
                              ,
                            icon: Container(
                              decoration: BoxDecoration(
                                color: bright_,
                                borderRadius: BorderRadius.circular(12)
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Icon(Icons.person_add),
                              )
                            ), 
                            label: Text("Log In / Log Out")
                          ),

                          IconButton(icon: Icon(Icons.arrow_forward_ios, color: bright_,), onPressed: null)
                        ]
                      ),
                    ),
                  ),
                ]
              ),
            ),
          ),
      ),
      appBar: AppBar(
        //leading: Icon(Icons.menu),
        automaticallyImplyLeading: false,
        elevation: 0,
        backgroundColor: background_color,
        title: Padding(
          padding: EdgeInsets.fromLTRB(4, 10, 4, 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              IconButton(
                icon: Icon(Icons.menu, color: dark_,), 
                onPressed: (){
                  _scaffoldKey.currentState.openDrawer();
                },
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image.asset("assets/glc logo 1.png", width: 120, height: 55,),
              ),
              IconButton(
                onPressed: ()=> {userSide()},
                icon: Icon(Icons.person, ),
                color: dark_,
              )
            ]
          ),
        )
      ),

      body: Container(
        child: tabs_show_side[_selectedIndex]
      ),
      
    bottomNavigationBar:  BottomNavigationBar(
      backgroundColor: Colors.blue[800],
      //elevation: 32,
      items: <BottomNavigationBarItem>[
      BottomNavigationBarItem(
        backgroundColor: Colors.white,
        title: Text("Home", 
          style: TextStyle(
            color: (_selectedIndex == 0) ? red_color :  Colors.black,
          )
        ),
        icon: Icon(
            Icons.home,
            size: 30,
            color: (_selectedIndex == 0) ? red_color :  Colors.black,
        ),
      ),

      BottomNavigationBarItem(
            //backgroundColor: Color.fromRGBO(45, 56, 123, 1.0),
            title: Text("Media", 
            style: TextStyle(
              color: (_selectedIndex == 1) ? red_color :  Colors.black,
            )),
            icon: Icon(
                Icons.perm_media,
                size: 30,
                color: (_selectedIndex == 1) ? red_color : Colors.black,
            ),
          ),
          BottomNavigationBarItem(
            //backgroundColor: Color.fromRGBO(45, 56, 123, 1.0),
            title: Text("Watch Live", style: TextStyle(
             color: (_selectedIndex == 2) ? red_color :  Colors.black,
            )),
            icon: Icon(
                Icons.tv,
                size: 30,
                color: (_selectedIndex == 2) ? red_color :  Colors.black,
            ),
          ),
          BottomNavigationBarItem(
            //backgroundColor: Color.fromRGBO(45, 56, 123, 1.0),
            title: Text("Giving", style: TextStyle(
              color: (_selectedIndex == 3) ? red_color :  Colors.black,
            )),
            icon: Icon(
                Icons.payment,
                size: 30,
                color: (_selectedIndex == 3) ? red_color :  Colors.black,
            ),
          ),

          BottomNavigationBarItem(
            title: Text("Connect", style: TextStyle(
              color: (_selectedIndex == 4) ? red_color :  Colors.black,
            )),
            icon: Icon(
                Icons.usb,
                size: 30,
                color: (_selectedIndex == 4) ? red_color :  Colors.black,
            ),
          ),

        ],
        currentIndex: _selectedIndex,
        selectedItemColor: red_color,
        showUnselectedLabels: true,
        //fixedColor: Colors.blue,
        onTap: _onItemTapped,
      ),
    );
  }
}
