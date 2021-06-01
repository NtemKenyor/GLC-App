
import 'package:GLC/utils/pallet.dart';
import 'package:flutter/material.dart';
import 'package:GLC/ui/media/videos/podvideo.dart';
import 'podcast/media.dart';

class MediaPage extends StatefulWidget {
  @override
  _MediaPageState createState() => _MediaPageState();
}

class _MediaPageState extends State<MediaPage> {
  int currentTabIndex =0;

  @override
  Widget build(BuildContext context) {
    final tab = TabBar(
        indicatorColor: Colors.white,
        onTap: (index){
          setState(() {
            currentTabIndex = index;
          });
        },
        labelStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold,),
        tabs: [
          //Tab( text: "GLC Chat Room", ),
          Tab( child: Container(
              padding: EdgeInsets.all(10),
              alignment: Alignment.center,
              height: double.infinity,
              width: double.infinity,
              child:Text("Podcast", style:TextStyle(color:currentTabIndex!= 1? Colors.white:Colors.grey)), decoration:BoxDecoration(
            color:currentTabIndex!= 1? Pallet.primaryColor:null,
            borderRadius: BorderRadius.all(Radius.circular(10)),
          )),),
          Tab( child: Container(
              alignment: Alignment.center,
              height: double.infinity,
              width: double.infinity,
              child:Text("Videos", style:TextStyle(color:currentTabIndex!= 1? Colors.grey:Colors.white)), decoration:BoxDecoration(
            color:currentTabIndex!= 1? null:Pallet.primaryColor,
            borderRadius: BorderRadius.all(Radius.circular(10)),
          )),),
        ]);

    return DefaultTabController(length: 2,
      child: Scaffold(

        appBar: PreferredSize(
          child:  Padding(
            padding:EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            child: Container(
              height: 50,
              color: Colors.white,
              child: tab,
            ),
          ),
          preferredSize: Size(double.infinity, 80),
        ),
        body: TabBarView(
            children: <Widget>[
              PodCastPage(),
              PodVideoPage()
              //VideosPage(),

            ]
        ),




      ),
    );
  }
}
