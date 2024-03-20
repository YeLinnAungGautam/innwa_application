import 'package:flutter/material.dart';
import 'package:innwa_mobile_dev/shared/drawer/drawer.dart';
import 'package:innwa_mobile_dev/shared/top_bar/topbar.dart';
import 'package:innwa_mobile_dev/util/constants.dart';

class WishList extends StatelessWidget {
  WishList({super.key});

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

  @override
  Widget build(BuildContext context) {
    return Container(
      color: backgroundColorLight,
      child: SafeArea(
        child: Scaffold(
          appBar: TopBar(
            needBackButton: true,
            needMenu: false,
            title: "Whishlists",
          ),
          drawer: CustomDrawerWidget(onDrawerTap: () {
            FocusScopeNode currentFocus = FocusScope.of(context);

            if (!currentFocus.hasPrimaryFocus && currentFocus.hasFocus) {
              currentFocus.unfocus();
            }
          }),
          body: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  padding: EdgeInsets.zero,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 10.0),
                        child: GridView.count(
                          physics: const NeverScrollableScrollPhysics(),
                          childAspectRatio:
                              MediaQuery.of(context).size.width <= 600
                                  ? 0.6
                                  : 0.65,
                          shrinkWrap: true,
                          crossAxisCount:
                              MediaQuery.of(context).size.width <= 600 ? 2 : 3,
                          semanticChildCount: 4,
                          // children: products.entries
                          //     .map((e) => ProductCard(
                          //         url: e.value["image"],
                          //         text: e.value["name"],
                          //         price: ""))
                          //     .toList(),
                          children: const [Text("Implement Product")],
                        ),
                      ),
                      GridView.count(
                        physics: const NeverScrollableScrollPhysics(),
                        childAspectRatio:
                            MediaQuery.of(context).size.width <= 600
                                ? 0.6
                                : 0.65,
                        shrinkWrap: true,
                        crossAxisCount:
                            MediaQuery.of(context).size.width <= 600 ? 2 : 3,
                        semanticChildCount: 4,
                        children: const [Text("Implement Product")],
                      ),
                      // children: products.entries
                      //     .map((e) => ProductCard(
                      //         url: e.value["image"],
                      //         text: e.value["name"],
                      //         price: ""))
                      //     .toList()),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
