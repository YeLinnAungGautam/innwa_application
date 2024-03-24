import 'package:flutter/material.dart';
import 'package:innwa_mobile_dev/shared/texts/roboto_text/roboto_text.dart';

class Discount extends StatelessWidget {
  Color bg;
  Color fontColor;
  String text;
  FontWeight fontWeight;
  Discount({super.key,required this.bg, required this.fontColor, required this.text, required this.fontWeight});

  @override
  Widget build(BuildContext context) {
    return Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8), color: bg),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: RobotoText(
                      fontSize: 13.0,
                      fontColor: fontColor,
                      text: text,
                      fontWeight: fontWeight),
                ),
              );
  }
}