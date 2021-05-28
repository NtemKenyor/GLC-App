import 'package:GLC/ui/donations/data/payment_utils.dart';
import 'package:GLC/ui/donations/screens/payment_web_page.dart';
import 'package:GLC/ui/donations/widgets/giving_bottomsheet.dart';
import 'package:GLC/utils/pallet.dart';
import 'package:GLC/utils/widgets/toast_message.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart';
import 'package:GLC/generals.dart';
import 'dart:convert';
import 'dart:math' as math;

import 'package:provider/provider.dart';

class give_page extends StatefulWidget {
  give_page({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

show_today_verse(verse, verse_content) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      Padding(
        padding: const EdgeInsets.all(10.0),
        child: Text(
          verse_content,
          style: TextStyle(
              fontWeight: FontWeight.w400,
              color: Colors.grey.shade600,
              fontSize: 16),
        ),
      ),
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          verse,
          style: TextStyle(
              fontWeight: FontWeight.w500,
              color: Colors.grey.shade700,
              fontSize: 16),
        ),
      ),
    ],
  );
}

Future Todays_verse() async {
  //print("enter safe...");
  //String url = "https://a1in1.com/GLC/todays_verse.php";
  String urlToday = "https://app.glclondon.church/api/today/verse/";
  String token = "Bearer " + await read_from_SP("token");

  Response response = await get(Uri.parse(urlToday),
      headers: {"authorization": token, "accept": "application/json"});

  String today_verse = " ";
  int statusCode = response.statusCode;
  if (statusCode < 200 || statusCode > 400) {
    throw new Exception("Connection Error...");
  } else {
    var content = jsonDecode(response.body);

    if (content["status"] == "true") {
      print(content);
      return show_today_verse(content["bible_verse"], content["msg"]);
    } else {
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

  bool isChecked = true;
  String selectedGivingType;

  List<String> givingList = ['Seed', 'Tithe', 'Offering'];

  TextEditingController amountController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    amountController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final _paymentProvider = Provider.of<PaymentProvider>(context);
    _paymentProvider.getUserEmail();
    return Scaffold(
        backgroundColor: pure_,
        body: ListView(scrollDirection: Axis.vertical, children: <Widget>[
          Column(children: <Widget>[
            SizedBox(height: 30,),
            FutureBuilder(
              future: Todays_verse(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Container(
                    padding:EdgeInsets.all(10),
                    width: double.infinity,
                    child: Align(
                        alignment: Alignment.topLeft, child: snapshot.data),
                  );
                  //show_today_verse(verse, verse_content)
                } else if (snapshot.hasError) {
                  return new Container(
                      child: Text(
                    "Could not connect. Please try again later.",
                    style: TextStyle(
                      color: Colors.red,
                    ),
                  ));
                }
                return CircularProgressIndicator();
              },
            ),
            SizedBox(
              height: 30,
            ),
            Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                Checkbox(
                  activeColor: Pallet.primaryColor,
                  checkColor: Colors.white,
                  value: isChecked,
                  onChanged: (newValue) {
                    setState(() {
                      isChecked = newValue;
                    });
                  },
                ),
                Expanded(
                  child: Text('I am a UK taxpayer so please treat this donations under the gift aid scheme until otherwise notified',
                      style: TextStyle(
                          color: Colors.grey.shade600,
                          fontSize: 14,
                          fontStyle: FontStyle.italic)),
                )
              ],
            ),
            SizedBox(
              height: 30,
            ),
          ]),
          Container(
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(color: Colors.grey.shade50),
              child: Column(
                children: [
                  InkWell(
                    onTap: () => showGivingBottomSheet(givingList, context),
                    child: Material(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      elevation: 2,
                      child: Container(
                        padding: EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                          color: Colors.white,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                selectedGivingType ?? 'Select Giving Type',
                                style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.grey.shade500,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              Transform.rotate(
                                  angle: math.pi / 2,
                                  child: Icon(Icons.arrow_forward_ios,
                                      color: Colors.grey))
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Material(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    elevation: 2,
                    child: Padding(
                      padding: EdgeInsets.all(8),
                      child: TextFormField(
                          inputFormatters: [
                            WhitelistingTextInputFormatter(RegExp("[0-9]")),
                          ],
                          maxLines: 1,
                          controller: amountController,onChanged: (val){
                            _paymentProvider.setAmount(val);
                      },
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                              prefixIcon: Padding(
                                  padding: EdgeInsets.all(14),
                                  child: Text("£",
                                      style: TextStyle(
                                          fontSize: 18, color: Colors.grey))),
                              border: InputBorder.none,
                              focusedBorder: InputBorder.none,
                              enabledBorder: InputBorder.none,
                              errorBorder: InputBorder.none,
                              disabledBorder: InputBorder.none,
                              hintText: "Enter amount here",
                              hintStyle:
                                  TextStyle(color: Colors.grey.shade400))),
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 20),
                    padding: EdgeInsets.all(5),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: Pallet.primaryColor,
                    ),
                    child: FlatButton(
                        onPressed: () {
                          if(hasData){
                            var route = new MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    OnlinePaymentPage(paymentLink: _paymentProvider.paymentUrl,));
                            Navigator.of(context).push(route);
                          }else{
                           flutterToast("Oops, Please fill all the fields", true);
                          }
                        },
                        child: Text(
                          "GIVE",
                          style: TextStyle(
                              fontWeight: FontWeight.w800,
                              color: Colors.white,
                              fontSize: 16),
                        )),
                  )
                ],
              ))
        ]));
  }

  bool get hasData {
    if(selectedGivingType !=null && selectedGivingType.isNotEmpty && amountController.text !=null && amountController.text.isNotEmpty){
      return true;
    }else{
      return false;
    }
  }

  Widget showGivingBottomSheet(List<String> givingType, BuildContext context) {
    final _paymentProvider = Provider.of<PaymentProvider>(context, listen: false);

    showModalBottomSheet(
        enableDrag: true,
        isDismissible: true,
        context: context,
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        builder: (context) {
          return GivingBottomSheet(givingType, (v) {
            setState(() {
              if (v != null) {
                selectedGivingType = v;
                _paymentProvider.setType(v);
              }
            });
          });
        });
  }
}
