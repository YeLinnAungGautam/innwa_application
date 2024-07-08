import 'package:flutter/material.dart';

class DiscountBanner extends StatelessWidget {
  String text;
  DiscountBanner({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(
          fontFamily: "SanFrancisco", color: Colors.white, fontSize: 10.0),
      textAlign: TextAlign.center,
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
    );
  }
}
