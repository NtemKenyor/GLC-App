
import 'package:flutter/material.dart';


class Display_content extends StatelessWidget {
  final String title, content, createdDate, upDated;
  Display_content(this.title, this.content, this.createdDate, this.upDated);

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        body: new Container(
          color: Colors.white,
          width: double.infinity,
          child: ListView(
            //mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              SizedBox(height: 60,),
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Text(title,
                    style: TextStyle(
                      fontSize: 21,
                      fontWeight: FontWeight.bold,
                      decorationStyle: TextDecorationStyle.double,
                    ),
                  ),
                ),
              ),
              Text("Created: " + createdDate,
                style: TextStyle(
                  fontSize: 12,
                  fontStyle: FontStyle.italic,
                ),
              ),

              Text(" Updated: "+upDated,
                style: TextStyle(
                  fontSize: 12,
                  fontStyle: FontStyle.italic,
                ),
              ),
               
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Text(content,
                  style: TextStyle(
                    fontSize: 17,
                  ),
                  textAlign: TextAlign.justify,
                ),
              ),
            ],
          ),
        ),
    );
  }
}
//end
