import 'package:flutter/material.dart';
import 'package:innwa_mobile_dev/shared/banner/image_banner.dart';
import 'package:innwa_mobile_dev/shared/product_card/product_card.dart';
import 'package:innwa_mobile_dev/shared/search_bar/search_bar.dart';
import 'package:innwa_mobile_dev/shared/slider/innwa_slider.dart';
import 'package:innwa_mobile_dev/shared/texts/heading.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    Map<dynamic, dynamic> products = {
      "product_one" : {
        "image" : "https://innwa.com.mm/images/products/apple/ipad/637c8d362a249/637c8d362a249ipad_pro_12_9_wif.jpg",
        "name" : "SAMSUNG GALAXY A4",
        "price" : "123,000"
      },     
     
     
       "product_two" : {
        "image" : "https://innwa.com.mm/images/products/smartphone/nokia/63414a52348fc/63414a52348fcnokia105.jpg",
        "name" : "Redmi Note 11 E Pro",
        "price" : "123,000"
      },      
     
     
      "product_three" : {
        "image" : "https://innwa.com.mm/images/products/smartphone/oppo/65446b8c6cb18/65446b8c6cb18Oppo-Find-N3-flip.webp",
        "name" : "RealMe CC3",
        "price" : "123,000"
      },     
     
     
       "product_4" : {
        "image" : "https://innwa.com.mm/images/products/smartphone/huawei/646b285f9fa4a/646b285f9fa4ahuawei-mateX3.png",
        "name" : "Xiaomi 13 Lite",
        "price" : "123,000"
      },    
    };

    return SizedBox(
        height: MediaQuery.of(context).size.height / 1.32,
        child: SingleChildScrollView(
          padding: EdgeInsets.zero,
          child: Column(
            children: [
              InnwaSlider(),
              Row(
                children: [
                  Heading(text: "Latest Products"),
                ],
              ),
              GridView.count(
                  physics: const NeverScrollableScrollPhysics(),
                  childAspectRatio:
                      MediaQuery.of(context).size.width <= 600 ? 0.6 : 0.65,
                  shrinkWrap: true,
                  crossAxisCount:
                      MediaQuery.of(context).size.width <= 600 ? 2 : 3,
                  semanticChildCount: 4,
                  children: products.entries
                      .map((e) => ProductCard(
                          url: e.value["image"],
                          text: e.value["name"],
                          price: ""))
                      .toList()),
              ImageBanner(url: "url"),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: Heading(text: "Latest Laptops"),
                  ),
                ],
              ),
              GridView.count(
                  physics: const NeverScrollableScrollPhysics(),
                  childAspectRatio:
                      MediaQuery.of(context).size.width <= 600 ? 0.6 : 0.65,
                  shrinkWrap: true,
                  crossAxisCount:
                      MediaQuery.of(context).size.width <= 600 ? 2 : 3,
                  semanticChildCount: 4,
                  children: products.entries
                      .map((e) => ProductCard(
                          url: e.value["image"],
                          text: e.value["name"],
                          price: ""))
                      .toList()),
              ImageBanner(url: "url"),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top:15.0),
                    child: Heading(text: "Latest Mobile Products"),
                  ),
                ],
              ),
              GridView.count(
                  physics: const NeverScrollableScrollPhysics(),
                  childAspectRatio:
                      MediaQuery.of(context).size.width <= 600 ? 0.6 : 0.65,
                  shrinkWrap: true,
                  crossAxisCount:
                      MediaQuery.of(context).size.width <= 600 ? 2 : 3,
                  semanticChildCount: 4,
                  children: products.entries
                      .map((e) => ProductCard(
                          url: e.value["image"],
                          text: e.value["name"],
                          price: ""))
                      .toList()),
              ImageBanner(url: "url"),
              Row(
                children: [
                  Heading(text: "Latest Computer Products"),
                ],
              ),
              GridView.count(
                  physics: const NeverScrollableScrollPhysics(),
                  childAspectRatio:
                      MediaQuery.of(context).size.width <= 600 ? 0.6 : 0.65,
                  shrinkWrap: true,
                  crossAxisCount:
                      MediaQuery.of(context).size.width <= 600 ? 2 : 3,
                  semanticChildCount: 4,
                  children: products.entries
                      .map((e) => ProductCard(
                          url: e.value["image"],
                          text: e.value["name"],
                          price: ""))
                      .toList()),
            ],
          ),
        ));
  }
}
