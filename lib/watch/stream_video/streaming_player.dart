import 'dart:async';
import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';


class VideoPlayerApp_Live extends StatefulWidget {
  final String url;
  VideoPlayerApp_Live({Key key, this.url}) : super(key: key);
  
  @override
  _VideoPlayerScreenState createState() => _VideoPlayerScreenState(url: url);
}

class _VideoPlayerScreenState extends State<VideoPlayerApp_Live> {
  final String url;
  _VideoPlayerScreenState({this.url});

  //VideoPlayerController _controller;
  Future<void> _initializeVideoPlayerFuture;
  var the_video_url = "";
  //final String videoID = "";
  
  youtube() {
    String videoId = YoutubePlayer.convertUrlToId(url);
    YoutubePlayerController _controller = YoutubePlayerController(
        initialVideoId: videoId,
        flags: YoutubePlayerFlags(
            autoPlay: true,
            isLive: true,
            //mute: true,
        ),
    );

    return _controller;
  }
  /* YoutubePlayerController _controller = YoutubePlayerController(
    
    initialVideoId: this.url,
    flags: YoutubePlayerFlags(
        autoPlay: true,
        //isLive: true,
        //mute: true,
    ),
); */

/* YoutubePlayer(
    controller: _controller,
    showVideoProgressIndicator: true,
    videoProgressIndicatorColor: Colors.amber,
    progressColors: ProgressColors(
        playedColor: Colors.amber,
        handleColor: Colors.amberAccent,
    ),
    onReady () {
        _controller.addListener(listener);
    },
); */

/* YoutubePlayerBuilder(
    player: const YoutubePlayer(
        controller: _controller,
    ),
    builder: (context, player){
        return Column(
            children: [
                // some widgets
                player,
                //some other widgets
            ],
        );
    }
  ); */

  @override
  Widget build(BuildContext context) {
    return /* Scaffold(
      
      body: Center(
        child: */ Container(
          color: Colors.white,
          //child: Column(
            //mainAxisAlignment: MainAxisAlignment.center,
            //children: [
              child: Center(
                child: Expanded(
                  child: YoutubePlayer(
                    controller: youtube(),

                  ),
                ),
                
                /* YoutubePlayerBuilder(
                    player: YoutubePlayer(
                         controller: _controller,
                        //controller: _controller,
                    ),
                    builder: (context, player){
                        return Column(
                            children: [
                                // some widgets
                                player,
                                //some other widgets
                            ],
                        );
                    },
                ), */
              ),
           // ],
         // ),
      /*   ),
      ), */
     /*  floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Wrap the play or pause in a call to `setState`. This ensures the
          // correct icon is shown.
          setState(() {
            // If the video is playing, pause it.
            if (_controller.value.isPlaying) {
              _controller.pause();
            } else {
              // If the video is paused, play it.
              _controller.play();
            }
          });
        },
        // Display the correct icon depending on the state of the player.
        child: Icon(
          _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
        ),
      ), */ // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}