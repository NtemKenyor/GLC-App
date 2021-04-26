import 'dart:async';

import 'package:GLC/media/podcast/media.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'dart:convert';
import 'write_notes.dart';
import 'display_notes.dart';
//import 'package:GLC/generals.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Notes_out {
  final int id;
  final String title, content, createDate, upDated;

  Notes_out({
    this.id,
    this.title,
    this.content,
    this.createDate,
    this.upDated
  });

  factory Notes_out.fromJson(Map<String, dynamic> jsonData) {
    return Notes_out(
      id: jsonData['id'],
      title: jsonData['title'],
      content: jsonData['text'],
      createDate: jsonData['created_at'],
      upDated: jsonData['updated_at'],
    );
  }
}

class CustomListView extends StatelessWidget {
  final List<Notes_out> noteList;
  CustomListView({Key key, this.noteList});


  Widget build(context) {
    if (noteList.isEmpty){
      return Container(
        child: Center(
          child: Text("You can add notes. You do not any notes.",
            style: TextStyle(
              color: Colors.green,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      );
    }else{
        return ListView(
          scrollDirection: Axis.vertical,
          children: <Widget>[
            Center(
              child: Padding(
                padding: const EdgeInsets.only(top: 10.0, bottom: 2.0,),
                child: Text("Notes",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black38)
                ),
              ),
            ),

            ListView.builder(
              shrinkWrap: true,
              physics: ScrollPhysics(),
              itemCount: noteList.length,
              itemBuilder: (context, int currentIndex) {
                return list_note( noteList[currentIndex], context);
              },
            )
          ]
      );
    }
    

    /* return ListView.builder(
      itemCount: spacecrafts.length,
      itemBuilder: (context, int currentIndex) {
        return List_home(spacecrafts[currentIndex], context);
      },
    );*/
  }

  Widget list_note (Notes_out the_notes, BuildContext context) {
    return InkWell(
      hoverColor: Colors.orange,
      onTap: () {
        var route = new MaterialPageRoute(
          builder: (BuildContext context) =>
          new Display_content(the_notes.title, the_notes.content, the_notes.createDate, the_notes.upDated),
        );
        Navigator.of(context).push(route);
      },
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Container(
          color: Colors.black38,
          child: Card(
              elevation: 4,
              child: Wrap(
                crossAxisAlignment: WrapCrossAlignment.start,
                children: <Widget>[
                  Container(
                    width: double.infinity,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Row(
                        children: <Widget>[
                          /* Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Image.network(each_event.imageUrl, height: 100, width: 100),
                          ), */
                          Expanded(
                            child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  Flexible(child: Text(the_notes.title, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),)),
                                  Flexible(child: Text(the_notes.content, maxLines: 3,) ),
                                ]
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              )
          ),
        ),
      ),
    );
  }

}

//Future is n object representing a delayed computation.

  read_from_SP(key) async{
    SharedPreferences pref = await SharedPreferences.getInstance();
    String content = pref.getString(key);
    return content;
  }

/* theRetrer(){
  if (data.data != null){
    return CustomListView( noteList: listedData,);
  }else{
    return CircularProgressIndicator();
    Timer(duration, callback)
  }
} */

Future<List<Notes_out>> downloadJSON() async {
  final jsonEndpoint = 'http://164.90.139.70/api/notes';
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
   // print(content);
   List nuesa_news = content["results"] as List;
   List<Notes_out> realDeal = nuesa_news.map((nuesa_news) => new Notes_out.fromJson(nuesa_news)).toList();

    print(realDeal);
    return realDeal;
    //return nuesa_news.map((nuesa_news) => new Notes_out.fromJson(nuesa_news)).toList();
  }
}

/* Future<Widget> overrideSnapshot() async {
  var theContent = await downloadJSON();
  return theContent;
} */

/* Future<List<Notes_out>> downloadJSON() async {

  final jsonEndpoint = 'http://164.90.139.70/api/notes/';
  String token = "Bearer " + await read_from_SP("token");

  final response = await get(
    Uri.parse(jsonEndpoint),
    headers: {
      "authorization": token,
      "accept": "application/json"
    }
  );
  
  int statusCode = response.statusCode;
  if (statusCode < 200 || statusCode > 400) {
    throw Exception('We were not able to successfully download Notes.');
  }else {
    var theBody = jsonDecode(response.body);
    List noted = theBody["results"];
    print(noted);
    print(jsonDecode(response.body));
    return noted
        .map((noted) => new Notes_out.fromJson(noted))
        .toList();
  }
} */

class Notes_Pad extends StatefulWidget {
  Notes_Pad({Key key}) : super(key: key);

 @override
  Notes_Pad_State createState() => Notes_Pad_State();
}

class Notes_Pad_State extends State<Notes_Pad> {
  List<Notes_out> listedData;
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      theme: ThemeData(
        primaryColor: Colors.black,
        accentColor: Color(0xFFDBECF1),
        scaffoldBackgroundColor: Colors.black45,
      ),
      home: new Scaffold(
        //appBar: new AppBar(title: const Text('MySQL Images Text')),
        body: new Center(
          //FutureBuilder is a widget that builds itself based on the latest snapshot
          // of interaction with a Future.
          child: Container(
            
            child: new FutureBuilder<List<Notes_out>>(
              future: downloadJSON(),
              builder: (context, data ){
                //return overrideSnapshot();
                print(data.data);
                listedData = data.data;
                if (data.data != null){
                  return RefreshIndicator(
                    color: pure_,
                    backgroundColor: Colors.green[800],
                    onRefresh: ()  {
                      return Future.delayed(
                        Duration(seconds: 3), () async {
                          var content = await downloadJSON();
                          setState(() {
                            listedData = content;
                          });

                           ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Page Refreshed'),
                            ),
                          );
                          
                        }
                      );
                    },
                    child: Container(
                      child: CustomListView( noteList: listedData,)
                    ),
                  );
                }else{
                  return CircularProgressIndicator();
                }

              }
            ),
          ),
          /* new FutureBuilder<List<Notes_out>>(
            future: downloadJSON(),
            //we pass a BuildContext and an AsyncSnapshot object which is an
            //Immutable representation of the most recent interaction with
            //an asynchronous computation.
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              print("snap Shoot: ");
              print(snapshot.data);
              if (snapshot.hasData) {
                List<Notes_out> spacecrafts = snapshot.data;
                return Container(
                    color: Colors.black,
                    child: new CustomListView( noteList: spacecrafts,));
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
          ), */
        ),

        floatingActionButton: Padding(
          padding: EdgeInsets.all(12),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.blue[900],
              shape: BoxShape.circle,
            ),
            child: IconButton(
              color: Colors.white,
              icon: Icon(Icons.add), 
              onPressed: ()=>{
                Navigator.of(context).push(MaterialPageRoute(
                builder: (BuildContext context) => Write_note()))
              }
            ),
          ),
        ),
      ),
    );
  }
}
//end
