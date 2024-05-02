import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:innwa_mobile_dev/_application/extension/sb_extension.dart';
import 'package:innwa_mobile_dev/shared/texts/roboto_text/roboto_text.dart';

class BranchCard extends StatelessWidget {
  const BranchCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 20),
      child: Card(
        surfaceTintColor: Colors.white,
        child: Column(
          children: [
            CachedNetworkImage(
              imageUrl:
                  "https://shop.innwa.com.mm/storage/branch/202304260941innwa_merchant_shop.webp",
              height: MediaQuery.of(context).size.height * 0.15,
              width: MediaQuery.of(context).size.width * 0.7,
              fit: BoxFit.cover,
            ),
            Container(
              width: MediaQuery.of(context).size.width * 0.7,
              constraints: BoxConstraints(
                  minHeight: MediaQuery.of(context).size.height * 0.16),
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RobotoText(
                    fontSize: 17,
                    fontColor: null,
                    text: "Innwa Merchat Road",
                    fontWeight: FontWeight.bold,
                  ),
                  10.vertical,
                  Row(
                    children: [
                      const Icon(Icons.location_pin),
                      8.horizontal,
                      Flexible(
                        child: RobotoText(
                          fontSize: 14,
                          fontColor: null,
                          fontWeight: FontWeight.w600,
                          maxLine: 10,
                          text:
                              "Lorem Ipsum took a galley of type and scrambled it to make a type specimen book.",
                        ),
                      )
                    ],
                  ),
                  12.vertical,
                  Row(
                    children: [
                      const Icon(Icons.phone),
                      8.horizontal,
                      Flexible(
                        child: RobotoText(
                          fontSize: 14,
                          fontColor: null,
                          fontWeight: FontWeight.w600,
                          maxLine: 10,
                          text: "09 780 136579",
                        ),
                      )
                    ],
                  ),
                  12.vertical,
                  Row(
                    children: [
                      const Icon(Icons.headset_mic),
                      8.horizontal,
                      Flexible(
                        child: RobotoText(
                          fontSize: 14,
                          fontColor: null,
                          fontWeight: FontWeight.w600,
                          maxLine: 10,
                          text: "09 780 136579 , 09 780 136579",
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
