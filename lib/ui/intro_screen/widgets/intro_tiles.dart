import 'package:GLC/utils/pallet.dart';
import 'package:flutter/material.dart';

class SliderTile extends StatelessWidget {
  final String imagePath;
  final String title;
  final String subtitle;

  const SliderTile({Key key, this.imagePath, this.title, this.subtitle})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Stack(
      children: [
        Container(
          height: size.height /1.8,
          decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/$imagePath.jpg"),
                fit: BoxFit.cover,
              )),
        ),
        Align(
          alignment:Alignment.bottomCenter,
          child: Container(
            height: size.height/2,
            decoration:BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(topLeft: Radius.circular(70),topRight: Radius.circular(70)),
            ),
            padding: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
            child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(height: 50,),
            Text(title,  textAlign: TextAlign.center,style: TextStyle(
              fontSize: 30,
              color: Pallet.primaryColor,
              fontWeight: FontWeight.w700
            ),),
            SizedBox(height: 16,),
            Text(subtitle,
                textAlign: TextAlign.center,
                style: TextStyle(
                )),
          ],
            ),
          ),
        )
      ],
    );
  }
}
