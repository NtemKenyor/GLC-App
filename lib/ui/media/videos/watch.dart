//import 'dart:html';

import 'package:GLC/ui/media/widgets/custom_circle_widget.dart';
import 'package:GLC/utils/constants.dart';
import 'package:GLC/utils/pallet.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'dart:convert';
import 'video_player.dart';
import 'package:GLC/generals.dart';
import 'package:video_player/video_player.dart';

class VideoCast {
  //final String id;
  final String name, date, watchIt;

  VideoCast({
    this.name,
    this.date,
    this.watchIt,
  });

  factory VideoCast.fromJson(Map<String, dynamic> jsonData) {
    return VideoCast(
      name: jsonData['title'],
      date: jsonData['date'],
      watchIt: jsonData['file'],
    );
  }
}

class VideosPage extends StatefulWidget {
  VideosPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _VideosPageState createState() => _VideosPageState();
}


Future<List<VideoCast>> video_source() async {
  final jsonEndpoint = 'https://app.glclondon.church/api/content/videos/';
  String token = "Bearer " + await read_from_SP("token");
  Response response = await get(
    Uri.parse(jsonEndpoint),
    headers: {
      "authorization": token,
      "accept": "application/json"
    }
  );
  int statusCode = response.statusCode;
  print( jsonDecode(response.body ) );
  if (statusCode < 200 || statusCode > 400) {
    print("jobs fix");
    throw Exception('We were not able to successfully download the json data.');
  }else {
    print("here");
    var content = json.decode(response.body);
    List videolist = content["results"] as List;
    return videolist
        .map((videolist) => new VideoCast.fromJson(videolist))
        .toList();
  }
}

class _VideosPageState extends State<VideosPage> {
  int _counter = 0;
  int _selectedIndex = 0;
  List<VideoCast> theList;

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
      backgroundColor: Colors.white,
      body: Container(
      child: Column(
        children: <Widget>[
          Expanded(
            child: Container(
              child: new FutureBuilder<List<VideoCast>> (
            future: video_source(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                //String goto = snapshot.data;
                theList = snapshot.data;
                return RefreshIndicator(
                  onRefresh: ()  {
                      return Future.delayed(
                        Duration(seconds: 3), () async {
                          var content = await video_source();
                          setState(() {
                            theList = content;
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
                    child: VideoListView(thevideoers: theList,)
                  ),
                );
              } else if (snapshot.hasError) {
                return new Container(
                  child: Text("We are Facing some issues. Try Again Later.",
                    style: TextStyle(color: Colors.red[800], fontWeight: FontWeight.w700,),
                  ),
                );
              }
              //return  a circular progress indicator.
              return new Container(
                /* decoration: BoxDecoration(
                  image: DecorationImage(image: AssetImage("assets/glc logo 1.png"), fit: BoxFit.fill)
                ), */
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
            )
          ),
          
          /* Row(
            //mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Icon(Icons.person_outline),
                      Text("BIBLE"),
                  ],),
                )
              ),

              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Icon(Icons.note_add),
                      Text("NOTES"),
                  ],),
                )
              )
            ],
          ) */


        ],
      ),
      )
    );
  }
}




class VideoListView extends StatefulWidget {
  VideoListView({Key key, this.title, this.thevideoers}) : super(key: key);

  final String title;
  final List<VideoCast> thevideoers;


  @override
  _VideoListViewState createState() => _VideoListViewState(thevideoers);
}
class _VideoListViewState extends State<VideoListView> {
      final List<VideoCast> thevideoers;
      _VideoListViewState(this.thevideoers);


      
 
      Widget VideoStructure(url, date){
        VideoPlayerController _controller = VideoPlayerController.network(url);
        Future<void> _initializeVideoPlayerFuture = _controller.initialize();
        _controller.setLooping(true);

        @override
          void dispose() {
            _controller.dispose();
            super.dispose();
          } 

        return ClipRRect(
          borderRadius: BorderRadius.circular(12),

          child: Column(
            children: [
              Container(
                height: 200,
                child: Stack(
                  children: [
                    Container(child: new VideoPlayer(_controller)),
                    Align(
                      alignment: Alignment.center,
                      child: Container(
                          child: CustomPaint(
                            painter: DrawCircle(),
                            child: Icon(Icons.play_arrow_rounded, color: Colors.white),
                          )),
                    ),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: Padding(
                        padding: EdgeInsets.all(5),
                        child: Row(
                            mainAxisSize:MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Icon(
                                Icons.calendar_today,
                                color: Colors.white,
                              ),
                              SizedBox(width:5),
                              Flexible(
                                  child: Text(date,
                                      maxLines: 1,
                                      style: TextStyle(color: Colors.white))),
                            ]
                          //trailing: Text("Monday, 21st October"),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(height: 10,),
              Padding(
                padding:EdgeInsets.all(20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                  Text("Blessings of God in Him", style:TextStyle(fontSize: 18, fontWeight: FontWeight.w700, color:Colors.grey.shade700)),
                  Icon(Icons.more_vert, color:Pallet.primaryColor)
                ],),

              ),

              Padding(
                  padding:EdgeInsets.symmetric(horizontal: 20),
                  child: Text(Constants.dummyText, style:TextStyle(color:Colors.grey.shade500))),
              SizedBox(height: 10,)
            ],
          ),
        );

        
      }

      Widget List_video (VideoCast theVideo, BuildContext context, int index) {
            /* VideoPlayerController _controller;
            Future<void> _initializeVideoPlayerFuture;
            @override
            void initState() {
              _controller = VideoPlayerController.network(theVideo.watchIt,);
              _initializeVideoPlayerFuture = _controller.initialize();
              _controller.setLooping(true);
              super.initState();
            }

            @override
            void dispose() {
              _controller.dispose();
              super.dispose();
            } */
                return GestureDetector(
                  onTap: () async {
                    var route = new MaterialPageRoute(
                      builder: (BuildContext context) =>
                      new VideoPlayerApp(url: theVideo.watchIt,),
                    );
                    Navigator.of(context).push(route);
                  },
                  child: Container(
                    margin: EdgeInsets.all(10),
                    decoration:BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(12)),
                      color: Colors.grey.shade100
                    ),
                    child: VideoStructure(theVideo.watchIt, theVideo.date),
                  ),
        );
      }

        Widget build(context) {
          return ListView.builder(
          itemCount: thevideoers.length,
          itemBuilder: (context, int currentInd){
            //listenIcon = (currentInd == playingFrom) ? Icons.pause : Icons.headset;
            return List_video(thevideoers[currentInd], context, currentInd);
          },
        );
        }

}