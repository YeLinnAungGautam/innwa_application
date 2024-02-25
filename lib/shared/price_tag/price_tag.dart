import 'package:flutter/material.dart';
import 'package:innwa_mobile_dev/util/constants.dart';

class PriceTag extends StatelessWidget {

  String text;
  PriceTag({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [        
        Text(text, style: TextStyle(fontFamily: "SanFrancisco", color: kZambeziColor,fontSize: 13.0),)
      ],
    );
  }
}