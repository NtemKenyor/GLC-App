import 'package:GLC/ui/donations/data/payment_utils.dart';
import 'package:GLC/ui/donations/screens/payment_web_page.dart';
import 'package:GLC/ui/donations/widgets/giving_bottomsheet.dart';
import 'package:GLC/utils/pallet.dart';
import 'package:GLC/utils/widgets/toast_message.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:GLC/generals.dart';
import 'dart:convert';
import 'dart:math' as math;

import 'package:provider/provider.dart';

class GivingPage extends StatefulWidget {
  GivingPage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}





class _MyHomePageState extends State<GivingPage> {
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
        return BibleVerseWidget(
           // content["bible_verse"], content["msg"]
        );
      } else {
        throw new Exception(" Status is not true... Reconnect.");
      }
    }
    print(response);
    print(response.headers);

    //return response;
  }

  BibleVerseWidget() {
    return Container(
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(.5),
            blurRadius: 5.0,
            spreadRadius: 0.0,
            offset: Offset(
              1.0,
              1.0,
            ),
          )
        ],
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text.rich(
            TextSpan(
              children: [
                TextSpan(text: 'Thank you for choosing to give to Great Light Church \n –  '),
                TextSpan(
                  text: 'Charity Reg No: 1193487',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                TextSpan(text: '\n\n- The Gift Aid Scheme entitles the charity to claim an extra 25p on every £1 given by a UK taxpayer. The information below is required by HMRC, as declaration that you will like Great Light Church, as a charity to reclaim tax on your behalf.  \n I am a UK taxpayer so please treat this donation and all future donations under the gift aid scheme until otherwise notified'),
              ],
            ),
          ),
          SizedBox(height:10.h),
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
                child: Text(
                    'Accept Terms & Conditions',
                    style: TextStyle(
                        color: Colors.grey.shade600,
                        fontSize: 14.sp,
                        fontStyle: FontStyle.italic)),
              )
            ],
          ),
          // Padding(
          //   padding: const EdgeInsets.all(8.0),
          //   child: Text(
          //     verse,
          //     style: TextStyle(
          //         fontWeight: FontWeight.w500,
          //         color: Colors.grey.shade700,
          //         fontSize: 16),
          //   ),
          // ),


        ],
      ),
    );
  }




  @override
  Widget build(BuildContext context) {
    final _paymentProvider = Provider.of<PaymentProvider>(context);
    _paymentProvider.getUserEmail();
    return Scaffold(
        backgroundColor: pure_,
        body: Container(
          padding:EdgeInsets.all(16),
          child: ListView(scrollDirection: Axis.vertical, children: <Widget>[
            BibleVerseWidget(),
            SizedBox(height: 16.h),
            Column(
              children: [
                InkWell(
                  onTap: () => showGivingBottomSheet(givingList, context),
                  child: Material(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    elevation: 2,
                    child: Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                        color: Colors.white,
                      ),
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16.0.w),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              selectedGivingType ?? 'Select Giving Type',
                              style: TextStyle(
                                fontSize: 16.sp,
                                color: Colors.grey.shade500,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            Transform.rotate(
                                angle: math.pi / 2,
                                child: Icon(Icons.arrow_forward_ios,
                                    color: Colors.grey, size: 20.sp,))
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 15.h,
                ),
                Material(
                  borderRadius: BorderRadius.all(Radius.circular(16)),
                  elevation: 2,
                  child: Padding(
                    padding: EdgeInsets.all(8),
                    child: TextFormField(
                        inputFormatters: [
                          WhitelistingTextInputFormatter(RegExp("[0-9]")),
                        ],
                        maxLines: 1,
                        controller: amountController,
                        onChanged: (val) {
                          _paymentProvider.setAmount(val);
                        },
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(contentPadding: EdgeInsets.all(10),
                            prefixIcon: Padding(
                                padding: EdgeInsets.all(10),
                                child: Text("£",
                                    style: TextStyle(
                                        fontSize: 18.sp, color: Colors.grey))),
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
                SizedBox(height: 10.h,),
                Container(
                    padding:EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(.5),
                          blurRadius: 5.0,
                          spreadRadius: 0.0,
                          offset: Offset(
                            1.0,
                            1.0,
                          ),
                        )
                      ],
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child:Column(
                      crossAxisAlignment:CrossAxisAlignment.start,
                      mainAxisSize:MainAxisSize.min,
                      children: [
                        Text(
                          '2 Corinthians 9:7',
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              color: Colors.grey.shade700,
                              fontSize: 16.sp),
                        ),
                        SizedBox(height: 10.h,),
                        Text(
                          'Each of you should give what you have decided in your heart to give, not reluctantly or under compulsion, for God loves a cheerful giver.',
                          style: TextStyle(
                              fontWeight: FontWeight.w400,
                              color: Colors.grey.shade600,
                              fontSize: 14.h),
                        ),
                      ],
                    )
                ),
                SizedBox(height: 10.h,),
                Container(
                    padding:EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(.5),
                          blurRadius: 5.0,
                          spreadRadius: 0.0,
                          offset: Offset(
                            1.0,
                            1.0,
                          ),
                        )
                      ],
                      borderRadius: BorderRadius.circular(10),
                    ),
                  width:double.infinity,
                  child: Column(
                    mainAxisSize:MainAxisSize.min,
                    crossAxisAlignment:CrossAxisAlignment.center,
                    children:[
                      Text('Account Numbers', style:TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold)),
                      SizedBox(height: 10.h,),
                      Text('Acct No.: 13888967',style:TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w400)),
                      SizedBox(height: 5.h,),
                      Text('SWIFTBIC: BUKBGB22',style:TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w400)),
                      SizedBox(height: 5.h,),
                      Text('Sort Code: 20-79-06 ',style:TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w400)),
                      SizedBox(height: 5.h,),
                      Text('IBAN: GB77BUKB20790613888967',style:TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w400)),
                    ]
                  )
                ),
                SizedBox(
                  height: 10.h,
                ),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 20.h),
                  padding: EdgeInsets.all(5),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Pallet.primaryColor,
                  ),
                  child: FlatButton(
                      onPressed: () {
                        if (hasData) {
                          var route = new MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  OnlinePaymentPage(
                                    paymentLink: _paymentProvider.paymentUrl,
                                  ));
                          Navigator.of(context).push(route);
                        } else {
                          flutterToast(
                              "Oops, Please fill all the fields", true);
                        }
                      },
                      child: Text(
                        "GIVE",
                        style: TextStyle(
                            fontWeight: FontWeight.w800,
                            color: Colors.white,
                            fontSize: 16.sp),
                      )),
                )
              ],
            )
          ]),
        ));
  }

  bool get hasData {
    if (selectedGivingType != null &&
        selectedGivingType.isNotEmpty &&
        amountController.text != null &&
        amountController.text.isNotEmpty) {
      return true;
    } else {
      return false;
    }
  }

  Widget showGivingBottomSheet(List<String> givingType, BuildContext context) {
    final _paymentProvider =
        Provider.of<PaymentProvider>(context, listen: false);

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
