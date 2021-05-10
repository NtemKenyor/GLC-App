import 'dart:async';

import 'package:GLC/home_page/model/event_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' show get;
//import 'details_onNusea_news.dart';
//import 'nuesa_home_model.dart';
import 'dart:convert';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:GLC/generals.dart';


class CustomListView extends StatelessWidget {
  final List<EventModel> spacecrafts;

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

  Widget List_home (EventModel each_event, BuildContext context) {
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
                      image: NetworkImage(each_event.imageUrl)
                    )
                  )
                  /* child: Image.network(
                    each_event.imageUrl, 
                    fit: BoxFit.fitHeight,
                  ), */
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
    
    
    /* InkWell(
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
          height: 240,
          width: double.infinity,
          color: Colors.black,
          child: Card(
              child: Wrap(
                //crossAxisAlignment: WrapCrossAlignment.start,
                children: <Widget>[
                  Container(
                    width: double.infinity,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Row(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Image.network(
                              each_event.imageUrl, 
                              height: 120, 
                              width: 120,
                              //fit: BoxFit.contain
                            ),
                          ),
                          Expanded(
                            child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  Flexible(child: Text(each_event.title, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),)),
                                  
                                  Flexible(
                                    child: Column(
                                      children: <Widget>[
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                                            children: [
                                              Icon(Icons.calendar_today,
                                                color: Colors.amber,
                                              ),
                                              Text(each_event.date),
                                            ],
                                          ),
                                        )
                                      ]
                                    )
                                    
                                    
                                    //Text(each_event.venue+ " "+ each_event.startTime+ " "+ each_event.date) 
                                  ),
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
    ); */
  }

}

//Future is n object representing a delayed computation.
Future<List<EventModel>> GetEventsJson() async {
  //final jsonEndpoint = "https://a1in1.com/GLC/";
  final enderP = 'https://app.glclondon.church/api/events/upcoming/';
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
    return Events.map((Events) => new EventModel.fromJson(Events)).toList();
  }
    
}
class EventsGLCLondon extends StatefulWidget {
  EventsGLCLondon({Key key}) : super(key: key);

 @override
  EventsGLCLondonState createState() => EventsGLCLondonState();

}

class EventsGLCLondonState extends State<EventsGLCLondon> {

  List<EventModel> eventscarry;
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.black,
        accentColor: Color(0xFFDBECF1),
        //scaffoldBackgroundColor: Colors.black45,
      ),
      home: new Scaffold(
        //appBar: new AppBar(title: const Text('MySQL Images Text')),
        body: new Center(
          //FutureBuilder is a widget that builds itself based on the latest snapshot
          // of interaction with a Future.
          child:  FutureBuilder<List<EventModel>>(
            future: GetEventsJson(),
            //we pass a BuildContext and an AsyncSnapshot object which is an
            //Immutable representation of the most recent interaction with
            //an asynchronous computation.
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
                          var content = await GetEventsJson();
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
                        child: new CustomListView(eventscarry)
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
                  child: CircularProgressIndicator( strokeWidth: 6.0, backgroundColor: Colors.teal, ),
                );
              }
              
            },
          ),
        ),
      ),
    );
  }
}
//end
