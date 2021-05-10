import 'dart:async';


import 'package:GLC/ui/media/media.dart';
import 'package:GLC/utils/pallet.dart';
import 'package:GLC/utils/widgets/notes_list_item.dart';
import 'package:GLC/watch/notes/models/note_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'dart:convert';
import 'write_notes.dart';
import 'display_notes.dart';
import 'package:shared_preferences/shared_preferences.dart';



class CustomListView extends StatelessWidget {
  final List<NoteModel> noteList;
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
              itemBuilder: (context, index) {
                return NotesListItem(noteList[index]);
              },
            )
          ]
      );
    }

  }




}


  read_from_SP(key) async{
    SharedPreferences pref = await SharedPreferences.getInstance();
    String content = pref.getString(key);
    return content;
  }


Future<List<NoteModel>> downloadJSON() async {
  final jsonEndpoint = 'https://app.glclondon.church/api/notes';
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
   List<NoteModel> realDeal = nuesa_news.map((nuesa_news) => new NoteModel.fromJson(nuesa_news)).toList();

    print(realDeal);
    return realDeal;
    //return nuesa_news.map((nuesa_news) => new Notes_out.fromJson(nuesa_news)).toList();
  }
}


class Notes_Pad extends StatefulWidget {
  Notes_Pad({Key key}) : super(key: key);

 @override
  Notes_Pad_State createState() => Notes_Pad_State();
}

class Notes_Pad_State extends State<Notes_Pad> {
  List<NoteModel> listedData;
  @override
  Widget build(BuildContext context) {
    return  SafeArea(
      child: Scaffold(
          //appBar: new AppBar(title: const Text('MySQL Images Text')),
          body: new Center(
            //FutureBuilder is a widget that builds itself based on the latest snapshot
            // of interaction with a Future.
            child: Container(
                padding:EdgeInsets.all(10),
              child: new FutureBuilder<List<NoteModel>>(
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
        ),
    );
  }
}
//end
