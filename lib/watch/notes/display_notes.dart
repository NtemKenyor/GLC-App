import 'package:flutter/material.dart';

class Display_content extends StatelessWidget {
  final String title, content, createdDate, upDated;

  Display_content(this.title, this.content, this.createdDate, this.upDated);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: new Scaffold(
        body: new Container(
          padding:EdgeInsets.all(20),
          color: Colors.white,
          width: double.infinity,
          child: Column(
            children: <Widget>[
              SizedBox(height: 30,),
              Text(
                title,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                "Created: " + createdDate + " Updated: " + upDated,
                style: TextStyle(
                  fontSize: 12,
                ),
              ),
              Expanded(
                  child: Text(
                content,
                style: TextStyle(
                  fontSize: 16,
                ),
              )),
            ],
          ),
        ),
      ),
    );
  }
}
//end
