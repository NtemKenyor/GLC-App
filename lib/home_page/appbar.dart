import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class CustomAppBarFull extends StatelessWidget with PreferredSizeWidget {
  final VoidCallback openMenuCallback;
   CustomAppBarFull({
    this.openMenuCallback,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration:BoxDecoration(color:Colors.white),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
              height: 20.h,
              width:double.infinity,
              decoration: BoxDecoration(
                color:Colors.orange,
                borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(20.0),
                    bottomLeft: Radius.circular(20.0)),
              )
          ),
          SizedBox(height: 5.h,),
          Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                IconButton(
                  icon: Icon(Icons.menu, color: Color.fromRGBO(119, 102, 102, 1),),
                  onPressed: openMenuCallback,
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(right: 30.w),
                    child: Image.asset("assets/glc logo 1.png", width: 120.w, height: 55.h,),
                  ),
                ),
                // IconButton(
                //   onPressed: ()=> {userSide()},
                //   icon: Icon(Icons.power, color:Colors.red ),
                //   color: dark_,
                // )
              ]
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => Size(
      double.infinity, 90.h);
}
