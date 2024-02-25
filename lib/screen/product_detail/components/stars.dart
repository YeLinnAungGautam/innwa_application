import 'package:flutter/material.dart';

class Stars extends StatelessWidget {
  final int count;
  const Stars({super.key, required this.count});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 100,
      height: 20,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,        
        itemCount: count,
        itemBuilder: (BuildContext context, index){
          return Icon(Icons.star,size: 15,color: Colors.amber,);
        }
        ),
    );
  }
}