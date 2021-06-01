//import 'dart:html';

import 'package:GLC/utils/pallet.dart';
import 'package:flutter/material.dart';
import 'package:GLC/generals.dart';
import 'package:http/http.dart';
import 'dart:convert';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
      desc: jsonData['desc'],
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

  }

  Widget List_home (Comms get1Comms, BuildContext context) {
    return  Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
          decoration: new BoxDecoration(

              gradient: new LinearGradient(
                  stops: [0.02, 0.02],
                  colors: [Colors.red, Colors.red.withOpacity(0.2)]
              ),
              borderRadius: new BorderRadius.all(const Radius.circular(10))),
          // decoration: BoxDecoration(
          //   color: Colors.red.withOpacity(0.2),
          //   //borderRadius: BorderRadius.circular(12),
          //   // borderRadius: BorderRadius.only(
          //   //     topLeft: Radius.circular(20.0),
          //   //     bottomLeft: Radius.circular(20.0)),
          //   border: Border(
          //       left: BorderSide(
          //         color: Color.fromRGBO(241, 89, 34, 1),
          //         width: 5,
          //       )
          //   ),
          //
          // ),
          padding:EdgeInsets.all(10),
          height: 130.h,
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment:CrossAxisAlignment.start,
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
                      padding: EdgeInsets.fromLTRB(8, 8, 8, 9),
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
  ///String token = "Bearer " + await read_from_SP("token")??"";

  final responseEvents = await get(
    Uri.parse(enderP),
    // headers: {
    //   "authorization": token,
    //   "accept": "application/json"
    // }
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


class ConnectScreen extends StatefulWidget {
  ConnectScreen({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<ConnectScreen> {
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

