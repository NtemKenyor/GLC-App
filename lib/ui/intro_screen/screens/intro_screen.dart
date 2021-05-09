
import 'package:GLC/ui/intro_screen/models/intro_screen_model.dart';
import 'package:GLC/ui/intro_screen/widgets/intro_tiles.dart';
import 'package:GLC/utils/pallet.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../main.dart';

class IntroductionScreen extends StatefulWidget {
  final SharedPreferences prefs;
  final String boolKey;
  IntroductionScreen(this.prefs, this.boolKey);


  @override
  _IntroductionScreenState createState() => _IntroductionScreenState();
}

class _IntroductionScreenState extends State<IntroductionScreen> {
  int currentIndex = 0;
  PageController pageController = new PageController(initialPage: 0);

  String actionText = "Next";

  List<IntroductionTiles> introductionList(){
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

  Widget skipButton(){
    return InkWell(
      onTap:(){
        pageController.animateToPage(introductionList().length - 1,
            duration: Duration(milliseconds: 400), curve: Curves.linear);
      },
      child: Text('Skip', style:TextStyle(color:Colors.white, fontSize:18)),
    );
  }




  @override
  Widget build(BuildContext context) {
    widget.prefs.setBool(widget.boolKey, false);
    Size size = MediaQuery.of(context).size;
    return SafeArea(
        child:Scaffold(
          body:Stack(
            children: [
              PageView.builder(
                  controller: pageController,
                  onPageChanged: (val) {
                    setState(() {
                      currentIndex = val;
                      if(currentIndex ==introductionList().length){
                        actionText = "Let's Get Started";
                      }
                    });
                  },
                  itemCount: introductionList().length,
                  itemBuilder: (context, index) {
                    return SliderTile(
                      title: introductionList()[index].title,
                      subtitle: introductionList()[index].body,
                      imagePath: introductionList()[index].imagePath,
                    );
                  }),
              Positioned(
                left: 50,
                right: 50,
                bottom: 50,
                child: TextButton(
                  style: ButtonStyle(
                    foregroundColor: MaterialStateProperty.all<Color>(Pallet.primaryColor),
                  ),
                  onPressed: () {
                   if(currentIndex ==2){
                     Navigator.of(context).pushReplacement(MaterialPageRoute(
                         builder: (BuildContext context) => MyApp() ));
                   }else{
                     pageController.animateToPage(currentIndex + 1,
                         duration: Duration(milliseconds: 400), curve: Curves.linear);
                   }
                  },
                  child: Container(
                    height: size.width * .15,
                    width: size.width/2,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      color: Pallet.primaryColor,
                    ),
                    child: Row(
                      mainAxisSize:MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(currentIndex==2? "Let's Get Started": "Next", style: TextStyle(color:Colors.white, fontSize: 18),),
                          SizedBox(width: 10,),
                          Icon(Icons.arrow_forward, color:Colors.white)
                      ],
                    ),
                  ),
                )
                ),
              Positioned(
                top: 40,
                  right: 40,
                  child: skipButton()),
              Positioned(
                  bottom: 150,
                    right: 40,
                    left:40,
                    child: dotIndicatorBuilder()),


            ],
          )
        )
    );
  }



  Widget dotIndicatorBuilder() {
    return Container(
      width: double.infinity,
      child: Row(
        mainAxisAlignment:MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          for (int i = 0; i < introductionList().length; i++)
            currentIndex == i
                ? pageIndexIndicator(true)
                : pageIndexIndicator(false)
        ],
      ),
    );
  }



  Widget pageIndexIndicator(bool isCurrentPage) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 4.0),
      height: isCurrentPage ? 15.0 : 8.0,
      width: isCurrentPage ? 15.0 : 8.0,
      decoration: BoxDecoration(
          color: isCurrentPage ? Pallet.primaryColor : Colors.blueGrey,
          borderRadius: BorderRadius.circular(12.0)),
    );
  }
}



