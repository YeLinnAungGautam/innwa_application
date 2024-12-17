import 'package:flutter/material.dart';
import 'package:innwa_mobile_dev/shared/texts/roboto_text/roboto_text.dart';

class DeliInfo extends StatelessWidget {
  String leftText;
  String rightText;
  bool isLongText;
  DeliInfo(
      {super.key,
      required this.leftText,
      required this.rightText,
      required this.isLongText});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
              child: RobotoText(
            fontSize: 15.0,
            fontColor: Colors.black,
            text: leftText,
            fontWeight: FontWeight.bold,
          )),
          isLongText
              ? Expanded(
                  flex: 1,
                  child: RobotoText(
                    fontSize: 15.0,
                    fontColor: Colors.black,
                    text: rightText,
                    maxLine: 3,
                  ))
              : RobotoText(
                  fontSize: 15.0,
                  fontColor: Colors.black,
                  text: rightText,
                )
        ],
      ),
    );
  }
}
