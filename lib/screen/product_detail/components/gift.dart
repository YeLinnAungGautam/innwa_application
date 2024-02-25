import 'package:flutter/material.dart';


class Gifts extends StatelessWidget {
  const Gifts({super.key});

  @override
  Widget build(BuildContext context) {
    List<String> gifts = ["Powerbank","Earbuds"];
    return Container(
            width: 250,
            height: 50,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount:gifts.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(7),
                      border: Border.all(width: 2, color: Colors.black54)
                    ),
                    width: 100,
                    height: 50,
                    child: Text(gifts[index]),
                  ),
                );
              },
            ),
          );
  }
}