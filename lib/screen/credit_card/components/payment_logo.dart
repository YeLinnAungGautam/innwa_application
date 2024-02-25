import 'package:flutter/material.dart';

class PaymentLogo extends StatelessWidget {
  final String imagePath;
  const PaymentLogo({super.key,required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 40,
      height: 25,
      decoration: BoxDecoration(
        color: Colors.white,
        image: DecorationImage(
          image: AssetImage(imagePath),
          fit: BoxFit.cover
        )
      ),
    );
  }
}