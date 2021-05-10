import 'package:GLC/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PaymentProvider extends ChangeNotifier {

  String userEmail;
  String type;
  double amount;


  void setAmount(String val){
    amount =double.parse(val);
    notifyListeners();
  }


  void setType(String val){
    type =val;
    notifyListeners();
  }


  getSharedPrefValue(String val) async{
    SharedPreferences pref = await SharedPreferences.getInstance();
    String content = pref.getString(val);
    return content;
  }
  getUserEmail() async {
    userEmail = await getSharedPrefValue(Constants.USER_EMAIL);
  }

  String get paymentUrl => "https://app.glclondon.church/payments/?type=$type&amount=$amount&email=$userEmail";
}