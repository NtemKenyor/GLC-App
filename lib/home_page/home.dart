import 'dart:convert';
import 'package:GLC/home_page/model/event_model.dart';
import 'package:GLC/home_page/upcoming_widget.dart';
import 'package:GLC/prayer/prayer_request.dart';
import 'package:GLC/utils/pallet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:http/http.dart';
import 'dart:async';
import 'package:share/share.dart';
import 'package:shared_preferences/shared_preferences.dart';




class HomeScreen extends StatefulWidget {
  HomeScreen({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<HomeScreen> {
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
  Color likeColors = Colors.black;

  String today_verse = "";
  List defaultImgs = [
    new AssetImage('assets/glc logo 1.jpg'),
    new AssetImage('assets/glc logo 1.png'),
  ];

  show_today_verse(verse, verse_content){
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(23),
        color: pure_,
      ),
      height: 130,
      child: Column(
        children: <Widget>[
          Expanded(
            flex: 200, 
            child: Text(
              "Today's Verse", 
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            )
          ),
          Expanded(
            flex: 800,
              child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
              Expanded(
                flex: 250, 
                child: Text(verse, 
                  style: TextStyle(fontWeight: FontWeight.bold,)
              )),
              Expanded(
                  flex: 750,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    //crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                  
                      Expanded(
                        flex: 700,
                        child: Text(verse_content)
                      ),
                      Expanded(
                          flex: 300,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: <Widget>[
                              Expanded(child: 
                                FlatButton.icon(
                                  onPressed: (){
                                    setState(() {
                                      likeColors = Colors.blue;
                                    });
                                    //likeFunc ();
                                  }, 
                                  icon: Icon(Icons.thumb_up, color: likeColors), 
                                  label: Text("Like")
                                )
                              ),
                              Expanded(child: 
                                FlatButton.icon(
                                  onPressed: () {
                                    Share.share(verse_content+ " ("+verse + ") " );
                                  }, 
                                  icon: Icon(Icons.share), 
                                  label: Text("Share")
                                )
                              ),
                            ]
                          ),
                      )
                ],),
              )
            ],),
          ),
          
        ],),
        );
    }


Widget upcoming01(imageLink, date, time, venue) {
      return Padding(
        padding: EdgeInsets.all(12),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: pure_,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.5),
                  spreadRadius: 2,
                  blurRadius: 4,
                  offset: Offset(0,3),
                )
              ]
            ),
            child: Column(children: <Widget>[
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(imageLink),
              ),
              Row(
                children: <Widget>[
                  FlatButton.icon(onPressed: null, icon: Icon(Icons.calendar_today), 
                    label: Text(date)
                  ),

                  FlatButton.icon(onPressed: null, icon: Icon(Icons.access_time), 
                    label: Text(time)
                  ),
                ]
              ),

              Row(
                children: <Widget>[
                  FlatButton.icon(onPressed: null, icon: Icon(Icons.send), 
                    label: Text(venue)
                  ),
                ]
              )
            ],)
          ),
        );
    }

/*   shareVerse(){
    Share.share()
  } */

  static var picture_timer = Duration(seconds: 8);
  Widget the_moving_images(imgArried) {
    return new Container(
      decoration:BoxDecoration(
        borderRadius:BorderRadius.all(Radius.circular(20))
      ),
    child: new Carousel(
      images: imgArried,
      /* images: [
        new AssetImage('assets/old_man.jpg'),
        new AssetImage('assets/fitness.jpg'),
        new AssetImage('assets/blog_person.jpg'),
        new AssetImage('assets/person_1.png'),
        new AssetImage('assets/person_2.png'),
        new AssetImage('assets/person_3.png'),
      ], */
      autoplayDuration: picture_timer,
      animationCurve: Curves.easeInOutExpo,
      dotSize: 3.0,
      dotSpacing: 12.0,
      dotColor: Colors.orange,
      indicatorBgPadding: 2.0,
      borderRadius: true,
      boxFit: BoxFit.fill,

    ),
  );
  } 


  add_string_2_SP(key, value) async{
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setString(key, value);
  }

  read_from_SP(key) async{
    SharedPreferences pref = await SharedPreferences.getInstance();
    String content = pref.getString(key) ?? "";
    return content;
  }

  check_in_SP (key) async{
    SharedPreferences pref = await SharedPreferences.getInstance();
    bool content = pref.containsKey(key);
    return content;
  }

checkers() async {
  if(await check_in_SP("token") == true){
    return await read_from_SP("token");
  }else{
      // Navigator.of(context).pushAndRemoveUntil(
      //   MaterialPageRoute(builder: (BuildContext context) => AuthenticationPage() ),
      //   (Route<dynamic> route ) => false
      // );
  }
}


Future carouselLoader() async {
  String urlToday = "https://app.glclondon.church/api/content/carousel/";
  //String urlToday = "https://app.glclondon.church/api/events/current";
  //String token = "Bearer " + await checkers();

  Response response = await get(
    Uri.parse(urlToday),


    // headers: {
    //   "authorization": token,
    //   "accept": "application/json"
    // }
  );
  int statusCode = response.statusCode;

  if (statusCode < 200 || statusCode > 400) {
    throw new Exception("Could not fetch carousel");
  }else{
    var content = jsonDecode(response.body);
    //print(content);
    if (content["status"] == "true"){
      List listedImg = content["photos"] as List;
      return listedImg;
    }else{
      throw new Exception("Could not fetch any image");
    }
  }
}


Future upcomingEventsSide() async {
  String urlToday = "https://app.glclondon.church/api/events/upcoming/";
  //String urlToday = "https://app.glclondon.church/api/events/current";
  //String token = "Bearer " + await checkers();

  Response response = await get(
    Uri.parse(urlToday),
    // headers: {
    //   "authorization": token,
    //   "accept": "application/json"
    // }
  );
  int statusCode = response.statusCode;

  if (statusCode < 200 || statusCode > 400) {
    throw new Exception("Could not get Upcoming Event");
  }else{
    var content = jsonDecode(response.body);
    print(content);
    List Event = content["results"];

    return Event.map((Event) => new EventModel.fromJson(Event)).toList();
  }

}








Future Todays_verse() async {
  //print("enter safe...");
  //String url = "https://a1in1.com/GLC/todays_verse.php";
  String urlToday = "https://app.glclondon.church/api/today/verse/";
  String token = "Bearer " + await checkers();

  Response response = await get(
    Uri.parse(urlToday),
    headers: {
      "authorization": token,
      "accept": "application/json"
    }
  );

  if (response.statusCode == 200){
    var content = jsonDecode(response.body);

    if(content["status"] == "true"){
      print(content);
      return show_today_verse(content["bible_verse"], content["msg"]);
    }else{
      setState(() {
        today_verse = content["msg"];
      });
    }
    
  }else{
    setState(() {
      today_verse = "could not connect" ;
    });
  }
}

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Pallet.white,
      //backgroundColor: yellow,
      body: Padding(
        padding:EdgeInsets.all(10),
        child: ListView(
          children: <Widget>[
            FutureBuilder(
              future: carouselLoader(),

              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  List imageList = snapshot.data;
                  List netAsset = [];
                  for (var img in imageList) {
                    netAsset.add( new NetworkImage(img));
                  }
                  return Container(
                    height: size.height/3,
                    width: double.infinity,
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(5, 7, 5, 7),
                      child: the_moving_images(netAsset),
                    )
                  );
                } else if (snapshot.hasError) {
                  return new Container(
                    height: 160,
                    width: double.infinity,
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(5, 7, 5, 7),
                      child: the_moving_images(defaultImgs),
                    )
                  );
                }
                //return  a circular progress indicator.
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Center(child: CircularProgressIndicator()),
                    ),
                  ],
                );
              },
            ),



              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(17),
                  color: pure_,
                ),

                child: Column(
                  children: <Widget>[
                    SizedBox(
                      height: 30,
                    ),
                    // Row(
                    //   children: [
                    //     Icon(Icons.home_outlined,color:Pallet.primaryColor),
                    //     SizedBox(width: 10,),
                    //     Text(Constants.dummyAddress, style:TextStyle(color:Pallet.textLight)),
                    //   ],
                    // ),

                    Align(
                      alignment:Alignment.topLeft,
                        child: Text("Upcoming Events", style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),)),

                    FutureBuilder(
                      future: upcomingEventsSide(),
                      //we pass a BuildContext and an AsyncSnapshot object which is an
                      //Immutable representation of the most recent interaction with
                      //an asynchronous computation.
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          List<EventModel> EventList =  snapshot.data;

                          if ( EventList.isNotEmpty ){
                            return SizedBox(
                              height: 220.h,
                              width: double.infinity,
                              child: EventWidget(EventList)
                              //upcoming01(EventList[0].imageUrl ,EventList[0].date ,EventList[0].startTime, EventList[0].venue),
                            );
                          }else{
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                "No Upcoming Events for Now",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.blue[900],
                                ),
                              ),
                            );
                          }

                          //show_today_verse(verse, verse_content)
                        } else if (snapshot.hasError) {
                          return new Container(
                            child: Text(
                              "Could not Load new Upcoming Events",
                            )
                          );
                        }
                        //return  a circular progress indicator.
                        return Center(
                          child: CircularProgressIndicator(
                            strokeWidth: 4,
                            backgroundColor: Colors.green,
                          ),
                        );
                      },
                    ),

                    AboutUsWidget(),
                  ],
                ),
              ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.orange,
        onPressed:_navigateToPrayerRequestPage,
        tooltip: 'Prayer Request Screen',
        child: Image.asset('assets/prayer_request_icon.png'),
      ), // This trailing comma makes auto-formatting nicer for build ,
     
    );
  }

  void _navigateToPrayerRequestPage(){
    Navigator.of(context).push(MaterialPageRoute(
        builder: (BuildContext context) => Prayer()));
  }
Widget AboutUsWidget(){
  return Container(
      margin:EdgeInsets.only(top:20.h, bottom:10.h, right:10.w, left:10.w),
      padding:EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(.5),
            blurRadius: 5.0,
            spreadRadius: 0.0,
            offset: Offset(
              1.0,
              1.0,
            ),
          )
        ],
        borderRadius: BorderRadius.circular(10),

      ),
      width:double.infinity,

      child:Column(
        mainAxisSize:MainAxisSize.min,
        crossAxisAlignment:CrossAxisAlignment.center,
        children: [
          Text("About Us", style:TextStyle(fontSize:16, fontWeight: FontWeight.bold, color: Colors.grey)),
          SizedBox(height: 10.h,),
          Text("Great Light Church is a dynamic, vibrant, global ministry located in London Docklands. \n We aim to build a network of believers - impacting and influencing for Christ.",
            style:TextStyle(fontSize:14.sp,  color: Colors.grey), textAlign: TextAlign.center,),
        ],
      )
  );
}
  Widget EventWidget(List<EventModel> eventList){
   return  ListView.builder(
       shrinkWrap:true,
       scrollDirection: Axis.horizontal,
       itemCount: eventList.length,
       padding: EdgeInsets.only(top: 20.h),
       itemBuilder: (context, index)=>
           UpcomingWidget(
             event: eventList[index]
           )
   );
  }
}
