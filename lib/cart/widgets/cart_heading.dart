import 'package:flutter/material.dart';
import 'package:innwa_mobile_dev/shared/texts/roboto_text/roboto_text.dart';


class CartHeading extends StatelessWidget {
  const CartHeading({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Icon(Icons.arrow_back_rounded),
          RobotoText(fontSize: 20.0, fontColor: Colors.indigo, text: "My Cart", fontWeight: FontWeight.w800,),
          const Icon(Icons.refresh_rounded)
        ],
      ),
    );
  }
}