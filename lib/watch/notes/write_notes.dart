import 'dart:async';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'dart:convert';
//import 'package:GLC/generals.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'list_notes.dart';


read_from_SP(key) async{
    SharedPreferences pref = await SharedPreferences.getInstance();
    String content = pref.getString(key);
    return content;
  }

Future addUserNotes(context, tit, con) async {
  if (tit != "" && con != ""){
    final writer = 'http://164.90.139.70/api/notes/';
    String token = "Bearer " + await read_from_SP("token");
    Response response = await post(
      Uri.parse(writer),
      headers: {
        "authorization": token,
        "accept": "application/json"
      },
      body: {
        "title": tit,
        "text": con,
      }
    );

    int statusCode = response.statusCode;
    if (statusCode < 200 || statusCode > 400) {
      throw new Exception("Error while fetching data");
    }else if (response.body != ""){
      print(jsonDecode(response.body));

      final snackBar = SnackBar(
        backgroundColor: Colors.green[600],
        elevation: 12,
        duration: Duration(seconds: 9),
        content: Text("Note Added Successfully. You may need to reload to see new Notes "),
        //_snackBarDisplayDuration: 
      );
      //Navigator.of(context).pop();
      /* Navigator.of(context).push(MaterialPageRoute(
      builder: (BuildContext context) => Notes_Pad())); */
      return Text("The Note was Added Successfully");
      
    }
  }
}

class Write_note extends StatelessWidget {

  TextEditingController noteTitle = TextEditingController();
  TextEditingController noteContent = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      home: new Scaffold(
        body: new Container(
          //color: Colors.amber,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.fromLTRB(6.0, 70.0, 6.0, 10),
                child: TextField(
                  controller: noteTitle,
                   maxLength: 100,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.title),
                    hintText: "Title",
                  )
                ),
              ),
              TextFormField(
                controller: noteContent,
                maxLines: 5,
                maxLength: 300,
                decoration: InputDecoration(
                  //prefixIcon: Icon(Icons.edit),
                  hintText: "Notes enter here",
                  labelText: "Note: ",
                  icon: Icon(Icons.edit)
                )
              ),

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(12)
                  ),
                  padding: EdgeInsets.all(5),
                  child: IconButton(
                    icon: Icon(Icons.send), 
                    onPressed: ()=> {
                      addUserNotes(context, noteTitle.text, noteContent.text)
                    },
                  )
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
//end
