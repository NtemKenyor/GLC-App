
import 'package:GLC/utils/dateutils.dart';
import 'package:GLC/utils/pallet.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'controller/bible_verse_controller.dart';
import 'stream_video/watch_stream.dart';
import 'notes/list_notes.dart';
import 'beyond_pulpit/beyondPulpit.dart';

class all_videos extends StatefulWidget {
  all_videos({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _all_videosState createState() => _all_videosState();
}

class _all_videosState extends State<all_videos> {
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


  final BibleVerseController verseController = Get.put(BibleVerseController());

 var  currentTabIndex = 0;
  
  @override
  Widget build(BuildContext context) {
    final tab = TabBar(
        onTap: (index){
          setState(() {
            currentTabIndex = index;
          });
        },
        indicatorColor: Colors.white,
        labelStyle: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold,),
      tabs: [

      //   Tab( child: Container(
      //       padding: EdgeInsets.all(10),
      //       alignment: Alignment.center,
      //       height: double.infinity,
      //       width: double.infinity,
      //       child:Text("Live", style:TextStyle(color:currentTabIndex== 0? Colors.white:Colors.grey)), decoration:BoxDecoration(
      //     color:currentTabIndex==0? Colors.black54:null,
      //     borderRadius: BorderRadius.all(Radius.circular(10)),
      //   )),),
        Tab( child: Container(
            padding: EdgeInsets.all(10),
            alignment: Alignment.center,
            height: double.infinity,
            width: double.infinity,
            child:Text("Bible", style:TextStyle(color:currentTabIndex== 0? Colors.white:Colors.grey)), decoration:BoxDecoration(
          color:currentTabIndex==0? Pallet.primaryColor:null,
          borderRadius: BorderRadius.all(Radius.circular(10)),
        )),),
        Tab( child: Container(
            alignment: Alignment.center,
            height: double.infinity,
            width: double.infinity,
            child:Text("Notes", style:TextStyle(color:currentTabIndex== 1? Colors.white:Colors.grey)), decoration:BoxDecoration(
          color:currentTabIndex== 1? Pallet.primaryColor:null,
          borderRadius: BorderRadius.all(Radius.circular(10)),
        )),),
    ]);

    return DefaultTabController(length: 2,
        child: Scaffold(
        backgroundColor: Pallet.white,
        appBar: PreferredSize(
          child:  Container(
            padding:EdgeInsets.all(10),
            color: Colors.white,
            child: Column(
              mainAxisSize:MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                        height: 60.h,width:50.w,decoration: BoxDecoration(
                      color:Pallet.white,
                        image: DecorationImage(
                          image: AssetImage("assets/live.jpg"),
                          fit: BoxFit.contain,
                        ),
                    )),
                    Text(DateUtil.format(DateTime.now()), style:TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold))
                  ],
                ),
                //SizedBox(height: 10.h,),

                WatchLiveWidget(),
                SizedBox(height: 10.h,),
                tab,
              ],
            ),
          ),  
          preferredSize: Size(double.infinity,360.h),
        ),
        body: TabBarView(
          children: <Widget>[
            BibleVerseWidget(bibleVerseController: verseController,),
            NotedPadWidget(),
          ]
        ),


        
        
      ),
    );
  }
}