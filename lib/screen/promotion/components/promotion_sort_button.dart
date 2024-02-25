import 'package:flutter/material.dart';
import 'package:innwa_mobile_dev/shared/texts/roboto_text/roboto_text.dart';

class PromotionSortButton extends StatefulWidget {
  const PromotionSortButton({super.key});

  @override
  State<PromotionSortButton> createState() => _PromotionSortButtonState();
}

class _PromotionSortButtonState extends State<PromotionSortButton> {

  String sortBy = "Default";

  Future<void> _showMyDialog() async {
  return showDialog<void>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        surfaceTintColor: Colors.white,
        backgroundColor: Colors.white,
        title: const Text('Sort By'),
        content:  SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: InkWell(
                  onTap:()=> setState(() {
                      sortBy = "Default";
                      Navigator.of(context).pop();
                  }),
                  child: RobotoText(fontSize: 18.0, fontColor: Colors.black, text: "Default"),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: InkWell(
                  onTap:()=> setState(() {
                      sortBy = "Most Popular";
                      Navigator.of(context).pop();
                  }),
                  child: RobotoText(fontSize: 18.0, fontColor: Colors.black, text: "Most Populat"),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: InkWell(
                  onTap:()=> setState(() {
                      sortBy = "Best Selling";
                      Navigator.of(context).pop();
                  }),
                  child: RobotoText(fontSize: 18.0, fontColor: Colors.black, text: "Best Selling"),
                ),
              )
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: const Text('Close'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: _showMyDialog,
      child: Container(
        width: 150,
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
          BoxShadow(
            offset: Offset(3, 3),
            spreadRadius: -3,
            blurRadius: 5,
            color: Color.fromRGBO(191, 191, 191, 1),
          )
        ]),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Icon(Icons.sort,color: Colors.indigo,size: 30,),
              Padding(
                padding: const EdgeInsets.only(left :15.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    RobotoText(fontSize: 15.0, fontColor: Colors.black, text: "Sort By"),
                    RobotoText(fontSize: 12.0, fontColor: Colors.black, text: sortBy)
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
