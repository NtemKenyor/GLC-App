//import 'dart:html';

import 'package:GLC/watch/model/podcast_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

//import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:path_provider/path_provider.dart';
import 'audio.dart';
import 'dart:io';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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



class PodCastPage extends StatefulWidget {
  @override
  _PodCastPageState createState() => _PodCastPageState();
}

class _PodCastPageState extends State<PodCastPage> {
  read_from_SP(key) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String content = pref.getString(key);
    return content;
  }

  Future<List<Podcast>> fetchPodcasts() async {
    final jsonEndpoint = 'https://app.glclondon.church/api/content/podcasts/';
    //String token = "Bearer " + await read_from_SP("token");
    Response response = await get(Uri.parse(jsonEndpoint),
      // headers: {"authorization": token, "accept": "application/json"}
    );
    int statusCode = response.statusCode;
    print(jsonDecode(response.body));
    if (statusCode < 200 || statusCode > 400) {
      print("jobs fix");
      throw Exception(
          'We were not able to successfully download the json data.');
    } else {
      print("here");
      var content = json.decode(response.body);
      List nuesa_news = content["results"] as List;
      return nuesa_news
          .map((nuesa_news) => new Podcast.fromJson(nuesa_news))
          .toList();
    }
  }

  // This is optional. This is not requred always
  GlobalKey<ScaffoldState> _scaffoldKey;

  // This method will run once widget is loaded
  // i.e when widget is mounting
  @override
  void initState() {
    _scaffoldKey = GlobalKey();
    super.initState();
  }

  @override
  void dispose() {
    // disposing states
    _scaffoldKey?.currentState?.dispose();
    super.dispose();
  }

  List<Podcast> spacecrafts;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: pure_,
      body: Container(
        //color: Colors.pink,
        child: Column(
          //scrollDirection: Axis.vertical,
            children: <Widget>[
              Expanded(
                child: FutureBuilder<List<Podcast>>(
                  future: fetchPodcasts(),
                  //we pass a BuildContext and an AsyncSnapshot object which is an
                  //Immutable representation of the most recent interaction with
                  //an asynchronous computation.
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      spacecrafts = snapshot.data;
                      return RefreshIndicator(
                        onRefresh: () {
                          return Future.delayed(Duration(seconds: 3), () async {
                            var content = await fetchPodcasts();
                            setState(() {
                              spacecrafts = content;
                            });

                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('Page Refreshed'),
                              ),
                            );
                          });
                        },
                        //enablePullUp: true,
                        //controller: ,
                        child: Container(
                            child: new CustomListView(
                              spacecrafts: spacecrafts,
                            )),
                      );
                    } else if (snapshot.hasError) {
                      return new Container(
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage("assets/peas-nointernet.gif"),
                                fit: BoxFit.fill)),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                  'We are having some problems connecting to the server'),
                            ),
                          ],
                        ),
                      );
                    }
                    //return  a circular progress indicator.
                    return new Container(
                      /* decoration: BoxDecoration(
                  image: DecorationImage(image: AssetImage("assets/nuesa_background1.gif"), fit: BoxFit.fill)
                ), */
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            CircularProgressIndicator(),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                "Loading...",
                                style: TextStyle(
                                  color: Colors.blue,
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ]),
      ),
    );
  }
}


class CustomListView extends StatefulWidget {
  CustomListView({Key key, this.title, this.spacecrafts}) : super(key: key);

  final String title;
  final List<Podcast> spacecrafts;

  @override
  _CustomListViewState createState() => _CustomListViewState(spacecrafts);
}

class _CustomListViewState extends State<CustomListView> {
  final List<Podcast> spacecrafts;

  _CustomListViewState(this.spacecrafts);

  AudioPlayer audioPlayer = AudioPlayer();

  //AudioPlayer.logEnabled = true;
  String podUrl;

  IconData listenIcon = Icons.play_arrow_rounded;

  int podcastState = 0;

  play(podcast_path, index) async {
    print("Playing from online media...");
    if (podcastState == 0) {
      int confirm = await audioPlayer.play(podcast_path);
      if (confirm == 1) {
        playing_index(index);
        podcastState = 1;
      }
    } else {
      int confirmStop = await audioPlayer.stop();
      if (confirmStop == 1) {
        //listenIcon = Icons.headset;
        podcastState = 0;
      }
    }
  }

  int playingFrom = -1;

  playing_index(int selectedIndex) {
    setState(() {
      playingFrom = selectedIndex;
    });
  }

  playLocal(localPath) async {
    print("Try to play locally... ");
    int result = await audioPlayer.play(localPath, isLocal: true);
    if (result == 1) {
      // success
    }
  }

  /* DownloadStuffs(String urlLink, String path) async {
        print("Downloading... ");
        final taskId = await FlutterDownloader.enqueue(
          url: urlLink,
          savedDir: path,
          showNotification: true, // show download progress in status bar (for Android)
          openFileFromNotification: true, // click on notification to open downloaded file (for Android)
        );
      } */

  getLocation() async {
    print("Get the Location ready... ");
    Directory appLocal = await getApplicationDocumentsDirectory();
    String temppath = appLocal.path;

    Directory appDorDir = await getTemporaryDirectory();
    String appLoc = appDorDir.path;

    if (await appLocal.exists()) {
      return temppath;
    } else {
      return appLoc;
    }
  }

  void makeHappen(String link) async {
    String localPath = await getLocation();
    //DownloadStuffs(link, localPath);
    playLocal(localPath);
  }

  Widget displayer(test, context) {
    final snackBar = SnackBar(
      content: Text(test),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  Widget imageWidget(var theImager, String date) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: theImager,
          ),
          Positioned(
            left: 40,
            top: 40,
            child: Container(
              // /margin:EdgeInsets.only(right: 50),
              height: 40.h,
              width: 40.w,
                decoration: BoxDecoration(
                  color:Colors.white,
                    shape: BoxShape.circle,),
                child: Icon(Icons.play_arrow_rounded, color: Colors.black,size:25)),
          ),
          // Align(
          //   alignment: Alignment.bottomCenter,
          //   child: Padding(
          //     padding: EdgeInsets.all(5),
          //     child: Row(
          //         mainAxisAlignment: MainAxisAlignment.start,
          //         children: <Widget>[
          //           Icon(
          //             Icons.calendar_today,
          //             color: Colors.white,
          //             size: 18,
          //           ),
          //           SizedBox(width: 2),
          //           Flexible(
          //               child: Text(date,
          //                   maxLines: 1,
          //
          //                   style: TextStyle(color: Colors.white,fontSize: 12))),
          //         ]
          //         //trailing: Text("Monday, 21st October"),
          //         ),
          //   ),
          // )
        ],
      ),
    );
  }

  Widget List_home(Podcast cord, BuildContext context, int index) {
    var theImager = (cord.imageUrl != null)
        ? Image.network(
            cord.imageUrl,
            fit: BoxFit.fitWidth,
            height: double.infinity,
          )
        : Image.asset(
            "assets/glc logo 1.png",
            fit: BoxFit.cover,
            height: double.infinity,
          );

    return GestureDetector(
      onTap: () async {
        var route = new MaterialPageRoute(
          builder: (BuildContext context) => new AudioPlayerApp(
            audioUrl: cord.listen,
            audioTitle: cord.pod_name,
            audioImage: cord.imageUrl,
          ),
        );
        Navigator.of(context).push(route);
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
            decoration: BoxDecoration(
              //color: Colors.grey.shade200,
              borderRadius: BorderRadius.all(Radius.circular(20)),
            ),
            height: 140.h,
            child: Column(
              //mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Expanded(
                  child: Row(
                    children: <Widget>[
                      Expanded(
                          flex: 400, child: imageWidget(theImager, cord.date)),
                      Expanded(
                        flex: 500,
                        child: Container(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                Text(
                                  cord.date,
                                  style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16.sp,
                                  ),
                                ),
                                SizedBox(
                                  height: 10.h,
                                ),
                                Text(
                                  cord.pod_name,
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 14.sp,
                                  ),
                                ),
                                SizedBox(
                                  height: 20.h,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.start,
                                  children: [
                                    InkWell(
                                      hoverColor: Colors.amber[700],
                                      onTap: () {
                                        displayer("Processing Audio.", context);
                                        playingFrom = (playingFrom > 0)
                                            ? -1
                                            : playingFrom;
                                        play(cord.listen, index);
                                      },
                                      child: Container(
                                        width: 100.w,
                                        padding: EdgeInsets.all(5),
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(10))),
                                        child: Row(
                                           // mainAxisSize: MainAxisSize.max,
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: <Widget>[
                                              Icon(
                                                listenIcon,
                                                color: yellow_,
                                              ),
                                              Flexible(
                                                  child: Text("Play Audio",
                                                      maxLines: 1,
                                                      style: TextStyle(
                                                          fontWeight: FontWeight
                                                              .w800))),
                                            ]
                                            //trailing: Text("Monday, 21st October"),
                                            ),
                                      ),
                                    ),
                                    SizedBox(width: 20,),
                                    Container(
                                      decoration: BoxDecoration(
                                          color: yellow_,
                                          borderRadius:
                                              BorderRadius.circular(12)),
                                      child: Padding(
                                        padding: const EdgeInsets.all(5.0),
                                        child: GestureDetector(
                                          //podUrl = await cord.listen;
                                          //hoverColor: Colors.green[800],
                                          onTap: () async {
                                            WidgetsFlutterBinding
                                                .ensureInitialized();
                                            await FlutterDownloader
                                                .initialize();

                                            /* Directory just_test = await getApplicationDocumentsDirectory();
                                              print(just_test); */

                                            /* Directory("GLC").createSync(recursive: true);
                                              String right = Directory("GLC").path;
                                              print(right); */
                                            String path2Save =
                                                await getLocation();
                                            Directory(path2Save)
                                                .createSync(recursive: true);
                                            Directory saveHere =
                                                Directory(path2Save);
                                            if (await saveHere.exists()) {
                                              await FlutterDownloader.enqueue(
                                                url: cord.listen,
                                                savedDir: saveHere.path,
                                                showNotification: true,
                                                openFileFromNotification: true,
                                                fileName: cord.pod_name,
                                                //cord.listen, saveHere.path, cord.pod_name, null
                                                //url: cord.listen,
                                                //savedDir: saveHere.path,
                                                //showNotification: true, // show download progress in status bar (for Android)
                                                //openFileFromNotification: true, // click on notification to open downloaded file (for Android)
                                              );
                                              displayer("Processing Download.",
                                                  context);
                                            }

                                            /* String localPath = await get_location();

                                              if (localPath != ""){
                                                //await ;
                                                if (DownloadStuffs(cord.listen, localPath)){
                                                  await playLocal(localPath);
                                                }

                                              }

                                              //makeHappen(cord.listen); */
                                          },
                                          child: Row(
                                              mainAxisSize: MainAxisSize.min,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: <Widget>[
                                                Icon(
                                                  Icons.download_rounded,
                                                  color: pure_,
                                                ),
                                              ]),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            )),
      ),
    );
  }

  Widget build(context) {
    return ListView.builder(
      itemCount: spacecrafts.length,
      itemBuilder: (context, int currentInd) {
        listenIcon = (currentInd == playingFrom) ? Icons.pause : Icons.headset;
        return List_home(spacecrafts[currentInd], context, currentInd);
      },
    );
  }
}
