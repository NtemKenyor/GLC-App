import 'package:intl/intl.dart';

class DateUtil{
  static String format(DateTime dateTime, {String format}){
    var formatter = new DateFormat(format != null ? format : "MMM d, yyyy");// "MMM d, yyyy hh:mm aaa"
    return formatter.format(dateTime);
  }


}