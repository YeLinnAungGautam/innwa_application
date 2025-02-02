import 'package:flutter/material.dart';

class Heading extends StatelessWidget {
  String text;
  Heading({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Text(text,
        style: const TextStyle(
            fontFamily: 'SanFrancisco',
            fontSize: 18.0,
            color: Colors.black,
            fontWeight: FontWeight.w300),
        overflow: TextOverflow.ellipsis);
  }
}
