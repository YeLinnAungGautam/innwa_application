import 'package:flutter/material.dart';

class Avatar extends StatelessWidget {
  String image;
  double width;
  double height;
  Avatar({super.key,required this.image,required this.width, required this.height});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(40),
        image: DecorationImage(
          image: NetworkImage(
            image
          ),fit: BoxFit.fitHeight
        )
      ),
    );
  }
}