import 'package:flutter/material.dart';

class RelatedProducts extends StatelessWidget {
  const RelatedProducts({super.key});

  @override
  Widget build(BuildContext context) {
    Map<dynamic, dynamic> products = {
      "product_one": {
        "image":
            "https://innwa.com.mm/images/products/apple/ipad/637c8d362a249/637c8d362a249ipad_pro_12_9_wif.jpg",
        "name": "SAMSUNG GALAXY A4",
        "price": "123,000"
      },
      "product_two": {
        "image":
            "https://innwa.com.mm/images/products/smartphone/nokia/63414a52348fc/63414a52348fcnokia105.jpg",
        "name": "Redmi Note 11 E Pro",
        "price": "123,000"
      },
      "product_three": {
        "image":
            "https://innwa.com.mm/images/products/smartphone/oppo/65446b8c6cb18/65446b8c6cb18Oppo-Find-N3-flip.webp",
        "name": "RealMe CC3",
        "price": "123,000"
      },
      "product_4": {
        "image":
            "https://innwa.com.mm/images/products/smartphone/huawei/646b285f9fa4a/646b285f9fa4ahuawei-mateX3.png",
        "name": "Xiaomi 13 Lite",
        "price": "123,000"
      },
    };
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: 290,
      child: ListView.builder(
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          itemCount: products.length,
          itemBuilder: (BuildContext context, int index) {
            return const Text("Related Product");
            // return Padding(
            //   padding: const EdgeInsets.only(left : 10.0),
            //   child: ProductCard(url: "https://innwa.com.mm/images/products/smartphone/huawei/646b285f9fa4a/646b285f9fa4ahuawei-mateX3.png",price: "Xiaomi",text: "Xiaomi 13 Lite",),
            // );
          }),
    );
  }
}
