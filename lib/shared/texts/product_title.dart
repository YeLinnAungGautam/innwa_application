import 'package:flutter/material.dart';
import 'package:innwa_mobile_dev/util/constants.dart';

class ProductTitle extends StatelessWidget {

  String text;
  ProductTitle({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Text(text,style: const TextStyle(fontFamily: "SanFrancisco", fontSize: 13.0,fontWeight: FontWeight.bold,color: kZambeziColor),maxLines: 2,overflow: TextOverflow.ellipsis,);
  }
}