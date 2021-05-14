import 'package:flutter/material.dart';
import 'package:intro_slider/dot_animation_enum.dart';
import 'package:intro_slider/intro_slider.dart';
import 'package:intro_slider/slide_object.dart';
import 'package:GLC/main.dart';
/* import 'package:intro_slider/scrollbar_behavior_enum.dart';
import 'package:intro_slider_example/home.dart'; */

/* void main() => runApp(new MyApp()); */

class sliderApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: IntroScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class IntroScreen extends StatefulWidget {
  IntroScreen({Key key}) : super(key: key);

  @override
  IntroScreenState createState() => new IntroScreenState();
}

// ------------------ Custom config ------------------
// class IntroScreenState extends State<IntroScreen> {
//  List<Slide> slides = [];
//
//  @override
//  void initState() {
//    super.initState();
//
//    slides.add(
//      new Slide(
//        title:
//            "A VERY LONG TITLE A VERY LONG TITLE A VERY LONG TITLE A VERY LONG TITLE A VERY LONG TITLE A VERY LONG TITLE A VERY LONG TITLE A VERY LONG TITLE A VERY LONG TITLE",
//        maxLineTitle: 2,
//        styleTitle:
//            TextStyle(color: Colors.white, fontSize: 30.0, fontWeight: FontWeight.bold, fontFamily: 'RobotoMono'),
//        description:
//            "Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Donec quam felis, ultricies nec, pellentesque eu, pretium quis, sem. Nulla consequat massa quis enim. Donec pede justo, fringilla vel, aliquet nec, vulputate eget, arcu. In enim justo, rhoncus ut, imperdiet a, venenatis vitae, justo. Nullam dictum felis eu pede mollis pretium. Integer tincidunt. Cras dapibus. Vivamus elementum semper nisi. Aenean vulputate eleifend tellus. Aenean leo ligula, porttitor eu, consequat vitae, eleifend ac, enim. Aliquam lorem ante, dapibus in, viverra quis, feugiat a, tellus. Phasellus viverra nulla ut metus varius laoreet. Quisque rutrum. Aenean imperdiet. Etiam ultricies nisi vel augue. Curabitur ullamcorper ultricies nisi. Nam eget dui. Etiam rhoncus. Maecenas tempus, tellus eget condimentum rhoncus, sem quam semper libero, sit amet adipiscing sem neque sed ipsum. Nam quam nunc, blandit vel, luctus pulvinar, hendrerit id, lorem. Maecenas nec odio et ante tincidunt tempus. Donec vitae sapien ut libero venenatis faucibus. Nullam quis ante. Etiam sit amet orci eget eros faucibus tincidunt. Duis leo. Sed fringilla mauris sit amet nibh. Donec sodales sagittis magna. Sed consequat, leo eget bibendum sodales, augue velit cursus nunc,",
//        styleDescription:
//            TextStyle(color: Colors.white, fontSize: 20.0, fontStyle: FontStyle.italic, fontFamily: 'Raleway'),
//        marginDescription: EdgeInsets.only(left: 20.0, right: 20.0, top: 20.0, bottom: 70.0),
//        centerWidget: Text("Replace this with a custom widget", style: TextStyle(color: Colors.white)),
//        colorBegin: Color(0xffFFDAB9),
//        colorEnd: Color(0xff40E0D0),
//        backgroundImage: 'images/photo_eraser.png',
//        directionColorBegin: Alignment.topLeft,
//        directionColorEnd: Alignment.bottomRight,
//        onCenterItemPress: () {},
//      ),
//    );
//    slides.add(
//      new Slide(
//        title: "MUSEUM",
//        styleTitle:
//            TextStyle(color: Color(0xffD02090), fontSize: 30.0, fontWeight: FontWeight.bold, fontFamily: 'RobotoMono'),
//        description: "Ye indulgence unreserved connection alteration appearance",
//        styleDescription:
//            TextStyle(color: Color(0xffD02090), fontSize: 20.0, fontStyle: FontStyle.italic, fontFamily: 'Raleway'),
//        pathImage: "images/photo_museum.png",
//        colorBegin: Color(0xffFFFACD),
//        colorEnd: Color(0xffFF6347),
//        directionColorBegin: Alignment.topRight,
//        directionColorEnd: Alignment.bottomLeft,
//      ),
//    );
//    slides.add(
//      new Slide(
//        title: "COFFEE",
//        styleTitle:
//            TextStyle(color: Color(0xffD02090), fontSize: 30.0, fontWeight: FontWeight.bold, fontFamily: 'RobotoMono'),
//        description:
//            "Much evil soon high in hope do view. Out may few northward believing attempted. Yet timed being songs marry one defer men our. Although finished blessing do of",
//        styleDescription:
//            TextStyle(color: Color(0xffD02090), fontSize: 20.0, fontStyle: FontStyle.italic, fontFamily: 'Raleway'),
//        pathImage: "images/photo_coffee_shop.png",
//        colorBegin: Color(0xffFFA500),
//        colorEnd: Color(0xff7FFFD4),
//        directionColorBegin: Alignment.topCenter,
//        directionColorEnd: Alignment.bottomCenter,
//        maxLineTextDescription: 3,
//      ),
//    );
//  }
//
//  void onDonePress() {
//    // Do what you want
//    // Navigator.push(
//    //   context,
//    //   MaterialPageRoute(builder: (context) => HomeScreen()),
//    // );
//  }
//
//  Widget renderNextBtn() {
//    return Icon(
//      Icons.navigate_next,
//      color: Color(0xffD02090),
//      size: 35.0,
//    );
//  }
//
//  Widget renderDoneBtn() {
//    return Icon(
//      Icons.done,
//      color: Color(0xffD02090),
//    );
//  }
//
//  Widget renderSkipBtn() {
//    return Icon(
//      Icons.skip_next,
//      color: Color(0xffD02090),
//    );
//  }
//
//  @override
//  Widget build(BuildContext context) {
//    return new IntroSlider(
//      // List slides
//      slides: this.slides,
//
//      // Skip button
//      renderSkipBtn: this.renderSkipBtn(),
//      colorSkipBtn: Color(0x33000000),
//      highlightColorSkipBtn: Color(0xff000000),
//
//      // Next button
//      renderNextBtn: this.renderNextBtn(),
//
//      // Done button
//      renderDoneBtn: this.renderDoneBtn(),
//      onDonePress: this.onDonePress,
//      colorDoneBtn: Color(0x33000000),
//      highlightColorDoneBtn: Color(0xff000000),
//
//      // Dot indicator
//      colorDot: Color(0x33D02090),
//      colorActiveDot: Color(0xffD02090),
//      sizeDot: 13.0,
//
//      // Show or hide status bar
//      hideStatusBar: true,
//      backgroundColorAllSlides: Colors.grey,
//
//      // Scrollbar
//      verticalScrollbarBehavior: scrollbarBehavior.SHOW_ALWAYS,
//    );
//  }
// }

// ------------------ Custom your own tabs ------------------
class IntroScreenState extends State<IntroScreen> {
  List<Slide> slides = [];
  int positioner = 0;

  Function goToTab;

  @override
  void initState() {
    super.initState();

    slides.add(
      new Slide(
        title: "Community of God's Children",
        styleTitle: TextStyle(
            color: Color(0xff3da4ab),
            fontSize: 30.0,
            fontWeight: FontWeight.bold,
            fontFamily: 'RobotoMono'),
        description:
            "To grow in the Faith, You need a community of Believers around you. This App provides you with that connection.",
        styleDescription: TextStyle(
            color: Color(0xfffe9c8f),
            fontSize: 20.0,
            fontStyle: FontStyle.italic,
            fontFamily: 'Raleway'),
        pathImage: "assets/person.jpg",
      ),
    );
    
    slides.add(
      new Slide(
        title: "Work with Faith",
        styleTitle: TextStyle(
          color: Color(0xff3da4ab),
          fontSize: 30.0,
          fontWeight: FontWeight.bold,
          fontFamily: 'RobotoMono',
        ),
        description:
            '"Without Faith, It is impossible to please God." We need to consistently build our faith in the word of God',
        styleDescription: TextStyle(
            color: Color(0xfffe9c8f),
            fontSize: 20.0,
            fontStyle: FontStyle.italic,
            fontFamily: 'Raleway'),
        pathImage: "assets/lady_pray.jpeg",
      ),
    );
    
    slides.add(
      new Slide(
        title: "Believe in the Lord",
        styleTitle: TextStyle(
            color: Color(0xff3da4ab),
            fontSize: 30.0,
            fontWeight: FontWeight.bold,
            fontFamily: 'RobotoMono'),
        description:
            "Believe in the Lord and lean not on your own understanding. The Lord would direct your Path. ",
        styleDescription: TextStyle(
            color: Color(0xfffe9c8f),
            fontSize: 20.0,
            fontStyle: FontStyle.italic,
            fontFamily: 'Raleway'),
        pathImage: "assets/blog_1.png",
      ),
    );
  }

  void onDonePress() {
    // Back to the first tab
    Navigator.of(context).pushReplacement(MaterialPageRoute(
    builder: (BuildContext context) => MyApp()));
    //this.goToTab(0);
  }

  void onTabChangeCompleted(index) {
    // Index of current tab is focused
    positioner = index;
  }

  Widget renderNextBtn() {
    return Icon(
      Icons.navigate_next,
      color: Color(0xffffcc5c),
      size: 35.0,
    );
  }

  Widget renderDoneBtn() {
    return Icon(
      Icons.done,
      color: Color(0xffffcc5c),
    );
  }

  Widget renderSkipBtn() {
    return Icon(
      Icons.skip_next,
      color: Color(0xffffcc5c),
    );
  }

  List<Widget> renderListCustomTabs() {
    List<Widget> tabs = [];
    //double containedHeight = MediaQuery.of(context).size.height * 0.85;
    for (int i = 0; i < slides.length; i++) {
      Slide currentSlide = slides[i];
      tabs.add(
       Container(
            //height: containedHeight,
            //color: Colors.cyan,
            //height: 300,
            child: Stack(
              children: <Widget>[
                Align(
                  alignment: Alignment.topCenter,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.orange,
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: AssetImage(currentSlide.pathImage)
                      )
                    ),
                    //child: Image.asset("assets/person.jpg"),
                  ),
                ),

                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    height: 280,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(34),
                        topRight: Radius.circular(34),
                      ),
                      color: Colors.white,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Text(
                            currentSlide.title,
                            style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                              color: Colors.orange,
                            ),
                          ),
                        ),
                        Text(
                          currentSlide.description ,
                          style: TextStyle(
                            fontSize: 19,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),

      );
    }
    return tabs;
  }

    /* new IntroSlider(
          // Skip button
          renderSkipBtn: this.renderSkipBtn(),
          colorSkipBtn: Color(0x33ffcc5c),
          highlightColorSkipBtn: Color(0xffffcc5c),

          // Next button
          renderNextBtn: this.renderNextBtn(),

          // Done button
          renderDoneBtn: this.renderDoneBtn(),
          onDonePress: this.onDonePress,
          colorDoneBtn: Color(0x33ffcc5c),
          highlightColorDoneBtn: Color(0xffffcc5c),

          // Dot indicator
          colorDot: Color(0xffffcc5c),
          sizeDot: 13.0,
          typeDotAnimation: dotSliderAnimation.SIZE_TRANSITION,

          // Tabs
          slides:slides,
          listCustomTabs: this.renderListCustomTabs(),
          backgroundColorAllSlides: Colors.white,
          refFuncGoToTab: (refFunc) {
            this.goToTab = refFunc;
          },

          // Behavior
          isScrollable: true,
          //scrollPhysics: BouncingScrollPhysics(),

          // Show or hide status bar
          shouldHideStatusBar: true,
          //hideStatusBar: true,

          // On tab change completed
          onTabChangeCompleted: this.onTabChangeCompleted,
        ), */
  String contenters = " ";
  @override
  Widget build(BuildContext context) {
    if ( positioner < 2){
      contenters = " Next ";
    }else{
      contenters = " Let's get Started ";
    }
    //double containedHeight = double.infinity * 0.85;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Expanded(
            flex: 800,
            child: Container(
              color: Colors.white,
              //height: 300,
              child: new IntroSlider(
                // Skip button
                renderSkipBtn: this.renderSkipBtn(),
                colorSkipBtn: Color(0x33ffcc5c),
                highlightColorSkipBtn: Color(0xffffcc5c),

                // Next button
                renderNextBtn: this.renderNextBtn(),

                // Done button
                renderDoneBtn: this.renderDoneBtn(),
                onDonePress: this.onDonePress,
                colorDoneBtn: Color(0x33ffcc5c),
                highlightColorDoneBtn: Color(0xffffcc5c),

                // Dot indicator
                colorDot: Color(0xffffcc5c),
                sizeDot: 10.0,
                typeDotAnimation: dotSliderAnimation.SIZE_TRANSITION,

                // Tabs
                slides:slides,
                listCustomTabs: this.renderListCustomTabs(),
                backgroundColorAllSlides: Colors.white,
                refFuncGoToTab: (refFunc) {
                  this.goToTab = refFunc;
                },

                // Behavior
                isScrollable: true,
                //scrollPhysics: BouncingScrollPhysics(),

                // Show or hide status bar
                shouldHideStatusBar: true,
                //hideStatusBar: true,

                onTabChangeCompleted: this.onTabChangeCompleted,
              ),
            ),
          ),

          Expanded(
            flex: 200,
            child: Container(
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(12, 35, 12, 35),
                child: InkWell(
                  onTap: () {
                    onDonePress();
                  },
                  child: Container(
                    color: Colors.orange,
                    width: MediaQuery.of(context).size.width * 0.8,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(contenters, 
                          style: TextStyle(
                            color: Colors.white,
                          )
                        ),
                        Icon(Icons.arrow_forward, color: Colors.white,),
                      ],
                    ),
                  ),
                ),
                
                
              ),
            ),
          )
        ],
      ),
    );
    
    
    
  }
}

//------------------ Default config ------------------
// class IntroScreenState extends State<IntroScreen> {
//  List<Slide> slides = [];
//
//  @override
//  void initState() {
//    super.initState();
//
//    slides.add(
//      new Slide(
//        title: "ERASER",
//        description: "Allow miles wound place the leave had. To sitting subject no improve studied limited",
//        pathImage: "images/photo_eraser.png",
//        backgroundColor: Color(0xfff5a623),
//      ),
//    );
//    slides.add(
//      new Slide(
//        title: "PENCIL",
//        description: "Ye indulgence unreserved connection alteration appearance",
//        pathImage: "images/photo_pencil.png",
//        backgroundColor: Color(0xff203152),
//      ),
//    );
//    slides.add(
//      new Slide(
//        title: "RULER",
//        description:
//        "Much evil soon high in hope do view. Out may few northward believing attempted. Yet timed being songs marry one defer men our. Although finished blessing do of",
//        pathImage: "images/photo_ruler.png",
//        backgroundColor: Color(0xff9932CC),
//      ),
//    );
//  }
//
//  void onDonePress() {
//    // Do what you want
//  }
//
//  @override
//  Widget build(BuildContext context) {
//    return new IntroSlider(
//      slides: this.slides,
//      onDonePress: this.onDonePress,
//    );
//  }
// }