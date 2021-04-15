//import 'dart:html';
import 'dart:io';
import 'dart:async';
import 'package:path_provider/path_provider.dart';


  Function read_from_file(path){
    File(path).readAsString().then((String contents) {
      return contents;
    });
  }


 Future<String> get _localPath async{
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  void write_to_file(path, write_this) async{
    var file = await File(path).writeAsString(write_this);
  }

/*   Future<String> read_from_assets(path) async {
    return await rootBundle.loadString(path);
  } */