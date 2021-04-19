import 'dart:async';

import 'package:flutter/material.dart';
import 'package:http/http.dart' show get;
//import 'details_onNusea_news.dart';
//import 'nuesa_home_model.dart';
import 'dart:convert';
import 'package:carousel_pro/carousel_pro.dart';

class GLC_events {
  final String id;
  final String title, imageUrl, venue, date, time;

  GLC_events({
    this.id,
    this.title,
    this.venue,
    this.imageUrl,
    this.date,
    this.time
  });

  factory GLC_events.fromJson(Map<String, dynamic> jsonData) {
    return GLC_events(
      id: jsonData['id'],
      title: jsonData['event'],
      venue: jsonData['venue'],
      imageUrl: "https://a1in1.com/GLC/images/"+jsonData['image'],
      date: jsonData['date'],
      time: jsonData['time'],
    );
  }
}

class CustomListView extends StatelessWidget {
  final List<GLC_events> spacecrafts;

  CustomListView(this.spacecrafts);


  Widget build(context) {
    return ListView(
        scrollDirection: Axis.vertical,
        children: <Widget>[
          Center(
            child: Padding(
              padding: const EdgeInsets.only(top: 10.0, bottom: 2.0,),
              child: Text("Events",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)
              ),
            ),
          ),

          ListView.builder(
            shrinkWrap: true,
            physics: ScrollPhysics(),
            itemCount: spacecrafts.length,
            itemBuilder: (context, int currentIndex) {
              return List_home( spacecrafts[currentIndex], context);
            },
          )
        ]
    );

    /* return ListView.builder(
      itemCount: spacecrafts.length,
      itemBuilder: (context, int currentIndex) {
        return List_home(spacecrafts[currentIndex], context);
      },
    );*/
  }

  Widget List_home (GLC_events each_event, BuildContext context) {
    return InkWell(
      hoverColor: Colors.orange,
      onTap: () {
        //TODO
        //May be int he
        /* var route = new MaterialPageRoute(
          builder: (BuildContext context) =>
          new SecondScreen(value: nuesa_news),
        ); */
        //Navigator.of(context).push(route);
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          color: Colors.black,
          child: Card(
              child: Wrap(
                crossAxisAlignment: WrapCrossAlignment.start,
                children: <Widget>[
                  Container(
                    width: double.infinity,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Row(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Image.network(each_event.imageUrl, height: 100, width: 100),
                          ),
                          Expanded(
                            child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  Flexible(child: Text(each_event.title, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),)),
                                  Flexible(child: Text(each_event.venue+ " "+ each_event.time+ " "+ each_event.date) ),
                                ]
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              )
          ),
        ),
      ),
    );
  }

}

//Future is n object representing a delayed computation.
Future<List<GLC_events>> downloadJSON() async {
  final jsonEndpoint =
      "https://a1in1.com/GLC/";

  final response = await get(Uri.parse(jsonEndpoint));

  if (response.statusCode == 200) {
    List Events = json.decode(response.body);
    return Events
        .map((Events) => new GLC_events.fromJson(Events))
        .toList();
  } else
    throw Exception('We were not able to successfully download the json data.');
}


class EventsGLCLondon extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      theme: ThemeData(
        primaryColor: Colors.black,
        accentColor: Color(0xFFDBECF1),
        scaffoldBackgroundColor: Colors.black45,
      ),
      home: new Scaffold(
        //appBar: new AppBar(title: const Text('MySQL Images Text')),
        body: new Center(
          //FutureBuilder is a widget that builds itself based on the latest snapshot
          // of interaction with a Future.
          child: new FutureBuilder<List<GLC_events>>(
            future: downloadJSON(),
            //we pass a BuildContext and an AsyncSnapshot object which is an
            //Immutable representation of the most recent interaction with
            //an asynchronous computation.
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                List<GLC_events> spacecrafts = snapshot.data;
                return Container(
                    color: Colors.white,
                    child: new CustomListView(spacecrafts));
              } else if (snapshot.hasError) {
                return new Container(
                  decoration: BoxDecoration(
                      image: DecorationImage(image: AssetImage("assets/glc logo 1.png"), fit: BoxFit.fill)
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text('Look'+"'s"+ ' Like You do not have an Internet connection'),
                        ),
                    ],
                  ),
                );
              }
              //return  a circular progress indicator.
              return new Container(
                decoration: BoxDecoration(
                  image: DecorationImage(image: AssetImage("assets/nuesa_background1.gif"), fit: BoxFit.contain)
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
//end
