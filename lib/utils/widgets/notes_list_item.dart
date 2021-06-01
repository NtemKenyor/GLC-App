import 'package:GLC/connect/connect_side.dart';
import 'package:GLC/utils/dateutils.dart';
import 'package:GLC/utils/pallet.dart';
import 'package:GLC/watch/notes/display_notes.dart';
import 'package:GLC/watch/notes/models/note_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class NotesListItem extends StatelessWidget {
  NoteModel note;
  NotesListItem(this.note);

  @override
  Widget build(BuildContext context) {
      return  Padding(
        padding: const EdgeInsets.all(8.0),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: InkWell(
            onTap:(){
              var route = new MaterialPageRoute(
                        builder: (BuildContext context) =>
                        Display_content(note.title, note.content, note.createDate, note.upDated));
              Navigator.of(context).push(route);
            },
            child: Container(
              padding:EdgeInsets.symmetric(horizontal: 20.w),
              height: 80.h,
              decoration: BoxDecoration(

                color: Colors.grey.shade200,
                border: Border(
                    left: BorderSide(
                      color: Color.fromRGBO(241, 89, 34, 1),
                      width: 5.h,
                    )
                ),

              ),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children : <Widget>[
                          Text(note.title,
                            style: TextStyle(
                              color:Pallet.textDark,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 10.h,),
                          Row(
                            children: [
                              Icon(Icons.calendar_today,color:Pallet.primaryColor, size:16.sp),
                              SizedBox(width: 10.w,),
                              Text(DateUtil.format(
                                  DateTime.parse(note.createDate ??
                                      ""),), style:TextStyle(color:Pallet.textLight)),
                            ],
                          )
                        ]
                    ),
                  ),

                  Icon(Icons.edit_outlined, color:Pallet.textLight
                  )
                ],
              ),

            ),
          ),
        ),
      );

  }
}
