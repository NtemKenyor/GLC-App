
import 'package:GLC/ui/intro_screen/models/intro_screen_model.dart';

class Constants{
  static const dummyText = 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aenean at lacinia ipsum. Donec venenatis nec justo eget ultrices. Mauris vehicula egestas enim vitae sagittis';
  static const dummyAddress = '8, Skylines Limeharbour London E14 9TS';

  static get introductionList {
    return [
      IntroductionTiles(title: "Work with Faith",
          body: 'ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum',
          imagePath: 'prayer'),
      IntroductionTiles(title: "Community of God's children",
          body: "in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur "
              "sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum",
          imagePath: 'praying hands'),
      IntroductionTiles(title: "Believe in the Lord",
          body: 'ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum', imagePath: "bible_image")
    ];
  }


  static const BASE_URL = "https://app.glclondon.church";
  static const USER_TOKEN = 'token';
  static const USER_EMAIL = 'email';
}