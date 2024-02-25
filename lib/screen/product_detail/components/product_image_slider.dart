import 'package:flutter/material.dart';

class ProductImageSlider extends StatelessWidget {
  const ProductImageSlider({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
            width: MediaQuery.of(context).size.width,
            height: 250,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount:2,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    width: 250,
                    height: 150,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(width: 0.5,color: Colors.black26),
                        image: const DecorationImage(
                            image: NetworkImage(
                                "https://innwa.com.mm/images/products/smartphone/vivo/651940b6d341c/651940b6d341cvivo-v29.webp"),
                            fit: BoxFit.cover)),
                  ),
                );
              },
            ),
          );
  }
}