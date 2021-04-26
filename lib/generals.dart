import 'package:shared_preferences/shared_preferences.dart';  
//import 'dart:';

  
  add_string_2_SP(key, value) async{
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setString(key, value);
  }

  read_from_SP(key) async{
    SharedPreferences pref = await SharedPreferences.getInstance();
    String content = pref.getString(key);
    return content;
  }

  check_in_SP(key) async{
    SharedPreferences pref = await SharedPreferences.getInstance();
    bool content = pref.containsKey(key);
    return content;
  }

/* checkers() async {
  if(await check_in_SP("token") == true){
    return await read_from_SP("token");
  }else{
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (BuildContext context) => user_connect() ),
        (Route<dynamic> route ) => false
      );
  }
} */