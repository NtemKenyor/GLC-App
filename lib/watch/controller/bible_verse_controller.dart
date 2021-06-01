import 'package:GLC/api/remote_services.dart';
import 'package:GLC/watch/model/bible_verse_response.dart';
import 'package:get/state_manager.dart';

class BibleVerseController extends GetxController {
  Rx<BibleVerseResponse> response = BibleVerseResponse().obs;

  Rx<bool> loading = false.obs;
  @override
  void onInit() {
    super.onInit();
    getBibleVersesFromAPI();

  }



  getBibleVersesFromAPI()async{
    try {
      loading(true);
      var bibleVerseResponse = await RemoteServices.fetchBibleVerses();
      if (bibleVerseResponse != null) {
        response(bibleVerseResponse);
      }
    } finally {
      loading(false);
    }
  }










}
