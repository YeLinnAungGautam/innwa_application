import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class RobotoTextPadding extends StatelessWidget {
  double? fontSize;
  Color? fontColor;
  String? text;
  FontWeight? fontWeight;
  int? maxLine;
  double? padding;
  RobotoTextPadding({super.key,required this.padding, this.fontSize, required this.fontColor,required this.text, this.fontWeight,this.maxLine});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top:padding!, bottom: padding!),
      child: Text(text!,
        style: TextStyle(
            fontFamily: 'SanFrancisco',
            fontSize: fontSize,
            color: fontColor,
            fontWeight: fontWeight),
        maxLines: this.maxLine ?? 1,
        overflow: TextOverflow.ellipsis)
    );
  }
}