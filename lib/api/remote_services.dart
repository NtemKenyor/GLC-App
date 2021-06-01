import 'dart:convert';

import 'package:GLC/watch/model/bible_verse_response.dart';
import 'package:http/http.dart' as http;

class RemoteServices{

  static var client = http.Client();

  static Future<BibleVerseResponse> fetchBibleVerses()async{
    var response = await client.get(Uri.parse('https://beta.ourmanna.com/api/v1/get/?format=json&order=random'),);

    if (response.statusCode == 200) {
      var jsonString = response.body;
      return BibleVerseResponse.fromJson(json.decode(jsonString));
    } else {
      //show error message
      return null;
    }
  }
}