import 'package:flutter/material.dart';
import 'package:innwa_mobile_dev/util/constants.dart';

class PriceTag extends StatelessWidget {
  final bool haveDiscount;
  String text;
  PriceTag({super.key, required this.text, this.haveDiscount = false});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          text,
          style: TextStyle(
            fontFamily: "SanFrancisco",
            color: kZambeziColor,
            fontSize: haveDiscount ? 10.0 : 13,
            decoration: haveDiscount ? TextDecoration.lineThrough : null,
          ),
        )
      ],
    );
  }
}
