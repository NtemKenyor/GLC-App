//import 'dart:html';

import 'package:GLC/media/podcast/media.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'dart:convert';
import 'video_player.dart';
import 'package:GLC/generals.dart';
import 'package:video_player/video_player.dart';

class VideoCast {
  //final String id;
  final String name, date, watchIt, image, duration;

  VideoCast({
    this.name,
    this.image,
    this.date,
    this.watchIt,
    this.duration,
  });

  factory VideoCast.fromJson(Map<String, dynamic> jsonData) {
    return VideoCast(
      name: jsonData['title'],
      image: jsonData['photo'],
      date: jsonData['date'],
      watchIt: jsonData['file'],
      duration: jsonData['videoDuration'],
    );
  }
}

class watch_page extends StatefulWidget {
  watch_page({Key key, this.title}) : super(key: key);

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

/*   Future<String> video_source() async {
    String the_video_url = "";
    String url_ = "https://a1in1.com/GLC/video_stream.php";
    return get(Uri.parse(url_)).then((Response response) {
      final int statusCode = response.statusCode;
      print(response.body);
      if (statusCode < 200 || statusCode > 400) {
        throw new Exception("Error while fetching data");
      }else if (response.body != ""){
        var json_received = json.decode(response.body);
        print(json_received);
        if ((response.body).contains("status")){
          if (json_received["status"] == "true"){
              the_video_url = json_received["video"]["url"];
              print(the_video_url);
              return the_video_url;
          }else if(json_received["status"] == "false"){
            throw new Exception(" We are facing some challenges.");
          }
        }
      }else{
        //return the_video_url;
      }
      
      //return json_received;
    });

} */

class _MyHomePageState extends State<watch_page> {
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
      backgroundColor: pure_,
      body: Container(
      child: RefreshIndicator(
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
        child: new FutureBuilder<List<VideoCast>> (
          future: video_source(),
          builder: (context, snapshot) {
          if (snapshot.hasData) {
            //String goto = snapshot.data;
            theList = snapshot.data;
            return Container(
              child: VideoListView(thevideoers: theList,)
            );
          } else if (snapshot.hasError) {
            return Padding(
              padding: const EdgeInsets.all(21.0),
              child: new Container(
                child: Center(
                  child: Text("We are Facing some issues. Try Again Later.",
                    style: TextStyle(color: Colors.red[800], fontWeight: FontWeight.w700,),
                  ),
                ),
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
                mainAxisAlignment: MainAxisAlignment.center,
                children : <Widget>[
                  CircularProgressIndicator(strokeWidth: 3, backgroundColor: Colors.green[800],),
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


      
 /* 
      Widget VideoStructure(url){
        VideoPlayerController _controller = VideoPlayerController.network(url);
        Future<void> _initializeVideoPlayerFuture = _controller.initialize();
        _controller.setLooping(true);

        @override
          void dispose() {
            _controller.dispose();
            super.dispose();
          } 

        return Container(
          height: 230,
          child: //Container(child: new VideoPlayer(_controller)),
          Stack(
            children: [
              //Icon(Icons.play_circle_outline_sharp, size: 60, color: Colors.white,),
              Center(
                child: Icon(Icons.play_circle_outline_sharp, size: 60, color: Colors.white,),
              ),
              Container(child: new VideoPlayer(_controller)),
            ],
          ),
        );
      } */

       Widget thevideoSize(VideoCast theVideo, BuildContext context, int index) {
         var vidImage =  (theVideo.image != null) ? NetworkImage(theVideo.image) 
        : AssetImage("assets/glc logo 1.png");

        String videoTime = (theVideo.duration != null) ? theVideo.duration : " ";

        return Padding(
          padding: const EdgeInsets.all(18.0),
          child: InkWell(
            hoverColor: Colors.blue[800],
            onTap: () {
              var route = new MaterialPageRoute(
                builder: (BuildContext context) =>
                new VideoPlayerApp(url: theVideo.watchIt,),
              );
              Navigator.of(context).push(route);
            },
            child: Container(
              height: 320,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: Color.fromRGBO(247, 247, 247, 1),
                //color: Colors.black12,
              ),
              child: Column(
                children: [
                  Expanded(
                    flex: 750,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        image: DecorationImage(
                          fit: BoxFit.fill,
                          image: vidImage,
                        )
                      ),

                      child: Stack(
                        children: [
                          Align(
                            alignment: Alignment.center,
                            child: Container(
                              padding: EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                border: Border.all(width: 4, color: Colors.white,),
                                shape: BoxShape.circle,
                              ),
                              child: Icon(Icons.play_arrow, color: Colors.white, size: 34, )
                            ),
                          ),

                          Align(
                            alignment: Alignment.bottomCenter,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(videoTime, 
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 12,
                                    ),
                                  ),

                                  Row(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Icon( Icons.calendar_today_outlined, size: 17, color: Colors.white, ),
                                      Flexible(
                                        child: Text(theVideo.date,
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 12,
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
                    flex: 250,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Center(
                          child: Text(theVideo.name,
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
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
                /* return GestureDetector(
                  onTap: () async {
                    var route = new MaterialPageRoute(
                      builder: (BuildContext context) =>
                      new VideoPlayerApp(url: theVideo.watchIt,),
                    );
                    Navigator.of(context).push(route);
                  },
                 // child: 
        ); */
      }

        Widget build(context) {
          return ListView.builder(
          itemCount: thevideoers.length,
          itemBuilder: (context, int currentInd){
            //listenIcon = (currentInd == playingFrom) ? Icons.pause : Icons.headset;
            return thevideoSize(thevideoers[currentInd], context, currentInd);
            //List_video(thevideoers[currentInd], context, currentInd);
          },
        );
        }

}