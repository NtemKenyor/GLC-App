import 'dart:async';
import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

//void main() => runApp(VideoPlayerApp());

class AudioPlayerApp extends StatefulWidget {
  final String audioUrl, audioTitle, audioImage;
  AudioPlayerApp({Key key, this.audioUrl, this.audioTitle, this.audioImage}) : super(key: key);

  
  @override
  _AudioPlayerScreenState createState() => _AudioPlayerScreenState(audioUrl: audioUrl, audioTitle: audioTitle, audioImage: audioImage);
}

class _AudioPlayerScreenState extends State<AudioPlayerApp> with SingleTickerProviderStateMixin {
  final String audioUrl, audioTitle, audioImage; 
  _AudioPlayerScreenState({this.audioUrl, this.audioTitle, this.audioImage});
   AudioPlayer audioPlayer = AudioPlayer();
   //AudioPlayer.logEnabled = true;

   
  int playerStatus = 0;
  checkPlay(podcastPath) async {
    if (playerStatus == 0 && podcastPath != ""){
      play(podcastPath);
    }else{
      pause();
    }
  }
  play(podcastPath) async {
    print("Playing from online media...");
    int result = await audioPlayer.play(podcastPath);
    if (result == 1) {
      rebuild(Icon(Icons.pause));
      playerStatus = 1;
      _controller.forward();
      _controller.repeat();
    }
  }

  pause() async{
    int result = await audioPlayer.pause();
    if (result == 1){
      rebuild(Icon(Icons.play_arrow));
      //playStatusIcon = Icon(Icons.play_arrow);
      playerStatus = 0;
      _controller.stop();
    }
  }

  stop() async{
    int result = await audioPlayer.stop();
    if(result == 1){
      playerStatus = 0;
    }
  }

  seekForward() async{
    int result = await audioPlayer.seek(Duration(milliseconds: 1200));
  }

  seekBackward() async{
    int result = await audioPlayer.seek(Duration(milliseconds: -1200));
  }

  Icon playStatusIcon = Icon(Icons.play_arrow);
  AnimationController _controller;

  rebuild(playIcons){
    setState(() {
      playStatusIcon = playIcons;
    });
  }
  Widget displayer(test, context){
    final snackBar = SnackBar(content: Text(test),);
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  @override
  void initState(){
    _controller = AnimationController(
      duration: const Duration(milliseconds: 5000),
      vsync: this,
    );
    super.initState();
  }

  @override
  void dispose(){
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    /* if (audioHttp != ""){
      play(audioHttp);
    } */
    //checkPlay(audioHttp);
    //print("This is the para: " + audioTitle);
    return Scaffold(
      
      body: Container(
        child: Column(
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Stack(
                    children: [
                      Container(
                        height: 280,
                        width: double.infinity,
                        child: Image.network(audioImage, fit: BoxFit.cover,)
                      ),
                      Center(
                        child: Align(
                          alignment: Alignment.bottomLeft,
                          child: Text(
                            " Playing: "+ audioTitle,
                            style: TextStyle(
                              color: Colors.indigo, 
                              backgroundColor: Colors.white54,
                              fontWeight: FontWeight.w700,
                              fontSize: 18,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),

                  Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: RotationTransition(
                      turns: Tween(begin: 0.0, end: 1.0).animate(_controller),
                      child: Container(
                        height: 120,
                        width: 120,
                        decoration: BoxDecoration(
                          color: Colors.blue[800],
                          shape: BoxShape.circle,
                          //borderRadius: BorderRadius.circular(50),
                          image: DecorationImage(
                            image: NetworkImage(audioImage),
                            fit: BoxFit.cover,
                          ),
                        ),
                        //child: Image.network(audioImage, fit: BoxFit.cover,),
                      ),
                    ),
                  ),

                  //ProgressIndicator(value = null),
                  
                  
                ],
              ),
            ),

            
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.indigo,
                        shape: BoxShape.circle,
                      ),
                      padding: EdgeInsets.all(3),
                      child: IconButton(
                        icon: Icon(Icons.skip_previous), 
                        onPressed: () async =>{
                          seekBackward()
                        },
                      ),
                    ),

                    Container(
                      decoration: BoxDecoration(
                        color: Colors.indigo,
                        shape: BoxShape.circle,
                      ),
                      padding: EdgeInsets.all(12),
                      child: IconButton(
                        icon: playStatusIcon, 
                        onPressed: () async =>{
                          displayer("Connecting to Podcast", context),
                          checkPlay(audioUrl),
                        },
                      ),
                    ),

                    Container(
                      decoration: BoxDecoration(
                        color: Colors.indigo,
                        shape: BoxShape.circle,
                      ),
                      padding: EdgeInsets.all(3),
                      child: IconButton(
                        icon: Icon(Icons.skip_next), 
                        onPressed: () async =>{
                          seekForward()
                        },
                      ),
                    ),
                  ],
                )
              ),
            )
          ],
        ),
        //child: Text(audioHttp + audioTitle + audioViwer + "OK"),

         /*child:  Column(
          children: <Widget>[
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(
                  left: 0.0,
                  right: 0.0,
                  top: 0.0,
                  bottom: 0.0,
                ),
                child: Container(
                  //height: 120,
                  decoration: BoxDecoration(
                    //borderRadius: BorderRadius.circular(50),
                    shape: BoxShape.circle,
                  ),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      " Playing: "+ audioTitle,
                      style: TextStyle(
                        color: Colors.indigo, 
                        backgroundColor: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ]
        ),
      ),*/
      )
      
    );
    
  }
  
} 