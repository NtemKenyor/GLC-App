//import 'dart:html';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
//import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

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
      imageUrl: "https://a1in1.com/GLC/images/"+jsonData['image'],
      listen: "https://a1in1.com/GLC/media_files/"+jsonData['location'],
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


  Future<List<Podcast>> downloadJSON() async {
  final jsonEndpoint =
      "https://a1in1.com/GLC/media_files.php";

  final response = await get(Uri.parse(jsonEndpoint));

  if (response.statusCode == 200) {
    List nuesa_news = json.decode(response.body);
    return nuesa_news
        .map((nuesa_news) => new Podcast.fromJson(nuesa_news))
        .toList();
  } else
    throw Exception('We were not able to successfully download the json data.');
}


  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
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
              child: new FutureBuilder<List<Podcast>>(
            future: downloadJSON(),
            //we pass a BuildContext and an AsyncSnapshot object which is an
            //Immutable representation of the most recent interaction with
            //an asynchronous computation.
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                List<Podcast> spacecrafts = snapshot.data;
                return Container(
                    color: Colors.black,
                    child: new CustomListView(spacecrafts));
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
                          child: Text('Look'+"'s"+ ' Like You do not have an Internat connection- Nuesa-Bot'),
                        ),
                    ],
                  ),
                );
              }
              //return  a circular progress indicator.
              return new Container(
                decoration: BoxDecoration(
                  image: DecorationImage(image: AssetImage("assets/nuesa_background1.gif"), fit: BoxFit.fill)
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


class CustomListView extends StatelessWidget {
  final List<Podcast> spacecrafts;
  CustomListView(this.spacecrafts);

  AudioPlayer audioPlayer = AudioPlayer();
  //AudioPlayer.logEnabled = true;
  String podUrl;
   
   play(podcast_path) async {
    print("Playing from online media...");
    int result = await audioPlayer.play(podcast_path);
    if (result == 1) {
      // success
    }
  }

  playLocal(localPath) async {
    print("Try to play locally... ");
    int result = await audioPlayer.play(localPath, isLocal: true);
    if (result == 1) {
      // success
    }
  }
  
  DownloadStuffs(String urlLink, String path) async* {
    print("Downloading... ");
    final taskId = await FlutterDownloader.enqueue(
      url: urlLink,
      savedDir: path,
      showNotification: true, // show download progress in status bar (for Android)
      openFileFromNotification: true, // click on notification to open downloaded file (for Android)
    );
  }

  get_location() async {
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
  
  void makeHappen(String link){
    String localPath = get_location();
    DownloadStuffs(link, localPath);
    playLocal(localPath);
  
  }
  
  Widget displayer(test, context){
    final snackBar = SnackBar(content: Text(test),);
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

   Widget build(context) {
      return ListView.builder(
      itemCount: spacecrafts.length,
      itemBuilder: (context, int currentInd){
        return List_home(spacecrafts[currentInd], context);
      },
    );
   }

   Widget List_home (Podcast cord, BuildContext context) {
    return InkWell(
      hoverColor: Colors.orange,
      onTap: () {
        //TODO
        //Playing the audio...

        /* var route = new MaterialPageRoute(
          builder: (BuildContext context) =>
          new SecondScreen(value: nuesa_news),
        );
        Navigator.of(context).push(route); */
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
                              child: Image.network(cord.imageUrl, 
                                fit: BoxFit.cover,
                                height: double.infinity,
                              )
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
                                      Text(cord.date, maxLines: 1, style: TextStyle(fontWeight: FontWeight.w800)),
                                    ]
                                    //trailing: Text("Monday, 21st October"),
                                  ),
                                ),

                                Expanded(
                                  child: GestureDetector(
                                    onTap: () {
                                      displayer("Processing Audio.", context);
                                      play(cord.listen);
                                    },
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: <Widget>[
                                        Icon(Icons.headset, color: yellow_,),
                                        Text("Listen", maxLines: 1, style: TextStyle(fontWeight: FontWeight.w800)),
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
                                        onTap: () async {
                                          WidgetsFlutterBinding.ensureInitialized();
                                          await FlutterDownloader.initialize();

                                          Directory just_test = await getApplicationDocumentsDirectory();
                                          print(just_test);

                                          Directory("/storage/emulated/O/GLC London").createSync(recursive: true);
                                          Directory saveHere = Directory("/storage/emulated/O/GLC London");
                                          await FlutterDownloader.enqueue(
                                            url: cord.listen,
                                            savedDir: saveHere.path,
                                            showNotification: true, // show download progress in status bar (for Android)
                                            openFileFromNotification: true, // click on notification to open downloaded file (for Android)
                                          );
                                          displayer("Processing Download.", context);
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
                                            Text("Donwload", maxLines: 1, style: TextStyle(fontWeight: FontWeight.w800),),
                                          ]
                                          //trailing: Text("Monday, 21st October"),
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
                      // Expanded(child: Divider(thickness: 20, height: 30, color: Colors.pink,))
                    ],
                  ),
                ),

                //Expanded(child: Divider(thickness: 20, height: 30, color: Colors.pink,),)
              ],
            )
          ),
        ),
    );
  }

}