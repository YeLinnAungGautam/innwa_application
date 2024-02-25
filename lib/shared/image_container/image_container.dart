import 'package:flutter/material.dart';

class ImageContainer extends StatelessWidget {

  double? width;
  double? height;
  String? url;
  bool? isUrl;
  ImageContainer({super.key,required this.width, required this.height, required this.url, this.isUrl});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width!,
      height: height!,
      decoration: BoxDecoration(
          image: DecorationImage(
               image: isUrl!? NetworkImage(url!) : AssetImage(url!) as ImageProvider,
              fit: BoxFit.cover)),
    );
  }
}
