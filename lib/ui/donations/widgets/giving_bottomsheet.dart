import 'package:flutter/material.dart';

class GivingBottomSheet extends StatelessWidget {
  List<String> givingTypes;
  final ValueChanged<String> onSelected;

  GivingBottomSheet(this.givingTypes, this.onSelected);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.only(
          topLeft: Radius.circular(40), topRight: Radius.circular(40)),
      child: Container(
        color: Colors.white,
        height: 300,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 0.0, vertical: 30.0),
          child: Column(
            children: [
              Text(
                'Select Donation Type',
                style: TextStyle(
                    fontSize: 18,
                    color: Color(0xff697180),
                    fontWeight: FontWeight.w700),
              ),
              SizedBox(
                height: 10,
              ),
              Expanded(
                  child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: givingTypes.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          child: Column(
                            children: [
                              InkWell(
                                onTap: () {
                                  onSelected(givingTypes[index]);
                                  Navigator.pop(context);
                                },
                                child: ListTile(
                                  //contentPadding: EdgeInsets.zero,
                                  title: Text(
                                    givingTypes[index],
                                    style: TextStyle(
                                        fontWeight: FontWeight.w600),
                                  ),
                                ),
                                // CustomSheetTile(
                                //   label: deliveryTypes[index].name,
                                // ),
                              ),
                              Divider()
                            ],
                          ),
                        );
                      })),
            ],
          ),
        ),
      ),
    );
  }
}
