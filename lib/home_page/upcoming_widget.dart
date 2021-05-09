import 'package:GLC/home_page/model/event_model.dart';
import 'package:GLC/utils/constants.dart';
import 'package:GLC/utils/pallet.dart';
import 'package:flutter/material.dart';

class UpcomingWidget extends StatelessWidget {
  final EventModel event;

  UpcomingWidget({Key key, this.event}) : super(key: key);

  get theImager {
    return (event?.imageUrl != null)
        ? Image.network(
            event?.imageUrl,
            fit: BoxFit.fill,
            height: double.infinity,
          )
        : Image.network(
            "https://picsum.photos/id/1019/5472/3648",
            fit: BoxFit.fill,
            height: double.infinity,
          );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 240,
      margin: EdgeInsets.symmetric(horizontal: 5),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              child: Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Container(
                      height: 150,
                      width: 230,
                      child: theImager,
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Padding(
                      padding: EdgeInsets.all(5),
                      child: Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Icon(
                              Icons.calendar_today,
                              color: Colors.white,
                              size: 12,
                            ),
                            SizedBox(width: 5),
                            Flexible(
                                child: Text(event.date ?? '12/4/2021',
                                    maxLines: 1,
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 10))),
                          ]
                          //trailing: Text("Monday, 21st October"),
                          ),
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Padding(
              padding: EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(event.title ?? "Blessings of God in Him",
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          color: Colors.grey.shade700)),
                  Icon(Icons.more_vert, color: Pallet.primaryColor, size: 16)
                ],
              ),
            ),
            Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Text(event.desc ?? Constants.dummyText,
                    style:
                        TextStyle(color: Colors.grey.shade500, fontSize: 13))),
          ],
        ),
      ),
    );
  }
}
