import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:innwa_mobile_dev/screen/product_detail/components/buy_now_btn.dart';
import 'package:innwa_mobile_dev/screen/product_detail/components/discount.dart';
import 'package:innwa_mobile_dev/screen/product_detail/components/product_image_slider.dart';
import 'package:innwa_mobile_dev/screen/product_detail/components/promotion.dart';
import 'package:innwa_mobile_dev/screen/product_detail/components/review.dart';
import 'package:innwa_mobile_dev/screen/product_detail/components/review_lists.dart';
import 'package:innwa_mobile_dev/screen/product_detail/components/specification.dart';
import 'package:innwa_mobile_dev/screen/promotion/promotion.dart';
import 'package:innwa_mobile_dev/shared/add_to_card/add_to_card.dart';

import 'package:innwa_mobile_dev/shared/drawer/drawer.dart';
import 'package:innwa_mobile_dev/shared/related_products/related_products.dart';
import 'package:innwa_mobile_dev/shared/search_bar/search_bar.dart';
import 'package:innwa_mobile_dev/shared/texts/roboto_text/roboto_text.dart';
import 'package:innwa_mobile_dev/shared/top_bar/topbar.dart';
import 'package:innwa_mobile_dev/util/constants.dart';

class ProductDetail extends StatefulWidget {
  const ProductDetail({super.key});

  @override
  State<ProductDetail> createState() => _ProductDetailState();
}

class _ProductDetailState extends State<ProductDetail>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: backgroundColorLight,
      child: SafeArea(
        child: Scaffold(
            appBar: TopBar(
              needBackButton: true,
              needMenu: false,
              title: "Product Detail",
            ),
            resizeToAvoidBottomInset: true,
            drawer: CustomDrawerWidget(onDrawerTap: () {
              FocusScopeNode currentFocus = FocusScope.of(context);

              if (!currentFocus.hasPrimaryFocus && currentFocus.hasFocus) {
                currentFocus.unfocus();
              }
            }),
            body: Column(
              children: [
                CustomSearchBar(),
                Expanded(
                  
                  child: ListView(
                    shrinkWrap: true,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ProductImageSlider(),
                          Padding(
                            padding:
                                const EdgeInsets.only(left: 8.0, right: 8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                RobotoText(
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.normal,
                                    fontColor: Colors.black87,
                                    text: "Thinkpad E14(Ryzen 15)"),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(top: 8.0),
                                      child: RobotoText(
                                          fontSize: 15.0,
                                          fontWeight: FontWeight.w700,
                                          fontColor: Colors.black87,
                                          text: "104,111 MMK"),
                                    ),
                                    const Padding(
                                      padding: EdgeInsets.only(
                                          top: 8.0, right: 10.0),
                                      child: Icon(Icons.favorite_outline),
                                    )
                                  ],
                                )
                              ],
                            ),
                          ),

                          const SizedBox(height: 15,),
                          
                          ProductPromotion(),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industrys standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.',
                              softWrap: true,
                              textAlign: TextAlign.justify,
                              style: GoogleFonts.roboto(fontSize: 15.0),
                            ),
                          ),
                          Builder(builder: (context) {
                            return Padding(
                              padding:
                                  const EdgeInsets.only(left: 8.0, right: 8.0),
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    elevation: 0,
                                    foregroundColor: Colors.white,
                                    backgroundColor: Colors.white,
                                    disabledForegroundColor: Colors.white),
                                onPressed: () {
                                  showBottomSheet(
                                    context: context,
                                    builder: (context) {
                                      return const Specification();
                                    },
                                  );
                                },
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    RobotoText(
                                        fontSize: 16.0,
                                        fontColor: Colors.black,
                                        text: "Specifications"),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Icon(
                                      // <-- Icon
                                      Icons.keyboard_arrow_down_rounded,
                                      color: Colors.black87,
                                      size: 24.0,
                                    ),
                                  ],
                                ),
                              ),
                            );
                          }),
                          Divider(
                            color: dividerColor,
                            height: 5,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 30.0,
                                right: 30.0,
                                bottom: 10.0,
                                top: 13.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                RobotoText(
                                    fontSize: 16.0,
                                    fontColor: Colors.black,
                                    text: "Delivery"),
                                const SizedBox(
                                  width: 5,
                                ),
                                Row(
                                  children: [
                                    RobotoText(
                                        fontSize: 13.0,
                                        fontColor: Colors.black,
                                        text: "3 days Delivery"),
                                    const Icon(
                                      // <-- Icon
                                      Icons.delivery_dining,
                                      color: Colors.black87,
                                      size: 24.0,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 5.0),
                            child: Divider(
                              color: dividerColor,
                              height: 2,
                            ),
                          ),
                          Review(),
                          ReviewList(),
                          Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 8.0, bottom: 10.0, top: 10.0),
                                child: RobotoText(
                                  fontSize: 18.0,
                                  fontColor: Colors.black,
                                  text: "Related Products",
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          ),
                          RelatedProducts()
                        ],
                      )
                    ],
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      AddToCard(
                        width: 150,
                        height: 50,
                      ),
                      BuyNow()
                    ],
                  ),
                )
              ],
            )),
      ),
    );
  }
}
