//import 'dart:html';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:http/http.dart';
//import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'dart:async';
import 'package:flutter/services.dart';
import 'package:share/share.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:GLC/others/user_part.dart';

class GLC_events {
  final int id;
  final String title, desc, imageUrl, venue, date, endTime, startTime;

  GLC_events({
    this.id,
    this.title,
    this.desc,
    this.venue,
    this.imageUrl,
    this.date,
    this.endTime,
    this.startTime
  });

  factory GLC_events.fromJson(Map<String, dynamic> jsonData) {
    return GLC_events(
      id: jsonData['id'],
      title: jsonData['title'],
      desc: jsonData['description'],
      venue: jsonData['location'],
      imageUrl: jsonData['photo'],
      date: jsonData['date'],
      endTime: jsonData['end_time'],
      startTime: jsonData['start_time'],
    );
  }
}


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
  Color likeColors = Colors.black;

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
                                  onPressed: (){
                                    setState(() {
                                      likeColors = Colors.blue;
                                    });
                                    //likeFunc ();
                                  }, 
                                  icon: Icon(Icons.thumb_up, color: likeColors), 
                                  label: Text("Like")
                                )
                              ),
                              Expanded(child: 
                                FlatButton.icon(
                                  onPressed: () {
                                    Share.share(verse_content+ " ("+verse + ") " );
                                  }, 
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


Widget upcoming01(imageLink, date, time, venue) {
      return Padding(
        padding: EdgeInsets.all(12),
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
                child: Image.network(imageLink),
              ),
              

              Row(
                children: <Widget>[
                  FlatButton.icon(onPressed: null, icon: Icon(Icons.calendar_today), 
                    label: Text(date)
                  ),

                  FlatButton.icon(onPressed: null, icon: Icon(Icons.access_time), 
                    label: Text(time)
                  ),
                ]
              ),

              Row(
                children: <Widget>[
                  FlatButton.icon(onPressed: null, icon: Icon(Icons.send), 
                    label: Text(venue)
                  ),
                ]
              )
            ],)
          ),
        );
    }

/*   shareVerse(){
    Share.share()
  } */

  static var picture_timer = Duration(seconds: 8);
  Widget the_moving_images = new Container(
    child: new Carousel(
      images: [
        new AssetImage('assets/old_man.jpg'),
        new AssetImage('assets/fitness.jpg'),
        new AssetImage('assets/blog_person.jpg'),
        new AssetImage('assets/person_1.png'),
        new AssetImage('assets/person_2.png'),
        new AssetImage('assets/person_3.png'),  
      ],
      autoplayDuration: picture_timer,
      animationCurve: Curves.easeInOutExpo,
      dotSize: 3.0,
      dotSpacing: 12.0,
      dotColor: Colors.orange,
      indicatorBgPadding: 2.0,
      borderRadius: true,
      boxFit: BoxFit.fill,

    ),
  );


  add_string_2_SP(key, value) async{
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setString(key, value);
  }

  read_from_SP(key) async{
    SharedPreferences pref = await SharedPreferences.getInstance();
    String content = pref.getString(key);
    return content;
  }

  check_in_SP (key) async{
    SharedPreferences pref = await SharedPreferences.getInstance();
    bool content = pref.containsKey(key);
    return content;
  }

checkers() async {
  if(await check_in_SP("token") == true){
    return await read_from_SP("token");
  }else{
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (BuildContext context) => user_connect() ),
        (Route<dynamic> route ) => false
      );
  }
}





Future upcomingEventsSide() async {
  String urlToday = "http://164.90.139.70/api/events/previous";
  //String urlToday = "http://164.90.139.70/api/events/current";
  String token = "Bearer " + await checkers();

  Response response = await get(
    Uri.parse(urlToday),
    headers: {
      "authorization": token,
      "accept": "application/json"
    }
  );
  int statusCode = response.statusCode;

  if (statusCode < 200 || statusCode > 400) {
    throw new Exception("Could not get Upcoming Event");
  }else{
    var content = jsonDecode(response.body);
    print(content);
    List Event = content["results"];

    //var Event_ = jsonDecode( Event[1]);

    //return upcoming01(Event_["photo"], Event_["date"], Event_["start_time"], Event_["location"]);
    return Event.map((Event) => new GLC_events.fromJson(Event)).toList();
  }
/*   if (response.statusCode == 200){
    var content = jsonDecode(response.body);

    //if(content["count"] >= 1){
      print(content);
      List Event = content["results"];

      var Event_ = jsonDecode( Event[0]);
      //var firstEvennt  = 

      return upcoming01(Event_["photo"], Event_["date"], Event_["start_time"], Event_["location"]);
    /* }else{
      Text("Problwm in connection");
      setState(() {
        today_verse = content["msg"];
      });
    } */
    
  } *//* else{
    setState(() {
      today_verse = "could not connect" ;
    });
  } */
}








Future Todays_verse() async {
  //print("enter safe...");
  //String url = "https://a1in1.com/GLC/todays_verse.php";
  String urlToday = "http://164.90.139.70/api/today/verse/";
  String token = "Bearer " + await checkers();

  Response response = await get(
    Uri.parse(urlToday),
    headers: {
      "authorization": token,
      "accept": "application/json"
    }
  );

  if (response.statusCode == 200){
    var content = jsonDecode(response.body);

    if(content["status"] == "true"){
      print(content);
      return show_today_verse(content["bible_verse"], content["msg"]);
    }else{
      setState(() {
        today_verse = content["msg"];
      });
    }
    
  }else{
    setState(() {
      today_verse = "could not connect" ;
    });
  }
  //print(response);
  //print(response.headers);

  //return response;
}

  @override
  Widget build(BuildContext context) {
    //Todays_verse();
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
                        //var EventList = ;
                        return Container(
                          child: snapshot.data,
                        );
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

                  
                  FutureBuilder(
                    future: upcomingEventsSide(),
                    //we pass a BuildContext and an AsyncSnapshot object which is an
                    //Immutable representation of the most recent interaction with
                    //an asynchronous computation.
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        List<GLC_events> EventList =  snapshot.data;
                        return Container(
                          child: upcoming01(EventList[0].imageUrl ,EventList[0].date ,EventList[0].startTime, EventList[0].venue),
                          
                        );
                        //show_today_verse(verse, verse_content)
                      } else if (snapshot.hasError) {
                        return new Container(
                          child: Text(
                            "Could not Load new Upcoming Events",
                          )
                        );
                      }
                      //return  a circular progress indicator.
                      return Center(
                        child: CircularProgressIndicator(
                          strokeWidth: 4, 
                          backgroundColor: Colors.green,
                        ),
                      );
                    },
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
