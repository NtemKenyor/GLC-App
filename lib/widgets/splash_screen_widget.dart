import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class SplashWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size ss = MediaQuery.of(context).size;

    return SafeArea(
      child: Scaffold(
        body: Stack(
          // mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(height: ss.height/1.2.h, decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/raising_hands.jpg"),
                  fit: BoxFit.cover,
                ),
                color:Colors.black
            )),
            Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                    height: ss.height/2.h,
                    decoration: BoxDecoration(
                      color: Colors.white,

                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(70),
                          topRight: Radius.circular(70)),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 20.h),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(height: 10.h,),
                        Text("Welcome to",style:TextStyle(fontSize: 24.sp, color: Colors.black,fontWeight: FontWeight.w300 )),
                        SizedBox(height:5.h),
                        Text("GREAT LIGHT",style:TextStyle(fontSize: 30.sp, color: Colors.black,fontWeight: FontWeight.w900 )),
                        SizedBox(height:5.h),
                        Text("CHURCH",style:TextStyle(fontSize: 28.sp, color: Colors.black,fontWeight: FontWeight.w300  )),

                        SizedBox(height:10),SizedBox(height:10.h),
                        Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit. Duis eu ru metus, sit amet laoreet odio sodales sit amet",
                          style:TextStyle(fontSize: 14.sp, color: Colors.grey, ),textAlign: TextAlign.center,),
                        SizedBox(height: 30,),
                        CircularProgressIndicator()
                      ],
                    )
                )),
            Positioned(
              right: 50.w,
              left:50.w,
              top: 330.h,
              child: Container(
                  height: 100.h,
                  width: 100.w,
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
                    height: 70.h,
                    width: 70.w,
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
