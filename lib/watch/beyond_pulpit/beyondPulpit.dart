//import 'dart:html';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'dart:convert';
import 'simple_streamer.dart';
import 'dart:math';
import 'package:GLC/generals.dart';


class VideoOrgPulpit {
  final int id;
  final String title, message, url, photo, tv, createdAt, date;

  VideoOrgPulpit({
    this.id,
    this.title,
    this.message,
    this.url,
    this.photo,
    this.tv,
    this.date,
    this.createdAt,
  });

  factory VideoOrgPulpit.fromJson(Map<String, dynamic> jsonData) {
    return VideoOrgPulpit(
      id: jsonData['id'],
      title: jsonData['title'],
      message: jsonData['message'],
      url: jsonData['url'],
      photo: jsonData['photo'],
      tv: jsonData['tv'],
      date: jsonData['date'],
      createdAt: jsonData['created_at'],
    );
  }
}


class pulpit_Live extends StatefulWidget {
  pulpit_Live({Key key, this.title}) : super(key: key);

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

  Future video_source() async {
    //String the_video_url = "";
    String url_ = "http://164.90.139.70/api/content/beyond_the_pulpit/";
    //String url_ = "https://a1in1.com/buye/.php";
    String token = "Bearer " + await read_from_SP("token");
    return get(
      Uri.parse(url_),
        headers: {
          "authorization": token,
          "accept": "application/json"
        },
      ).then((Response response) {
      final int statusCode = response.statusCode;
      //print(response.body);
      if (statusCode < 200 || statusCode > 400) {
        throw new Exception("Error while fetching data");
      }else if (response.body != ""){
        var json_received = json.decode(response.body);
        print(json_received);
        if ((response.body).contains("results")){
          //if (int.parse(json_received["count"]) >= 1){
              //the_video_url = json_received["video"]["url"];
              //print(the_video_url);
              List Event = json_received["results"];
              print("Events stage");
              return Event.map((Event) => new VideoOrgPulpit.fromJson(Event)).toList();
              //return the_video_url;
          /* }else{
            print("You may need to check the data format of count.");
            throw new Exception(" We are facing some challenges.");
          } */
        }else{
          print("remove the results string check");
          throw new Exception(" We are facing some challenges.");
        }
      }else{
        //return the_video_url;
      }
      
      //return json_received;
    });

}

class _MyHomePageState extends State<pulpit_Live> {
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
  //Colors background_colors = Color.fromRGBO(254, 254, 254, 1);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: pure_,
      body: Container(
      height: MediaQuery.of(context).size.height,
      child: ListView(
        children: <Widget>[
          Container(
            child: new FutureBuilder (
          future: video_source(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              List<VideoOrgPulpit> theListedVideo = snapshot.data;
              if (theListedVideo.isEmpty) {
                return Center(
                  child: Text(" No Live broadcast yet. ",
                    style: TextStyle(color: Colors.blue[800], fontWeight: FontWeight.w700,),
                  ),
                );
              }else{
              VideoOrgPulpit pickRand = theListedVideo[Random().nextInt(theListedVideo.length)];
              return new Container(
                height: MediaQuery.of(context).size.height,
                child: Column(
                  //shrinkWrap: true,
                  //scrollDirection: Axis.vertical,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Center(child: VideoPlayerApp_Live(url: pickRand.url,)),

                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget> [
                        Text(pickRand.title,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                        Text("From: "+ pickRand.tv, textAlign: TextAlign.left,),
                        Text(pickRand.message, 
                          style: TextStyle(
                            //fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                      ]
                    )
                    
                  ],
                ),
              );
              }
            } else if (snapshot.hasError) {

              return new Container(
                //height: MediaQuery.of(context).size.height,
                child: Center(
                  child: Text(" Could not connect to server. ",
                    style: TextStyle(color: Colors.blue[800], fontWeight: FontWeight.w700,),
                  ),
                ),
              );
            }
            //return  a circular progress indicator.
            return new Container(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children : <Widget>[
                    CircularProgressIndicator(),
                    Expanded(
                      child: Text("Processing, Please Wait.", 
                      style: TextStyle(
                        color: Colors.green[800],
                        fontWeight: FontWeight.w800,
                      ),
                      )
                    )
                  ]
                ),
              )
            );
          },
          ),
          ),

        ],
      ),
      )
    );
  }
}
