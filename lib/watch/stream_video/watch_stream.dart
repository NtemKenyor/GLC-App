
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'dart:convert';
import 'streaming_player.dart';
import 'dart:math';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class VideoOrg {
  final int id;
  final String title, message, url, photo, tv, createdAt, date;

  VideoOrg({
    this.id,
    this.title,
    this.message,
    this.url,
    this.photo,
    this.tv,
    this.date,
    this.createdAt,
  });

  factory VideoOrg.fromJson(Map<String, dynamic> jsonData) {
    return VideoOrg(
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


class WatchLiveWidget extends StatelessWidget {
  Future video_source() async {
    String the_video_url = "";
    String url_ = "https://app.glclondon.church/api/content/live_tv/";
    //String url_ = "https://a1in1.com/buye/.php";
   // String token = "Bearer " + await read_from_SP("token");
    return get(
      Uri.parse(url_),
      // headers: {
      //   "authorization": token,
      //   "accept": "application/json"
      // },
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
          return Event.map((Event) => new VideoOrg.fromJson(Event)).toList();
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
    return Container(
          height: 200.h,
          child: ListView(
            children: <Widget>[
              Container(
                child: new FutureBuilder (
                  future: video_source(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      List<VideoOrg> theListedVideo = snapshot.data;
                      if (theListedVideo.isEmpty) {
                        return Center(
                          child: Text(" No Live broadcast yet. ",
                            style: TextStyle(color: Colors.blue[800], fontWeight: FontWeight.w700,),
                          ),
                        );
                      }else{
                        VideoOrg pickRand = theListedVideo[Random().nextInt(theListedVideo.length)];
                        return new Container(
                          height: MediaQuery.of(context).size.height,
                          child: Column(
                            mainAxisSize:MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Center(child: VideoPlayerApp_Live(url: pickRand.url,)),

                              Column(
                                mainAxisSize:MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget> [
                                    Text(pickRand.title,
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20.sp,
                                      ),
                                    ),
                                    Text("From: "+ pickRand.tv, textAlign: TextAlign.left,),
                                    Text(pickRand.message,
                                      style: TextStyle(
                                        //fontWeight: FontWeight.bold,
                                        fontSize: 18.sp,
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
                          child: Text(" We Could not connect to the Server. ",
                            style: TextStyle(color: Colors.blue[800], fontWeight: FontWeight.w700,),
                          ),
                        ),
                      );
                    }
                    //return  a circular progress indicator.
                    return new Container(
                        child: Center(
                          child: Column(
                              mainAxisSize:MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children : <Widget>[
                                CircularProgressIndicator(),
                                Text("Processing, Please Wait.",
                                  style: TextStyle(
                                    color: Colors.green[800],
                                    fontWeight: FontWeight.w800,
                                  ),
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

    );
  }
}

