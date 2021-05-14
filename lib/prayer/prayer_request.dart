import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
    //print("contains");
    final writer = 'https://app.glclondon.church/api/prayer/request/';
    String token = "Bearer " + await read_from_SP("token");
    String email = await read_from_SP("email");
    //print("emailer: "+email);
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
      
      print(jsonDecode(response.body));

      final snackBar = SnackBar(
        duration: Duration(seconds: 3),
        content: Text("You have Successfully added a Prayer Request. Prayer request page would be closed in 2 seconds"),
        //_snackBarDisplayDuration: 
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      Navigator.of(context).pop();
      /* Navigator.of(context).push(MaterialPageRoute(
      builder: (BuildContext context) => Notes_Pad())); */
      /* Timer(
        Duration(seconds: 1),
        ()=>{
          
        }
      ); */
      
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
          child: ListView(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[

                  Padding(
                    padding: const EdgeInsets.all(21.0),
                    child: Container(
                      height: 230,
                      width: 230,
                      child: Image.asset("assets/prayer.png"),
                    ),
                  ),
                  /* Text(
                    "What is your Prayer Request.",
                    style: TextStyle(
                      color: Colors.blue[800],
                      fontWeight: FontWeight.w800,
                      fontSize: 18,
                      )
                    ), */

                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              Icon(Icons.edit_outlined, size: 23, ),
                              Text("Title"),
                            ]
                          ),
                        ),

                        TextField(
                          controller: prayerHead,
                          maxLength: 50,
                          maxLengthEnforcement: MaxLengthEnforcement.enforced,
                          decoration: InputDecoration(
                            hintText: "Your Name: ",
                            focusColor: Colors.orange,
                            //icon: Icon(Icons.edit),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(width: 9, color: Colors.black,)
                            )
                          ),
                        ),
                      ],
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              Icon(Icons.edit_outlined),
                              Text("Type your Prayer Request"),
                            ]
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextField(
                            controller: prayerDetail,
                            maxLines: 7,
                            maxLength: 300,
                            decoration: InputDecoration(
                              hintText: "Please enter your Prayer request.",
                              //icon: Icon(Icons.message),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide(width: 9, color: Colors.black,)
                              )
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  //makePrayerRequest(context, prayerHead.text, prayerDetail.text)

                  Padding(
                    padding: const EdgeInsets.fromLTRB(12.0, 12.0, 12.0, 32.0),
                    child: FloatingActionButton(
                      backgroundColor: Colors.orange[400],
                      onPressed: () {
                        makePrayerRequest(context, prayerHead.text, prayerDetail.text);
                      },
                      elevation: 10,
                      child: Center(
                        child: Icon(Icons.send_outlined, color: Colors.white,),
                      ),
                    ),
                  )

                  /* Center(
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
                  ) */

                ]
              ),
            ],
          ),
        )
      ),
    );
  }
}

