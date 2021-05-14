//import 'dart:html';

import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:GLC/generals.dart';
import 'dart:convert';
import 'package:GLC/webview_screen.dart';


class give_page extends StatefulWidget {
  give_page({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

show_today_verse(verse, verse_content){
    return Padding(
      padding: EdgeInsets.all(15),
          child: Center(
            child: ListView(
              children: <Widget>[
                SizedBox(height: 37,),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(verse_content, 
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 16,
                      ),
                      textAlign: TextAlign.justify,
                    ),
                ),

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(verse, 
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 18,
                  ),
                  textAlign: TextAlign.left,
                ),
              ),
         
        ],),
          ),
    );
  }

Future Todays_verse() async {
  //print("enter safe...");
  //String url = "https://a1in1.com/GLC/todays_verse.php";
  String urlToday = "https://app.glclondon.church/api/today/verse/";
  String token = "Bearer " + await read_from_SP("token");

  Response response = await get(
    Uri.parse(urlToday),
    headers: {
      "authorization": token,
      "accept": "application/json"
    }
  );

  String today_verse = " ";
  int statusCode = response.statusCode;
  if (statusCode < 200 || statusCode > 400) {
    throw new Exception("Connection Error...");
  }else{
    var content = jsonDecode(response.body);

    if(content["status"] == "true"){
      print(content);
      return show_today_verse(content["bible_verse"], content["msg"]);
    }else{
      throw new Exception(" Status is not true... Reconnect.");
    }
  }
  print(response);
  print(response.headers);

  //return response;
}
class _MyHomePageState extends State<give_page> {
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

  int _value = 1;
  //TextEditingController price = TextEditingController();
  TextEditingController priceToken = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  /* Gradient graater() {
    return LinearGradient(
      colors: <Color>[Colors.green, Colors.orange]
    );
  } */

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: pure_,
      body: Container(
        child: Column(
          children: <Widget>[
            Flexible(
              flex: 400,
              child: Container(
                  child: FutureBuilder(
                  future: Todays_verse(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return Container(
                        child: snapshot.data,
                      );
                      //show_today_verse(verse, verse_content)
                    } else if (snapshot.hasError) {
                      return new Container(
                        child: Text("Could not connect. Please try again later.",
                          style: TextStyle(
                            color: Colors.red,
                          ),
                          )
                      );
                    }
                    return Center( child: CircularProgressIndicator());
                  },
                ),
              )
            ),

            Expanded(
              flex: 600,
              child: Container(
                //height: ,
                width: double.infinity,
                color: Color.fromRGBO(247, 247, 247, 1),
                child: Form(
                  key: _formKey,
                  child: ListView(
                    children: [
                      Padding(
                        padding: EdgeInsets.fromLTRB(17, 9, 17, 9),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton(
                              elevation: 12,
                              itemHeight: 60,
                              //isExpanded: true,
                              style: TextStyle(
                                color: Colors.black,
                                backgroundColor: Colors.white,
                              ),
                            value: _value,
                            items: [
                                DropdownMenuItem(
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text("Giving", style: TextStyle(fontWeight: FontWeight.w700),),
                                      )),
                                    value: 1,
                                ),
                                DropdownMenuItem(
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text("Seed", style: TextStyle(fontWeight: FontWeight.w700),),
                                    ),
                                    value: 2,
                                ),
                                DropdownMenuItem(
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text("Tithe", style: TextStyle(fontWeight: FontWeight.w700),),
                                    ),
                                    value: 3
                                ),
                                DropdownMenuItem(
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text("Offering", style: TextStyle(fontWeight: FontWeight.w700),),
                                    ),
                                    value: 4
                                )
                            ],
                            onChanged: (value) {
                              setState(() {
                                _value = value;
                              });
                            }),
                          ),
                        ),
                      ),

                      Padding(
                        padding: EdgeInsets.fromLTRB(17, 9, 17, 9),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius. circular(15.0),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.4),
                                spreadRadius: 1,
                                blurRadius: 2,
                                offset: Offset(0,1),
                              )
                            ]
                          ),
                          child: TextFormField(
                            maxLines: 1,
                            controller: priceToken,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              hintText: "50.00",
                              prefixIcon: Icon( CupertinoIcons.money_pound ),
                              fillColor: Colors.white,
                              border:OutlineInputBorder(
                                //borderSide: const BorderSide(color: Colors. white, width: 1.0),
                                borderRadius: BorderRadius.circular(15.0),
                              ),
                            ),

                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'This field should not be empty.';
                              }else if( int.parse(value) < 1){
                                return ' Below Minimum, Please, Do not be Weary. ';
                              }
                              return null;
                            },
                          ),
                        ),
                      ),


                      Padding(
                        padding: const EdgeInsets.fromLTRB(17, 23, 17, 9),
                        child: Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            gradient: LinearGradient(
                              colors: <Color>[Colors.orange[400], Colors.orange[500], Colors.orange[700]]
                            ),
                            //color: Colors.orange[500],
                          ),
                          child: TextButton(
                            onPressed: () async {
                              //print("enter the region");
                              var formVal = _formKey.currentState.validate();
                              if (formVal == true){
                                List categoryList = ["Giving", "Seed", "Tithe", "Offering"];
                                String price = priceToken.text;
                                String email = await check_in_SP("email") ? await read_from_SP("email") : "user@GLCApp.com";
                                String category = (_value < categoryList.length) ? categoryList[_value] : "Unspecified";
                                String takePath  = "https://a1in1.com/GLC/pay_area.php?email=${email}&amount=${price}&currency=GBP&country=UK&purpose=${category}";
                                //String takePath = "https://a1in1.com/GLC/pay_area.php";
                                Navigator.of(context).push(MaterialPageRoute(
                                builder: (BuildContext context) => GLCWebview(url: takePath, )));
                              }
                            }, 
                            child: Text(
                              "GIVE",
                              style: TextStyle( fontWeight: FontWeight.w800, color: Colors.white),
                            )
                          ),
                        ),
                      ),

                    ],
                  ),
                ),
              ),
            )
            
          ]
        )
      )
    );
  }
}
