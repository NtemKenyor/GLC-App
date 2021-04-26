
import 'package:flutter/material.dart';


class Display_content extends StatelessWidget {
  final String title, content, createdDate, upDated;
  Display_content(this.title, this.content, this.createdDate, this.upDated);

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      theme: ThemeData(
        primaryColor: Colors.black,
        accentColor: Color(0xFFDBECF1),
        scaffoldBackgroundColor: Colors.black45,
      ),
      home: new Scaffold(
        body: new Container(
          color: Colors.white,
          width: double.infinity,
          child: Column(
            children: <Widget>[
              Text(title,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text("Created: " + createdDate + " Updated: "+upDated, 
                style: TextStyle(
                  fontSize: 12,
                ),
              ),
              Expanded(
                child: Text(content,
                  style: TextStyle(
                    fontSize: 16,
                  ),
                )
              ),
            ],
          ),
        ),
      ),
    );
  }
}
//end
