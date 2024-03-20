import 'package:flutter/material.dart';

class RobotoText extends StatelessWidget {
  double? fontSize;
  Color? fontColor;
  String? text;
  FontWeight? fontWeight;
  int? maxLine;

  RobotoText(
      {super.key,
      required this.fontSize,
      required this.fontColor,
      required this.text,
      this.fontWeight,
      this.maxLine});

  @override
  Widget build(BuildContext context) {
    return Text(text!,
        style: TextStyle(
            fontFamily: 'SanFrancisco',
            fontSize: fontSize,
            color: fontColor,
            fontWeight: fontWeight),
        textAlign: TextAlign.justify,
        maxLines: maxLine ?? 1,
        overflow: TextOverflow.ellipsis);
  }
}
