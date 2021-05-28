import 'package:flutter/material.dart';


class SplashWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size ss = MediaQuery.of(context).size;

    return SafeArea(
      child: Scaffold(
        body: Stack(
          // mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(height: ss.height / 1.8, decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/praying hands.jpg"),
                  fit: BoxFit.cover,
                ),
                color:Colors.black
            )),
            Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                    height: ss.height / 2,
                    decoration: BoxDecoration(
                      color: Colors.white,

                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(70),
                          topRight: Radius.circular(70)),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Welcome to",style:TextStyle(fontSize: 24, color: Colors.black,fontWeight: FontWeight.w300 )),
                        SizedBox(height:10),
                        Text("GREAT LIGHT",style:TextStyle(fontSize: 30, color: Colors.black,fontWeight: FontWeight.w900 )),
                        SizedBox(height:10),
                        Text("CHURCH",style:TextStyle(fontSize: 28, color: Colors.black,fontWeight: FontWeight.w300  )),
                        SizedBox(height:10),
                        SizedBox(height:10),SizedBox(height:10),
                        Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit. Duis eu ru metus, sit amet laoreet odio sodales sit amet",
                          style:TextStyle(fontSize: 14, color: Colors.grey, ),textAlign: TextAlign.center,),
                        SizedBox(height: 30,),
                        CircularProgressIndicator()
                      ],
                    )
                )),
            Positioned(
              right: 50,
              left:50,
              top: 330,
              child: Container(
                  height: 100,
                  width: 100,
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset: Offset(0, 3), // changes position of shadow
                      ),
                    ],
                  ),

                  child: Container(
                    height: 70,
                    width: 70,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      image: DecorationImage(alignment: Alignment.center,
                        image: AssetImage("assets/glc_splash_logo.png",),
                        fit: BoxFit.contain,
                      ),
                    ),
                  )
              ),
            )
          ],
        ), // This trailing comma makes auto-formatting nicer for build methods.
      ),
    );
  }
}
