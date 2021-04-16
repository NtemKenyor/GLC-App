import 'dart:async';

import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

//void main() => runApp(VideoPlayerApp());


class AudioPlayerApp extends StatefulWidget {
  AudioPlayerApp({Key key}) : super(key: key);

  @override
  _AudioPlayerScreenState createState() => _AudioPlayerScreenState();
}

class _AudioPlayerScreenState extends State<AudioPlayerApp> {
   AudioPlayer audioPlayer = AudioPlayer();
   //AudioPlayer.logEnabled = true;
   
   play() async {
    int result = await audioPlayer.play("");
    if (result == 1) {
      // success
    }
  }

 /*  Future Todays_verse() async {

  String url = "https://a1in1.com/GLC/todays_verse.php";


  return get(url).then((Response response) {
    final int statusCode = response.statusCode;

    print(statusCode);
    print(response.headers);
    print(response.body);
    
    if (statusCode < 200 || statusCode > 400) {
      throw new Exception("Error while fetching data");
    }else if (response.body != ""){
      var json_received = json.decode(response.body);
      print(json_received);
      if ((response.body).contains("status")){
        if (json_received["status"] == "true"){
          print(json_received["msg"]);
          return show_today_verse(json_received["verse"]["verse"], json_received["verse"]["scripture"]);
          
        }else if(json_received["status"] == "false"){
          setState(() {
            today_verse = json_received["msg"];
          });
        }
        //display_result(error_gotten);
        //print(error_gotten);
      }
    }else{
      
    }
    
    //return json_received;
  });
} */

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body: Container(
        child: FlatButton(
          onPressed: null, 
          child: Text("Click to Play"),
        ),
      ),// This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}