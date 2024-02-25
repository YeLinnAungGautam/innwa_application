import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';


class InnwaSlider extends StatelessWidget {
  InnwaSlider({super.key});

    List<String> videos = [
    'https://www.w3schools.com/html/mov_bbb.mp4',
    'https://www.w3schools.com/html/mov_bbb.mp4',
  ];

  List<String> images = [
    'https://innwa.com.mm/public//images/slide/slide5.webp',
    'https://innwa.com.mm/public//images/slide/slide4.webp',
    'https://innwa.com.mm/public//images/slide/slide1.webp',
  ];

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
  items: [
    // ...videos.map((videoUrl) => VideoApp(url: videoUrl)),
    ...images.map((imageUrl) => Image.network(imageUrl)),
  ],
  options: CarouselOptions(
    aspectRatio: 20/9,
    autoPlay: true,
    enlargeCenterPage: true,
    viewportFraction: 1,
  ),
);
  }
}