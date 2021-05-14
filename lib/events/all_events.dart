import 'dart:async';

import 'package:flutter/material.dart';
import 'package:http/http.dart' show get;
//import 'details_onNusea_news.dart';
//import 'nuesa_home_model.dart';
import 'dart:convert';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:GLC/generals.dart';

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

class EventblockDisplay extends StatelessWidget {
  final List<GLC_events> eventkrafted;
  String category;
  EventblockDisplay({this.eventkrafted, this.category});


  Widget build(context) {
    if(category == null){
      category = "Events";
    }
    return (eventkrafted.isNotEmpty) ? ListView(
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        children: <Widget>[
          Center(
            child: Padding(
              padding: const EdgeInsets.only(top: 10.0, bottom: 2.0,),
              child: Text(category,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black)
              ),
            ),
          ),

          Container(
            height: 320,
            child: ListView.builder(
              shrinkWrap: true,
              physics: ScrollPhysics(),
              itemCount: eventkrafted.length,
              itemBuilder: (context, int currentIndex) {
                return List_vet( eventkrafted[currentIndex], context);
              },
            ),
          )
        ]
    ): Container(
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

  Widget List_vet(GLC_events each_event, BuildContext context) {
    var netImage = ( each_event.imageUrl != null) ? NetworkImage(each_event.imageUrl) : AssetImage("assets/glc logo 1.jpg");
    return Container(
      height: 210,
      //color: Colors.blue[300],
      child: Card(
        elevation: 10,
        child: Row(
          children: [
              Expanded(
                flex: 400,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.orange,
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: netImage,
                    )
                  )
                ),
              ),

              Expanded(
                flex: 600,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(each_event.title, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),),

                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            //mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Icon(Icons.calendar_today,
                                color: Colors.amber,
                              ),
                              Flexible(child: Text(each_event.date)),
                            ],
                          ),
                        ),

                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            //mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Icon(Icons.timer,
                                color: Colors.amber,
                              ),
                              Flexible(
                                child: Text(each_event.startTime+" - "+ each_event.endTime),
                              ),
                            ],
                          ),
                        ),

                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            //mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Icon(Icons.send,
                                color: Colors.amber,
                              ),
                              Flexible(child: Text(each_event.venue)),
                            ],
                          ),
                        )
                      ]
                    ),
                  ],
                )
              )
            ],
          ),
      ),
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
    return (theEvents.isNotEmpty) ?  ListView(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        children: <Widget>[
          Center(
            child: Padding(
              padding: const EdgeInsets.only(top: 10.0, bottom: 2.0,),
              child: Text(category,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black)
              ),
            ),
          ),

          Container(
            height: 320,
            child: ListView.builder(
              shrinkWrap: true,
              physics: ScrollPhysics(),
              scrollDirection: Axis.horizontal,
              itemCount: theEvents.length,
              itemBuilder: (context, int currentIndex) {
                return List_home( theEvents[currentIndex], context);
              },
            ),
          )
        ]
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

  Widget List_home (GLC_events each_event, BuildContext context) {
    var wallpaper = ( each_event.imageUrl != null) ? NetworkImage(each_event.imageUrl) : AssetImage("assets/glc logo 1.jpg");
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
                              child: Text(each_event.startTime , 
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
                                  child: Text( each_event.date ,
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
                        child: Text(each_event.title, 
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Text(
                          each_event.desc,
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

//Future is n object representing a delayed computation.
Future<List<GLC_events>> GetEventsJson(String enderP) async {
  //final jsonEndpoint = "https://a1in1.com/GLC/";
 // final  = 'https://app.glclondon.church/api/events/upcoming/';
  String token = "Bearer " + await read_from_SP("token");

  final responseEvents = await get(
    Uri.parse(enderP),
    headers: {
      "authorization": token,
      "accept": "application/json"
    }
  );
  int statusCode = responseEvents.statusCode;
  if (statusCode < 200 || statusCode > 400) {
    throw Exception('We were not able to successfully download the List of events.');
  } else {
    var givenData = json.decode(responseEvents.body);
    List Events = givenData["results"];
    //print(Events);
    return Events.map((Events) => new GLC_events.fromJson(Events)).toList();
  }
    
}
class EventsGLCLondon extends StatefulWidget {
  EventsGLCLondon({Key key}) : super(key: key);

 @override
  EventsGLCLondonState createState() => EventsGLCLondonState();

}

class EventsGLCLondonState extends State<EventsGLCLondon> {
  String upcomingEventy = 'https://app.glclondon.church/api/events/upcoming/';
  String previousEventer = 'https://app.glclondon.church/api/events/previous/';
  String currentEventor = 'https://app.glclondon.church/api/events/current/';
  List<GLC_events> eventscarry;
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      theme: ThemeData(
        primaryColor: Colors.black,
        accentColor: Color(0xFFDBECF1),
        //scaffoldBackgroundColor: Colors.black45,
      ),
      home: new Scaffold(
        //appBar: new AppBar(title: const Text('MySQL Images Text')),
        body: ListView(
          children: [

            Padding(
              padding: const EdgeInsets.all(21.0),
              child: FutureBuilder<List<GLC_events>>(
                future: GetEventsJson(upcomingEventy),
                builder: (context, gottenshot) {
                  //var constate =  gottenshot.connectionState.done ;
                  switch (gottenshot.connectionState){
                    case ConnectionState.done:
                    if (gottenshot.data != null) {
                      eventscarry = gottenshot.data;
                       return RefreshIndicator(
                         onRefresh: ()  {
                          return Future.delayed(
                            Duration(seconds: 3), () async {
                              var content = await GetEventsJson(upcomingEventy);
                              setState(() {
                                eventscarry = content;
                              });

                               ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text('Page Refreshed'),
                                ),
                              );
                              
                            }
                          );
                        },
                         child: Container(
                            color: Colors.white,
                            child: new EventsideDisplay(theEvents: eventscarry, category: "Upcoming Events",)
                          ),
                       );
                    } else if (gottenshot.hasError ) {
                       return new Container(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  'We are facing some challenges.',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                          ],
                        ),
                      );
                    }
                    break;
                    default: return new Container(
                      height: 320,
                      child: Center(
                        child: CircularProgressIndicator( 
                            strokeWidth: 6.0, 
                            backgroundColor: 
                            Colors.teal,
                        )
                      ),
                    );
                  }
                },
              ),
            ),


            Padding(
              padding: const EdgeInsets.all(21.0),
              child: FutureBuilder<List<GLC_events>>(
                future: GetEventsJson(previousEventer),
                builder: (context, gottenshot) {
                  //var constate =  gottenshot.connectionState.done ;
                  switch (gottenshot.connectionState){
                    case ConnectionState.done:
                    if (gottenshot.data != null) {
                      eventscarry = gottenshot.data;
                       return RefreshIndicator(
                         onRefresh: ()  {
                          return Future.delayed(
                            Duration(seconds: 3), () async {
                              var content = await GetEventsJson(previousEventer);
                              setState(() {
                                eventscarry = content;
                              });

                               ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text('Page Refreshed'),
                                ),
                              );
                              
                            }
                          );
                        },
                         child: Container(
                            color: Colors.white,
                            child: new EventsideDisplay(theEvents: eventscarry, category: "Previous Events",)
                          ),
                       );
                    } else if (gottenshot.hasError ) {
                       return new Container(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  'We are facing some challenges.',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                          ],
                        ),
                      );
                    }
                    break;
                    default: return new Container(
                      height: 320,
                      child: Center(
                        child: CircularProgressIndicator( 
                            strokeWidth: 6.0, 
                            backgroundColor: 
                            Colors.teal,
                        )
                      ),
                    );
                  }
                },
              ),
            ),


            Padding(
              padding: const EdgeInsets.all(21.0),
              child: FutureBuilder<List<GLC_events>>(
                future: GetEventsJson(currentEventor),
                builder: (context, gottenshot) {
                  //var constate =  gottenshot.connectionState.done ;
                  switch (gottenshot.connectionState){
                    case ConnectionState.done:
                    if (gottenshot.data != null) {
                      eventscarry = gottenshot.data;
                       return RefreshIndicator(
                         onRefresh: ()  {
                          return Future.delayed(
                            Duration(seconds: 3), () async {
                              var content = await GetEventsJson(currentEventor);
                              setState(() {
                                eventscarry = content;
                              });

                               ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text('Page Refreshed'),
                                ),
                              );
                              
                            }
                          );
                        },
                         child: Container(
                            color: Colors.white,
                            child: new EventsideDisplay(theEvents: eventscarry, category: "Current Events",)
                          ),
                       );
                    } else if (gottenshot.hasError ) {
                       return new Container(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  'We are facing some challenges.',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                          ],
                        ),
                      );
                    }
                    break;
                    default: return new Container(
                      height: 320,
                      child: Center(
                        child: CircularProgressIndicator( 
                            strokeWidth: 6.0, 
                            backgroundColor: 
                            Colors.teal,
                        )
                      ),
                    );
                  }
                },
              ),
            ),


            Padding(
              padding: const EdgeInsets.all(21.0),
              child: FutureBuilder<List<GLC_events>>(
                future: GetEventsJson(upcomingEventy),
                builder: (context, gottenshot) {
                  //var constate =  gottenshot.connectionState.done ;
                  switch (gottenshot.connectionState){
                    case ConnectionState.done:
                    if (gottenshot.data != null) {
                      eventscarry = gottenshot.data;
                       return RefreshIndicator(
                         onRefresh: ()  {
                          return Future.delayed(
                            Duration(seconds: 3), () async {
                              var content = await GetEventsJson(upcomingEventy);
                              setState(() {
                                eventscarry = content;
                              });

                               ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text('Page Refreshed'),
                                ),
                              );
                              
                            }
                          );
                        },
                         child: Container(
                            color: Colors.white,
                            child: new EventblockDisplay(eventkrafted: eventscarry, category: "Upcoming Events",)
                          ),
                       );
                    } else if (gottenshot.hasError ) {
                       return new Container(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  'We are facing some challenges.',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                          ],
                        ),
                      );
                    }
                    break;
                    default: return new Container(
                      height: 320,
                      child: Center(
                        child: CircularProgressIndicator( 
                            strokeWidth: 6.0, 
                            backgroundColor: 
                            Colors.teal,
                        )
                      ),
                    );
                  }
                },
              ),
            ),


          ],
        ),
      ),
    );
  }
}
//end
