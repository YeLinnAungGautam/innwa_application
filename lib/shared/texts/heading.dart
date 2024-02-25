import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Heading extends StatelessWidget {
  String text;
  Heading({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left:8.0,top: 1.0, bottom: 15.0),
      child: Text(text,
        style: const TextStyle(
            fontFamily: 'SanFrancisco',
            fontSize: 18.0,
            color: Colors.black,
            fontWeight: FontWeight.w300),
        overflow: TextOverflow.ellipsis)
    );
  }
}