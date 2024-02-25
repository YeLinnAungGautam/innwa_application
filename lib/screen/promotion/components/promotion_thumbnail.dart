import 'package:flutter/material.dart';

class PromotionThumbnail extends StatelessWidget {
  const PromotionThumbnail({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 200,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: NetworkImage(
            'https://innwa.com.mm/public//images/slide/slide4.webp',
            
          ),
          fit: BoxFit.cover
        )
      ),
    );
  }
}