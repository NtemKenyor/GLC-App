//import 'dart:html';

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:http/http.dart';
//import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'dart:async';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class home_page extends StatefulWidget {
  home_page({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<home_page> {
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

  String today_verse = "";

  show_today_verse(verse, verse_content){
    return Container(
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
                child: Text(verse, 
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
                        child: Text(verse_content)
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
        );
  }

  static var picture_timer = Duration(seconds: 8);
  Widget the_moving_images = new Container(
    child: new Carousel(
      images: [
        new AssetImage('assets/person_1.png'),
        new AssetImage('assets/person_2.png'),
        new AssetImage('assets/person_3.png'),
        new AssetImage('assets/fitness.jpg'),
        new AssetImage('assets/blog_person.jpg'),
        new AssetImage('assets/old_man.jpg'),
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

    /* Future<String> get _localPath async{
      final directory = await getApplicationDocumentsDirectory();
      return directory.path;
    }

    void write_to_file(path, write_this) async{
      var file = await File(path).writeAsString(write_this);
    }

    Function read_from_file(path){
      File(path).readAsString().then((String contents) {
        return contents;
      });
    }
 */
    /* Future<String> read_from_loc(path) async {
      return await rootBundle.loadString(path);
    } */
Future Todays_verse() async {

  String url = "https://a1in1.com/GLC/todays_verse.php";


  return get(Uri.parse(url)).then((Response response) {
    final int statusCode = response.statusCode;

    print(statusCode);
    print(response.headers);
    print(response.body);
    
    if (statusCode < 200 || statusCode > 400) {
      throw new Exception("Error while fetching data");
    }else if (response.body != ""){
      var json_received = json.decode(response.body);
      print(json_received);
      if ((response.body).contains("status")){
        if (json_received["status"] == "true"){
          print(json_received["msg"]);
          return show_today_verse(json_received["verse"]["verse"], json_received["verse"]["scripture"]);
          
        }else if(json_received["status"] == "false"){
          setState(() {
            today_verse = json_received["msg"];
          });
        }
        //display_result(error_gotten);
        //print(error_gotten);
      }
    }else{
      
    }
    
    //return json_received;
  });
}
  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      backgroundColor: bright_,
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
          width: double.infinity,
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

          FutureBuilder(
            future: Todays_verse(),
            //we pass a BuildContext and an AsyncSnapshot object which is an
            //Immutable representation of the most recent interaction with
            //an asynchronous computation.
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Container(
                  child: snapshot.data,
                );
                //show_today_verse(verse, verse_content)
              } else if (snapshot.hasError) {
                return new Container(
                  child: Text(today_verse,
                    style: TextStyle(
                      color: Colors.red,
                    ),
                   )
                );
              }
              //return  a circular progress indicator.
              return CircularProgressIndicator();
              /* return new Container(
                decoration: BoxDecoration(
                  image: DecorationImage(image: AssetImage("assets/nuesa_background1.gif"), fit: BoxFit.fill)
                ),
              ); */
            },
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
                        ),
                  
/*  
                  Container(
                    height: MediaQuery.of(context).size.height,
                    child: ListView.builder(
                      itemCount: 7,
                      itemBuilder: (context, int){
                        return Padding(padding: EdgeInsets.all(12),
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
                        );
                      }
                    ),
                  ), */ 
                ],
              ),
            ), 
        ],
      ),
     
    );
  }
}
