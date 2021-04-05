//import 'dart:html';

import 'package:flutter/material.dart';
import 'package:carousel_pro/carousel_pro.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
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
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

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

class _MyHomePageState extends State<MyHomePage> {
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
  

  //Color white = Color(0xFF)

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  void _onItemTapped(int where_index){
    //pass
  }
  
  static var picture_timer = Duration(seconds: 8);
  Widget the_moving_images = new Container(
    child: new Carousel(
      images: [
        new Image.asset('assets/person_1.png', fit: BoxFit.contain,),
        new Image.asset('assets/person_2.png', fit: BoxFit.contain),
        new Image.asset('assets/person_3.png', fit: BoxFit.contain),
        new Image.asset('assets/fitness.jpg', fit: BoxFit.contain),
        new Image.asset('assets/blog_person.jpg'),
        new Image.asset('assets/old_man.jpg'),
      ],
      autoplayDuration: picture_timer,
      animationCurve: Curves.easeInOutExpo,
      dotSize: 3.0,
      dotSpacing: 12.0,
      dotColor: Colors.lightGreenAccent,
      indicatorBgPadding: 2.0,
      dotBgColor: Colors.blueAccent.withOpacity(0.5),
      borderRadius: true,
      boxFit: BoxFit.cover,

    ),
  );

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
      appBar: AppBar(
        //leading: Icon(Icons.menu),
        elevation: 0,
        backgroundColor: bright_,
        title: Padding(
          padding: EdgeInsets.fromLTRB(4, 10, 4, 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Icon(Icons.menu),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: <Widget>[
                    Icon(Icons.do_not_disturb),
                    Text("GREAT LIGHT", style: TextStyle(fontSize: 10),),
                    Text("CHURCH", style: TextStyle(fontSize: 10),),
                  ]
                ),
              ),
              Icon(Icons.person)
            ]
          ),
        )
      ),
      //backgroundColor: yellow,
      body: ListView(
        scrollDirection: Axis.vertical,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.fromLTRB(4, 10, 4, 10),
            child: Text("Upcoming Events", style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),),
          ),

        Container(
          height: 160,
          child: Padding(
            padding: EdgeInsets.fromLTRB(5, 7, 5, 7),
            child: the_moving_images,
          )
        ),

            
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(17),
                color: pure_,
              ),
              
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: 30,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(23),
                      color: pure_,
                    ),
                    height: 130,
                    child: Column(
                      children: <Widget>[
                        Expanded(
                          flex: 200, 
                          child: Text(
                            "Today's Verse", 
                            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                          )
                        ),
                        Expanded(
                          flex: 800,
                            child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                            Expanded(
                              flex: 250, 
                              child: Text("I Cor. 10:8 -", 
                                style: TextStyle(fontWeight: FontWeight.bold,)
                            )),
                            Expanded(
                                flex: 750,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  //crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                
                                    Expanded(
                                      flex: 700,
                                      child: Text("Love never fails, But where there are prophecies, they will cease; where there aretongues, they will be stilled")
                                    ),
                                    Expanded(
                                        flex: 300,
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                                          children: <Widget>[
                                            Expanded(child: 
                                              FlatButton.icon(
                                                onPressed: null, 
                                                icon: Icon(Icons.thumb_up), 
                                                label: Text("Like")
                                              )
                                            ),
                                            Expanded(child: 
                                              FlatButton.icon(
                                                onPressed: null, 
                                                icon: Icon(Icons.share), 
                                                label: Text("Share")
                                              )
                                            ),
                                          ]
                                        ),
                                    )
                              ],),
                            )
                          ],),
                        ),
                        
                      ],),
                      ),
                  
                  SizedBox(
                    height: 30,
                  ),
                  Divider(thickness: 3, color: red_color,),
                  SizedBox(
                    height: 30,
                  ),

                  Text("Upcoming Events", style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),),

                  Padding(padding: EdgeInsets.all(12),
                    child: Container(
                      
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: pure_,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.5),
                            spreadRadius: 2,
                            blurRadius: 4,
                            offset: Offset(0,3),
                          )
                        ]
                      ),
                      child: Column(children: <Widget>[
                        ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Image.asset("assets/blog_1.png"),
                        ),
                        

                        Row(
                          children: <Widget>[
                            FlatButton.icon(onPressed: null, icon: Icon(Icons.calendar_today), 
                              label: Text("Mon, 16 Nov 2020")
                            ),

                            FlatButton.icon(onPressed: null, icon: Icon(Icons.access_time), 
                              label: Text("7:00 pm")
                            ),
                          ]
                        ),

                        Row(
                          children: <Widget>[
                            FlatButton.icon(onPressed: null, icon: Icon(Icons.send), 
                              label: Text("Timbuktu, Mali")
                            ),
                          ]
                        )
                      ],)
                    ),
                  )
                ],
              ),
            )         
        ],
      ),
      
    bottomNavigationBar:  BottomNavigationBar(
      backgroundColor: Colors.blue[800],
      //elevation: 32,
      items: <BottomNavigationBarItem>[
      BottomNavigationBarItem(
        backgroundColor: Colors.white,
        title: Text("Home", 
          style: TextStyle(
            color: (_selectedIndex == 0) ? Colors.white :  Colors.black,
          )
        ),
        icon: Icon(
            Icons.home,
            size: 30,
            color: (_selectedIndex == 0) ? yellow_ :  Colors.black,
        ),
      ),

      BottomNavigationBarItem(
            //backgroundColor: Color.fromRGBO(45, 56, 123, 1.0),
            title: Text("Media", 
            style: TextStyle(
              color: (_selectedIndex == 1) ? yellow_ :  Colors.black,
            )),
            icon: Icon(
                Icons.perm_media,
                size: 30,
                color: (_selectedIndex == 1) ? yellow_ : Colors.black,
            ),
          ),
          BottomNavigationBarItem(
            //backgroundColor: Color.fromRGBO(45, 56, 123, 1.0),
            title: Text("Watch Live", style: TextStyle(
             color: (_selectedIndex == 2) ? yellow_ :  Colors.black,
            )),
            icon: Icon(
                Icons.tv,
                size: 30,
                color: (_selectedIndex == 2) ? yellow_ :  Colors.black,
            ),
          ),
          BottomNavigationBarItem(
            //backgroundColor: Color.fromRGBO(45, 56, 123, 1.0),
            title: Text("Giving", style: TextStyle(
              color: (_selectedIndex == 3) ? yellow_ :  Colors.black,
            )),
            icon: Icon(
                Icons.payment,
                size: 30,
                color: (_selectedIndex == 3) ? yellow_ :  Colors.black,
            ),
          ),

          BottomNavigationBarItem(
            title: Text("Connect", style: TextStyle(
              color: (_selectedIndex == 4) ? yellow_ :  Colors.black,
            )),
            icon: Icon(
                Icons.usb,
                size: 30,
                color: (_selectedIndex == 4) ? yellow_ :  Colors.black,
            ),
          ),

        ],
        currentIndex: _selectedIndex,
        selectedItemColor: yellow_,
        showUnselectedLabels: true,
        //fixedColor: Colors.blue,
        onTap: _onItemTapped,
      ),
    );
  }
}
