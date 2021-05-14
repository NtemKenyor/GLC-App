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


class EventsideDisplay extends StatelessWidget {
  final List<GLC_events> theEvents;
  String category;
  EventsideDisplay({this.theEvents, this.category});


  Widget build(context) {
    if(category == null){
      category = "Events";
    }
    return (theEvents.isNotEmpty) ?  Container(
      height: 320,
      child: ListView.builder(
        shrinkWrap: true,
        physics: ScrollPhysics(),
        scrollDirection: Axis.horizontal,
        itemCount: theEvents.length,
        itemBuilder: (context, int currentIndex) {
          return eventsList( theEvents[currentIndex], context);
        },
      ),
    ) : Container(
        height: 120,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.only(top: 10.0, bottom: 2.0,),
            child: Text("No" + category,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black)
            ),
          ),
        ),
      );
  }

  Widget eventsList(GLC_events one_event, BuildContext context) {
    var wallpaper = ( one_event.imageUrl != null) ? NetworkImage(one_event.imageUrl) : AssetImage("assets/glc logo 1.jpg");
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 210,
        width: 230,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: Color.fromRGBO(247, 247, 247, 1),
        ),
        

        child: Column(
          children: [
            Expanded(
              flex: 650,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  image: DecorationImage(
                    fit: BoxFit.fill,
                    image: wallpaper,
                  )
                ),

                child: Stack(
                  children: [
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Flexible(
                              child: Text(one_event.startTime , 
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 9,
                                ),
                              ),
                            ),

                            Row(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Icon( Icons.calendar_today_outlined, size: 17, color: Colors.white, ),
                                Flexible(
                                  child: Text( one_event.date ,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 9,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ]
                ),
              ),
            ),

            Expanded(
              flex: 350,
              child: Center(
                child: Container(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(one_event.title, 
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Text(
                          one_event.desc,
                          style: TextStyle(
                            fontSize: 15,
                          ),
                        ),
                      )
                    ]
                  ),
                ),
              ),
            )
          ],
        ),
      ),
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
  List defaultImgs = [
    new AssetImage('assets/glc logo 1.jpg'),
    new AssetImage('assets/glc logo 1.png'),
  ];


/* 
Widget upcoming01(imageLink, date, time, venue) {

  Container(
      /* height: 320,
      //color: Colors.green[500],
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 7,
        itemBuilder: (context, int){
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              height: 210,
              width: 230,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: Color.fromRGBO(247, 247, 247, 1),
                //color: Colors.yellow[500],
              ),
              

              child: Column(
                children: [
                  Expanded(
                    flex: 650,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        image: DecorationImage(
                          fit: BoxFit.fill,
                          image: AssetImage("assets/blog_1.png"),
                        )
                      ),

                      child: Stack(
                        children: [
                          Align(
                            alignment: Alignment.bottomCenter,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  /* Text("00:00", 
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 9,
                                    ),
                                  ), */

                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Icon( Icons.calendar_today_outlined, size: 17, color: Colors.white, ),
                                      Text(" 07/04/2021",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 9,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ]
                      ),
                    ),
                  ),

                  Expanded(
                    flex: 350,
                    child: Center(
                      child: Container(
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text("the Big Stuffs", 
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Expanded(
                              child: Text(
                                "The small write ups and the fill of the magic all.",
                                style: TextStyle(
                                  fontSize: 15,
                                ),
                              ),
                            )
                          ]
                        ),
                      ),
                    ),
                  )
          
                ],
              ),

            ),
          );
        }
      ),
    ); */
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
    } */

  static var picture_timer = Duration(seconds: 8);
  Widget the_moving_images(imgArried) {
    return new Container(
    child: new Carousel(
      images: imgArried,
      defaultImage: "assets/glc logo 1.jpg",
      /* images: [
        new AssetImage('assets/old_man.jpg'),
        new AssetImage('assets/fitness.jpg'),
        new AssetImage('assets/blog_person.jpg'),
        new AssetImage('assets/person_1.png'),
        new AssetImage('assets/person_2.png'),
        new AssetImage('assets/person_3.png'),
      ], */
      autoplayDuration: picture_timer,
      animationCurve: Curves.decelerate,
      dotSize: 5.0,
      dotSpacing: 13.0,
      dotColor: Colors.white38,
      dotIncreasedColor: Colors.white,
      indicatorBgPadding: 0.0,
      borderRadius: true,
      boxFit: BoxFit.fill,

    ),
  );
  } 


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


Future carouselLoader() async {
  String urlToday = "https://app.glclondon.church/api/content/carousel/";
  //String urlToday = "https://app.glclondon.church/api/events/current";
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
    throw new Exception("Could not fetch carousel");
  }else{
    var content = jsonDecode(response.body);
    //print(content);
    if (content["status"] == "true"){
      List listedImg = content["photos"] as List;
      return listedImg;
    }else{
      throw new Exception("Could not fetch any image");
    }
  }
}


Future upcomingEventsSide() async {
  String urlToday = "https://app.glclondon.church/api/events/upcoming/";
  //String urlToday = "https://app.glclondon.church/api/events/current";
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








/* Future Todays_verse() async {
  //print("enter safe...");
  //String url = "https://a1in1.com/GLC/todays_verse.php";
  String urlToday = "https://app.glclondon.church/api/today/verse/";
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
} */

  @override
  Widget build(BuildContext context) {
    //Todays_verse();
    return Scaffold(
      //backgroundColor: Color.fromRGBO(247, 247, 247, 1),
      backgroundColor: Colors.white,
      body: ListView(
        scrollDirection: Axis.vertical,
        children: <Widget>[
          /* Padding(
            padding: EdgeInsets.fromLTRB(4, 10, 4, 10),
            child: Text("Upcoming Events", style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),),
          ), */


          FutureBuilder(
            future: carouselLoader(),
            //we pass a BuildContext and an AsyncSnapshot object which is an
            //Immutable representation of the most recent interaction with
            //an asynchronous computation.
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                List imageList = snapshot.data;
                List netAsset = [];
                for (var img in imageList) {
                  netAsset.add( new NetworkImage(img));
                }
                return Container(
                  height: 275,
                  width: double.infinity,
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(5, 7, 5, 7),
                    child: the_moving_images(netAsset),
                  )
                );
              } else if (snapshot.hasError) {
                return new Container(
                  height: 275,
                  width: double.infinity,
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(5, 7, 5, 7),
                    child: the_moving_images(defaultImgs),
                  )
                );
              }
              //return  a circular progress indicator.
              return Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Center(child: CircularProgressIndicator(strokeWidth: 7, backgroundColor: Colors.blue[400],),)
                  ),
                ],
              );
            },
          ),
                  
          SizedBox(
            height: 20,
          ),

                  Padding(
                    padding: const EdgeInsets.fromLTRB(8.0, 3, 8.0, 3),
                    child: Container(
                      padding: EdgeInsets.all(13),
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
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(1.0),
                            child: Icon(Icons.house_outlined, color: Colors.orange, ),
                          ),
                          Expanded(
                            child: Text("The Great Light Church, London, UK",
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  SizedBox(
                    height: 20,
                  ),

                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      child: Text("Upcoming Events", 
                        style: TextStyle(
                          fontSize: 19, 
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.left,
                      ),
                    ),
                  ),

                  
                  FutureBuilder(
                    future: upcomingEventsSide(),
                    //we pass a BuildContext and an AsyncSnapshot object which is an
                    //Immutable representation of the most recent interaction with
                    //an asynchronous computation.
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        List<GLC_events> EventList =  snapshot.data;

                        return Container(
                          child: EventsideDisplay(theEvents: EventList, category: "Upcoming Events"),
                        );

                      } else if (snapshot.hasError) {
                        return new Container(
                          child: Text(
                            "Could not Load new Upcoming Events",
                          )
                        );
                      }
                      //return  a circular progress indicator.
                      return Container(
                        child: Center(
                          child: CircularProgressIndicator(
                            strokeWidth: 4, 
                            backgroundColor: Colors.green,
                          ),
                        ),
                      );
                    },
                  ),

                  
               /*  ],
              ), 
            ), */
        ],
      ),
     
    );
  }
}
