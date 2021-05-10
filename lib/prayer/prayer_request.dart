import 'dart:async';
import 'package:GLC/utils/pallet.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

read_from_SP(key) async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  String content = pref.getString(key);
  return content;
}

Future makePrayerRequest(context, tit, con) async {
  //print("contains not content unseen");
  if (tit != "" && con != "") {
    print("contains");
    final writer = 'https://app.glclondon.church/api/prayer/request/';
    String token = "Bearer " + await read_from_SP("token");

    String email = await read_from_SP("email");
    http.Response response = await http.post(Uri.parse(writer), headers: {
      "authorization": token,
      "accept": "application/json"
    }, body: {
      "name": tit,
      "email": email,
      "request": con,
    });

    int statusCode = response.statusCode;
    print("We are here");
    if (statusCode < 200 || statusCode > 400) {
      throw new Exception("Error while submitting Prayers ");
    } else if (response.body != "") {
      print("Yeah o");
      print(jsonDecode(response.body));

      final snackBar = SnackBar(
        duration: Duration(seconds: 6),
        content: Text(
            "You have Successfully added a Prayer Request. Prayer request page would be closed in 5 seconds"),
        //_snackBarDisplayDuration:
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);

      /* Navigator.of(context).push(MaterialPageRoute(
      builder: (BuildContext context) => Notes_Pad())); */
      Timer(Duration(seconds: 5), () => {Navigator.of(context).pop()});

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
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          //leading: Icon(Icons.menu),
            automaticallyImplyLeading: false,
            elevation: 0,
            backgroundColor: Pallet.appBarColor,
            title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  IconButton(
                      icon:
                      Icon(Icons.arrow_back_ios, color: Pallet.primaryColor),
                      onPressed: () {
                        Navigator.pop(context);
                      }),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical:8.0),
                      child: Image.asset("assets/glc logo 1.png", width: 120, height: 55,),
                    ),
                  ),
                  SizedBox(width: 40,),
                  // IconButton(
                  //   onPressed: ()=> {userSide()},
                  //   icon: Icon(Icons.person, ),
                  //   color: dark_,
                  // )
                ]
            )
        ),
        resizeToAvoidBottomInset: true,
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Container(
              padding: const EdgeInsets.all(8.0),
              child: Column(children: <Widget>[
                SizedBox(
                  height: 10,
                ),

                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding:EdgeInsets.symmetric(vertical: 5),
                  child: Image.asset("assets/prayer_image.png",width: 100,
                    height: 100,),
                ),
                SizedBox(
                  height: 10,
                ),
                Text("Prayer Request.",
                    style: TextStyle(
                      color: Pallet.textLight,
                      fontWeight: FontWeight.w800,
                      fontSize: 40,
                    )),
                SizedBox(
                  height: 30,
                ),
                Padding(
                  padding:EdgeInsets.symmetric(horizontal: 10),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.edit_outlined),
                        SizedBox(
                          width: 10,
                        ),
                        Text('Title'),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 5),
                Padding(
                  padding:EdgeInsets.symmetric(horizontal: 10),
                  child: TextFormField(
                      maxLines: 1,
                      controller: prayerHead,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        disabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20.0),
                            borderSide: BorderSide(color: Pallet.primaryColor)),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20.0),
                            borderSide: BorderSide(color: Pallet.primaryColor)),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20.0),
                              borderSide: BorderSide(color: Pallet.primaryColor)),
                      )),
                ),
                SizedBox(height: 20),
                Padding(
                  padding:EdgeInsets.symmetric(horizontal: 10),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Icon(Icons.edit_outlined),
                        SizedBox(
                          width: 10,
                        ),
                        Text('Type your prayer request'),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 5),
                Padding(
                  padding:EdgeInsets.symmetric(horizontal: 10),
                  child: TextFormField(
                      minLines: 7,
                      maxLines: null,
                      controller: prayerDetail,
                      keyboardType: TextInputType.multiline,
                      decoration: InputDecoration(
                        disabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20.0),
                            borderSide: BorderSide(color: Pallet.primaryColor)),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20.0),
                            borderSide: BorderSide(color: Pallet.primaryColor)),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20.0),
                              borderSide: BorderSide(color: Pallet.primaryColor)),
                          )),
                ),



                SizedBox(height: 30,),
                Center(
                  child: ClipOval(
                    child: Material(
                      color: Pallet.primaryColor, // button color
                      child: InkWell(
                        splashColor: Pallet.white, // inkwell color
                        child: SizedBox(width: 56, height: 56, child: Icon(Icons.send, color:Pallet.white)),
                        onTap: () {
                          makePrayerRequest(context, prayerHead.text, prayerDetail.text);
                        },
                      ),
                    ),
                  ),
                ),

              ])),
        ),
      ),
    );
  }
}
