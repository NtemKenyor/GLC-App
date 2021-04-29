//import 'dart:html';

import 'package:flutter/material.dart';
import 'package:GLC/generals.dart';
import 'package:http/http.dart';
import 'dart:convert';

class Comms {
  //final int id;
  final String title, desc, writer, date;

  Comms({
    this.title,
    this.desc,
    this.writer,
    this.date,
  });

  factory Comms.fromJson(Map<String, dynamic> jsonData) {
    return Comms(
      title: jsonData['title'],
      desc: jsonData['description'],
      writer: jsonData['writer'],
      date: jsonData['date'],
    );
  }
}


class ComsListView extends StatelessWidget {
  final List<Comms> commscrafts;

  ComsListView(this.commscrafts);


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
            itemCount: commscrafts.length,
            itemBuilder: (context, int currentIndex) {
              return List_home( commscrafts[currentIndex], context);
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

  Widget List_home (Comms get1Comms, BuildContext context) {
    return  Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.red.withOpacity(0.2),
          //borderRadius: BorderRadius.circular(12),
          //would drop an error...
          border: Border(
            left: BorderSide(
              color: Color.fromRGBO(241, 89, 34, 1),
              width: 5,
            )
          ),

        ),
        height: 130,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children : <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(get1Comms.title, 
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
              ),
            ),

            Expanded(
              child: 
              Padding(
                padding: EdgeInsets.fromLTRB(14, 8, 8, 9),
                child:  Text(get1Comms.desc),
              )
            ),

            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(get1Comms.writer + " " + get1Comms.date),
            ),
          ]
        )
      ),
    );
  }

}


Future<List<Comms>> GetEventsJson() async {
  //final jsonEndpoint = "https://a1in1.com/GLC/";
  final enderP = 'https://app.glclondon.church/api/GLC/connect';
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
    return Events.map((Events) => new Comms.fromJson(Events)).toList();
  }
    
}


class coonect_page extends StatefulWidget {
  coonect_page({Key key, this.title}) : super(key: key);

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

class _MyHomePageState extends State<coonect_page> {
  int _counter = 0;
  int _selectedIndex = 0;
  List<Comms> commsentry;

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
    return Scaffold(
      backgroundColor: pure_,
      body: Container(
      child: FutureBuilder<List<Comms>>(
        future: GetEventsJson(),
        //we pass a BuildContext and an AsyncSnapshot object which is an
        //Immutable representation of the most recent interaction with
        //an asynchronous computation.
        builder: (context, gottenshot) {
          //var constate =  gottenshot.connectionState.done ;
          switch (gottenshot.connectionState){
            case ConnectionState.done:
            if (gottenshot.data != null) {
              commsentry = gottenshot.data;
                return RefreshIndicator(
                  onRefresh: ()  {
                      return Future.delayed(
                        Duration(seconds: 3), () async {
                          var content = await GetEventsJson();
                          setState(() {
                            commsentry = content;
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
                    child: new ComsListView(commsentry)
                    ),
                );
            } else if (gottenshot.hasError ) {
                return Center(
                  child: new Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'No Comms Yet.',
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                    ],
                  ),
              ),
                );
            }
            break;
            default: return new Container(
              child: Center(child: CircularProgressIndicator( strokeWidth: 6.0, backgroundColor: Colors.teal, )),
            );
          }
        },
      ),
      )
    );
  }
}

/* 
Widget theExchanger(){
  return ListView.builder(
          //scrollDirection: Axis.vertical,
          itemCount: 7,
          itemBuilder: (BuildContext context, int){
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.red.withOpacity(0.2),
                  //borderRadius: BorderRadius.circular(12),
                  //would drop an error...
                  border: Border(
                    left: BorderSide(
                      color: red_color,
                      width: 5,
                    )
                  ),

                ),
                height: 130,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children : <Widget>[
                    Expanded(child: 
                      Padding(
                        padding: EdgeInsets.fromLTRB(20, 10, 10, 15),
                        child:  Text("The grace and mercy of our Lord and saviour Jesus christ rest with you all in the power of the saved Lord. The power of grace."),
                      )
                    ),

                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text("-GLC(@GreatLightChurch) January 2021"),
                    ),
                  ]
                )
              ),
            );
          }
        );

} */
