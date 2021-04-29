import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';



read_from_SP(key) async{
    SharedPreferences pref = await SharedPreferences.getInstance();
    String content = pref.getString(key);
    return content;
  }

Future makePrayerRequest(context, tit, con) async {
  //print("contains not content unseen");
  if (tit != "" && con != ""){
    print("contains");
    final writer = 'https://app.glclondon.church/api/prayer/request/';
    String token = "Bearer " + await read_from_SP("token");

    String email = await read_from_SP("email");
    http.Response response = await http.post(
      Uri.parse(writer),
      headers: {
        "authorization": token,
        "accept": "application/json"
      },
      body: {
        "name": tit,
        "email": email,
        "request": con,
      }
    );

    int statusCode = response.statusCode;
    print("We are here");
    if (statusCode < 200 || statusCode > 400) {
      throw new Exception("Error while submitting Prayers ");
    }else if (response.body != ""){
      print("Yeah o");
      print(jsonDecode(response.body));
      
      final snackBar = SnackBar(
        duration: Duration(seconds: 6),
        content: Text("You have Successfully added a Prayer Request. Prayer request page would be closed in 5 seconds"),
        //_snackBarDisplayDuration: 
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);

      /* Navigator.of(context).push(MaterialPageRoute(
      builder: (BuildContext context) => Notes_Pad())); */
      Timer(
        Duration(seconds: 5), 
        ()=>{
          Navigator.of(context).pop()
        }
      );
      
      return Text("The Prayer request Added Successfully");
      
    }
  }
}

class Prayer extends StatefulWidget {


  Prayer({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _PrayerState createState() => _PrayerState();
}


class _PrayerState extends State<Prayer> {

  TextEditingController prayerHead = TextEditingController();
  TextEditingController prayerDetail = TextEditingController();

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        //color: Colors.red,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(
                "What is your Prayer Request.",
                style: TextStyle(
                  color: Colors.blue[800],
                  fontWeight: FontWeight.w800,
                  fontSize: 18,
                  )
                ),

              TextField(
                controller: prayerHead,
                decoration: InputDecoration(
                  hintText: "Your Name: ",
                  icon: Icon(Icons.edit),
                ),
              ),

              TextField(
                controller: prayerDetail,
                maxLines: 5,
                decoration: InputDecoration(
                  hintText: "Please enter your Prayer request.",
                  icon: Icon(Icons.message)
                ),
              ),


              Center(
                child: InkWell(
                  hoverColor: Colors.black12,
                  onTap: ()=> {
                    //print("waiting here...");
                    makePrayerRequest(context, prayerHead.text, prayerDetail.text)
                  },
                  child: Padding(
                    padding: EdgeInsets.all(14),
                    child: Container(
                      height: 80,
                      width: 160,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(28),
                        color: Colors.blue[800],
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Submit Request", 
                            style: TextStyle(
                              color: Colors.white,
                              ),
                            textAlign: TextAlign.center,
                          ),
                          Icon(Icons.save, color: Colors.white,),
                        ],
                      ),
                    ),
                  ),
                ),
              )

            ]
          ),
        )
      ),
    );
  }
}

