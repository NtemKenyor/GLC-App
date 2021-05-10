import 'package:GLC/utils/pallet.dart';
import 'package:flutter/material.dart';

import '../../../intro.dart';

class SuccessBottomSheet extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.only(
          topLeft: Radius.circular(40), topRight: Radius.circular(40)),
      child: Container(
        color: Colors.white,
        height: 250,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 30.0),
          child: Column(
            children: [
              SizedBox(
                height: 10,
              ),
              Expanded(
                  child: Column(
                children: [
                  Text(
                    "Your Payment was Successful",
                    style: TextStyle(
                        fontSize: 20,
                        color: Pallet.textDark,
                        fontWeight: FontWeight.w600),
                  ),
                  Divider(),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 20),
                    padding: EdgeInsets.all(5),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: Pallet.primaryColor,
                    ),
                    child: FlatButton(
                        onPressed: () {
                          var route = new MaterialPageRoute(
                              builder: (BuildContext context) => HomePage());
                          Navigator.of(context).pushReplacement(route);
                        },
                        child: Text(
                          "Go Back Home",
                          style: TextStyle(
                              fontWeight: FontWeight.w800,
                              color: Colors.white,
                              fontSize: 16),
                        )),
                  )
                ],
              )),
            ],
          ),
        ),
      ),
    );
  }
}
