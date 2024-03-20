import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher_string.dart';

class ImageBanner extends StatelessWidget {
  String url;
  final String? link;
  ImageBanner({super.key, required this.url, this.link});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        if (link != null) {
          try {
            await launchUrlString(link!);
          } catch (e) {
            debugPrint("Can't Launch");
          }
        }
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 5.0),
        width: MediaQuery.of(context).size.width,
        height: 150.0,
        decoration: const BoxDecoration(),
        child: CachedNetworkImage(
          imageUrl: url,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
