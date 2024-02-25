import 'package:flutter/material.dart';

class ImageBanner extends StatelessWidget {
  String url;
  ImageBanner({super.key,required this.url});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 5.0),
      width: MediaQuery.of(context).size.width,
      height: 150.0,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: NetworkImage(
            "https://mir-s3-cdn-cf.behance.net/project_modules/1400/385ff4114159083.606bf1d855df5.png",
          
          ),
          fit: BoxFit.cover
        
        )
      ),
    );
  }

  
}