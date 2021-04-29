//import 'dart:html';

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
//import 'package:pull_to_refresh/pull_to_refresh.dart';

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

class Podcast {
  //final String id;
  final String pod_name, date, imageUrl, listen;

  Podcast({
    this.pod_name,
    this.date,
    this.imageUrl,
    this.listen,
  });

  factory Podcast.fromJson(Map<String, dynamic> jsonData) {
    return Podcast(
      pod_name: jsonData['title'],
      date: jsonData['date'],
      //imageUrl: "https://a1in1.com/GLC/images/"+jsonData['image'],
      //listen: "https://a1in1.com/GLC/media_files/"+jsonData['location'],
      imageUrl: jsonData['photo'],
      listen: jsonData['file'],
    );
  }
}

class media_page extends StatefulWidget {
  media_page({Key key, this.title}) : super(key: key);

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

class _MyHomePageState extends State<media_page> {
  int _counter = 0;
  int _selectedIndex = 0;

/*   //Color yellow = Color(0xFFC50C);
  Color yellow_ = Color.fromRGBO(255, 197, 12, 1);
  //Color red = Color(0xF15922);
  Color red_color = Color.fromRGBO(241, 89, 34, 1);
  //Color bright = Color(0xC4C4C4);
  Color bright_ = Color.fromRGBO(196, 196, 196, 1);
  //Color dark = Color(0x776666);
  Color dark_ = Color.fromRGBO(119, 102, 102, 1);
  //Color.fromRGBO(255, 255, 255, 1)
  Color pure_ = Color.fromRGBO(255, 255, 255, 1); */

  /* takeHome(){
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (BuildContext context) => user_connect() ),
        (Route<dynamic> route ) => false
      );
  } */

  
  read_from_SP(key) async{
    SharedPreferences pref = await SharedPreferences.getInstance();
    String content = pref.getString(key);
    return content;
  }

Future<List<Podcast>> downloadJSON() async {
  final jsonEndpoint = 'https://app.glclondon.church/api/content/podcasts/';
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
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("Podcast", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 19,),),
            ),
            Expanded(
              //flex: 900,
              child: FutureBuilder<List<Podcast>>(
            future: downloadJSON(),
            //we pass a BuildContext and an AsyncSnapshot object which is an
            //Immutable representation of the most recent interaction with
            //an asynchronous computation.
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                spacecrafts = snapshot.data;
                return RefreshIndicator(
                    onRefresh: ()  {
                      return Future.delayed(
                        Duration(seconds: 3), () async {
                          var content = await downloadJSON();
                          setState(() {
                            spacecrafts = content;
                          });

                           ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Page Refreshed'),
                            ),
                          );

                        }
                      );
                    },
                    //enablePullUp: true,
                    //controller: ,
                    child: Container(
                      color: Colors.black,
                      child: new CustomListView(spacecrafts: spacecrafts,)
                    ),
                );
              } else if (snapshot.hasError) {
                return new Container(
                  decoration: BoxDecoration(
                      image: DecorationImage(image: AssetImage("assets/peas-nointernet.gif"), fit: BoxFit.fill)
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text('We are having some problems connecting to the server'),
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
                            color: Colors.blue, fontWeight: FontWeight.w800,
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

          ]
        ),
      ),
    );
  }
}


class CustomListView extends StatefulWidget {
  CustomListView({Key key, this.title, this.spacecrafts}) : super(key: key);

  final String title;
  final List<Podcast> spacecrafts;
  //CustomListView(this.spacecrafts);

  //final List<Podcast> spacecrafts;
  //CustomListView(this.spacecrafts);

  @override
  _CustomListViewState createState() => _CustomListViewState(spacecrafts);
}
class _CustomListViewState extends State<CustomListView> {
      final List<Podcast> spacecrafts;
      _CustomListViewState(this.spacecrafts);
      /* final List<Podcast> spacecrafts;
      CustomListView(this.spacecrafts); */

      AudioPlayer audioPlayer = AudioPlayer();
      //AudioPlayer.logEnabled = true;
      String podUrl;
      
      IconData listenIcon = Icons.headset;
        
      int podcastState = 0;
      play(podcast_path, index) async {
        print("Playing from online media...");
        if (podcastState == 0){
          int confirm = await audioPlayer.play(podcast_path);
          if (confirm == 1) {
            playing_index(index);
            podcastState = 1;
          }
        }else{
          int confirmStop = await audioPlayer.stop();
          if (confirmStop == 1){
            //listenIcon = Icons.headset;
            podcastState = 0;
          }
        }
      }

      int playingFrom = -1;
      playing_index(int selectedIndex){
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

        if (await appLocal.exists() ){
          return temppath;
        }else{
          return appLoc;
        }
      }

      void makeHappen(String link) async{
        String localPath = await getLocation();
        //DownloadStuffs(link, localPath);
        playLocal(localPath);

      }

      Widget displayer(test, context){
        final snackBar = SnackBar(content: Text(test),);
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }

      Widget List_home (Podcast cord, BuildContext context, int index) {
        var theImager =  (cord.imageUrl != null) ? Image.network(cord.imageUrl, fit: BoxFit.cover, height: double.infinity,) 
        : Image.asset("assets/glc logo 1.png", fit: BoxFit.cover, height: double.infinity,);

                return GestureDetector(
                  onTap: () async {
                    var route = new MaterialPageRoute(
                      builder: (BuildContext context) =>
                      new AudioPlayerApp(audioUrl: cord.listen, audioTitle: cord.pod_name, audioImage: cord.imageUrl, ),
                    );
                    Navigator.of(context).push(route);
                  },
                  child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        //child: Text("Hello Guys")
                        height: 160,
                        color: pure_,
                        child: Column(
                          //mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.fromLTRB(8, 1, 8, 12),
                              child: Divider(thickness: 2, height: 3, color: dark_,),
                            ),
        
                            Expanded(
                                child: Row(
                                children: <Widget>[
                                  Expanded(
                                    flex: 400,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Container(
                                        
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.circular(12),
                                          child: theImager,
                                ),
                                //child: Image.asset("assets/blog_person.jpg", fit: BoxFit.fitHeight,)
                              ),
                            ),
                          ),

                          Expanded(
                            flex: 600,
                            child: Container(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  //mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    Expanded(child: Text(cord.pod_name, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16,),)),
                                    Expanded(
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: <Widget>[
                                          Icon(Icons.calendar_today, color: yellow_,),
                                          Flexible(
                                            child: Text(cord.date, maxLines: 1, style: TextStyle(fontWeight: FontWeight.w800))
                                          ),
                                        ]
                                        //trailing: Text("Monday, 21st October"),
                                      ),
                                    ),

                                    Expanded(
                                      child: InkWell(
                                        hoverColor: Colors.amber[700],
                                        onTap: () {
                                          displayer("Processing Audio.", context);
                                          playingFrom = (playingFrom > 0) ? -1 : playingFrom;
                                          play(cord.listen, index);
                                          
                                        },
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          children: <Widget>[
                                            Icon(listenIcon, color: yellow_,),
                                            Flexible(
                                              child: Text("Listen", maxLines: 1, style: TextStyle(fontWeight: FontWeight.w800))
                                            ),
                                          ]
                                          //trailing: Text("Monday, 21st October"),
                                        ),
                                      ),
                                    ),

                                    Expanded(
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: yellow_,
                                          borderRadius: BorderRadius.circular(12)
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: GestureDetector(
                                            //podUrl = await cord.listen;
                                            //hoverColor: Colors.green[800],
                                            onTap: () async {
                                              WidgetsFlutterBinding.ensureInitialized();
                                              await FlutterDownloader.initialize();

                                              /* Directory just_test = await getApplicationDocumentsDirectory();
                                              print(just_test); */
                                              

                                              /* Directory("GLC").createSync(recursive: true);
                                              String right = Directory("GLC").path;
                                              print(right); */
                                              String path2Save = await getLocation();
                                              Directory(path2Save).createSync(recursive: true);
                                              Directory saveHere = Directory(path2Save);
                                              if (await saveHere.exists()){
                                                await FlutterDownloader.enqueue(
                                                  url: cord.listen,
                                                  savedDir: saveHere.path,
                                                  showNotification: true,
                                                  openFileFromNotification: true,
                                                  fileName:cord.pod_name,
                                                  //cord.listen, saveHere.path, cord.pod_name, null
                                                //url: cord.listen,
                                                //savedDir: saveHere.path,
                                                //showNotification: true, // show download progress in status bar (for Android)
                                                //openFileFromNotification: true, // click on notification to open downloaded file (for Android)
                                              );
                                              displayer("Processing Download.", context);
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
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              children: <Widget>[
                                                Icon(Icons.file_download, color: pure_,),
                                                Text("Download", maxLines: 1, style: TextStyle(fontWeight: FontWeight.w800),),
                                              ]
                                            ),
                                          ),
                                        ),
                                      ),
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
                )
              ),
            ),
        );
      }

        Widget build(context) {
          return ListView.builder(
          itemCount: spacecrafts.length,
          itemBuilder: (context, int currentInd){
            listenIcon = (currentInd == playingFrom) ? Icons.pause : Icons.headset;
            return List_home(spacecrafts[currentInd], context, currentInd);
          },
        );
        }

}



