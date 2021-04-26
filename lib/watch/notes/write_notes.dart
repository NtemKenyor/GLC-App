import 'dart:async';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'dart:convert';
//import 'package:GLC/generals.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'list_notes.dart';


String reply = " ";
read_from_SP(key) async{
    SharedPreferences pref = await SharedPreferences.getInstance();
    String content = pref.getString(key);
    return content;
  }




class Write_note extends StatefulWidget {
  Write_note({Key key}) : super(key: key);

   @override
  Write_note_State createState() => Write_note_State();
  

}



class Write_note_State extends State<Write_note> {

  Future addUserNotes(context, tit, con) async {
    mr_Change("Connecting");
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
      mr_Change("Writing");
      int statusCode = response.statusCode;
      if (statusCode < 200 || statusCode > 400) {
        reply = "Failed";
        throw new Exception("Error while fetching data");
      }else if (response.body != ""){
        print(jsonDecode(response.body));
        final theBar = SnackBar(
          //backgroundColor: Colors.green[600],
          //elevation: 12,
          //duration: Duration(seconds: 9),
          content: Text("Note Added Successfully. You may need to reload to see new Notes "),
          //_snackBarDisplayDuration: 
        );
        ScaffoldMessenger.of(context).showSnackBar(theBar);
        mr_Change("Successful");
        return Text("The Note was Added Successfully");
        
      }
    }else{
      mr_Change("All details should be filled");
    }
  }

  TextEditingController noteTitle = TextEditingController();
  TextEditingController noteContent = TextEditingController();
  
  mr_Change(note){
    setState(() {
      reply = note;
    });
  }

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
              ),

              Text(reply, 
                style: TextStyle(
                  color: Colors.green[800],
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
