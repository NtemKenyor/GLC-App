import 'dart:async';


import 'package:GLC/ui/media/media.dart';
import 'package:GLC/utils/pallet.dart';
import 'package:GLC/utils/widgets/notes_list_item.dart';
import 'package:GLC/watch/notes/models/note_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'dart:convert';
import 'write_notes.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'display_notes.dart';
import 'package:shared_preferences/shared_preferences.dart';



class CustomListView extends StatefulWidget {
  final List<NoteModel> noteList;
  CustomListView({Key key, this.noteList});

  @override
  _CustomListViewState createState() => _CustomListViewState();
}

class _CustomListViewState extends State<CustomListView> {
  Widget build(context) {
    if (widget.noteList.isEmpty){
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
                padding: EdgeInsets.only(top: 10.0.h, bottom: 2.0.h,),
                child: Text("Notes",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black38)
                ),
              ),
            ),

            ListView.builder(
              shrinkWrap: true,
              physics: ScrollPhysics(),
              itemCount: widget.noteList.length,
              itemBuilder: (context, index) {
                return NotesListItem(widget.noteList[index]);
              },
            )
          ]
      );
    }

  }
}





class NotedPadWidget extends StatefulWidget {
  @override
  _NotedPadWidgetState createState() => _NotedPadWidgetState();
}

class _NotedPadWidgetState extends State<NotedPadWidget> {
  List<NoteModel> listedData;
  read_from_SP(key) async{
    SharedPreferences pref = await SharedPreferences.getInstance();
    String content = pref.getString(key)??"";
    return content;
  }

  bool loginState;
  Future<List<NoteModel>> downloadJSON() async {
    final jsonEndpoint = 'https://app.glclondon.church/api/notes';
    String token = "Bearer " + await read_from_SP("token")??"";
    print("jobs fix");
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
      Map responsee = json.decode(response.body);
     setState(() {
       loginState = responsee['is_logged_in'];
     });

      throw Exception('We were not able to successfully download the json data.');
    }else {
      print("here");
      var content = json.decode(response.body);
      // print(content);
      List nuesa_news = content["results"] as List;
      List<NoteModel> realDeal = nuesa_news.map((nuesa_news) => new NoteModel.fromJson(nuesa_news)).toList();

      print(realDeal);
      return realDeal;
      //return nuesa_news.map((nuesa_news) => new Notes_out.fromJson(nuesa_news)).toList();
    }
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        //appBar: new AppBar(title: const Text('MySQL Images Text')),
        body:  Container(
          height: 300.h,
            padding:EdgeInsets.all(10),
            child: new FutureBuilder<List<NoteModel>>(
                future: downloadJSON(),
                builder: (context, data ){
                  //return overrideSnapshot();
                  print(data.data);
                  print(data);
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
                  }else if (loginState!=null && loginState == false){
                    return SizedBox(
                        height: 50.h,
                        child: Center(child: Text('You Need to Log in to Continue')));
                  }{
                    return SizedBox(
                      height: 50.h,
                        child: Center(child: CircularProgressIndicator()));
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

        floatingActionButton: (loginState!=null && loginState == false)? SizedBox.shrink():Padding(
          padding: EdgeInsets.all(12),
          child: Container(
            decoration: BoxDecoration(
              color: Pallet.primaryColor,
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
    );
  }
}

//end
