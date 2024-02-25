import 'package:flutter/material.dart';
import 'package:innwa_mobile_dev/screen/product_detail/product_detail.dart';
import 'package:innwa_mobile_dev/shared/add_to_card/add_to_card.dart';
import 'package:innwa_mobile_dev/shared/discount_banner/discount_banner.dart';
import 'package:innwa_mobile_dev/shared/price_tag/price_tag.dart';
import 'package:innwa_mobile_dev/shared/texts/product_title.dart';

class ProductCard extends StatelessWidget {
  String url;
  String text;
  String price;
  ProductCard(
      {super.key, required this.url, required this.text, required this.price});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 180,
      height: 200,
      margin: const EdgeInsets.symmetric(vertical: 2, horizontal: 10),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(10)),
      child: Column(
        children: [
          Column(
            children: [
              InkWell(
                onTap: () {
                  FocusScopeNode currentFocus = FocusScope.of(context);
                  if (!currentFocus.hasPrimaryFocus) {
                    currentFocus.unfocus();
                  }
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const ProductDetail()));
                },
                child: Stack(
                  alignment: Alignment.topRight,
                  children: [
                    Container(
                      child: Image(
                        image: NetworkImage(url),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                          color: Color(0xFF4C53A5),
                          boxShadow: [
                            BoxShadow(
                              offset: Offset(6, 3),
                              spreadRadius: -4,
                              blurRadius: 10,
                              color: Color.fromRGBO(229, 229, 229, 1),
                            ),
                          ],
                          borderRadius: BorderRadius.circular(5)),
                      child: DiscountBanner(text: "Discount - 10,000 MMK"),
                    ),
                  ],
                ),
              ),
              Column(
                children: [
                  Container(
                    height: 46,
                    padding: EdgeInsets.only(bottom: 4, left: 8.0, top: 8.0),
                    alignment: Alignment.centerLeft,
                    child: ProductTitle(text: text ),
                  ),
                  Container(
                      padding: EdgeInsets.only(left: 8.0,bottom: 5.0),
                      alignment: Alignment.centerLeft,
                      child: PriceTag(text: "Price : 100000 MMK")),
                ],
              ),
              AddToCard(
                width: 180,
                height: 30,
              )
            ],
          )
        ],
      ),
    );
  }
}
