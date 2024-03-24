import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:innwa_mobile_dev/_application/bloc/app_service_bloc.dart';
import 'package:innwa_mobile_dev/_application/constant/api_key.dart';
import 'package:innwa_mobile_dev/_application/extension/sb_extension.dart';
import 'package:innwa_mobile_dev/product_details/bloc/product_details_bloc.dart';
import 'package:innwa_mobile_dev/product_details/widgets/buy_now_btn.dart';
import 'package:innwa_mobile_dev/product_details/widgets/product_brand_and_price_section.dart';
import 'package:innwa_mobile_dev/product_details/widgets/product_image_slider.dart';
import 'package:innwa_mobile_dev/product_details/widgets/review.dart';
import 'package:innwa_mobile_dev/product_details/widgets/review_lists.dart';
import 'package:innwa_mobile_dev/shared/add_to_card/add_to_card.dart';
import 'package:innwa_mobile_dev/shared/related_products/related_products.dart';
import 'package:innwa_mobile_dev/shared/texts/roboto_text/roboto_text.dart';
import 'package:innwa_mobile_dev/shared/top_bar/topbar.dart';
import 'package:innwa_mobile_dev/util/constants.dart';
import 'package:innwa_mobile_dev/util/ui/innwa_error.dart';

class ProductDetail extends StatelessWidget {
  const ProductDetail({required this.slug, super.key});
  final String slug;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProductDetailsBloc(
        BlocProvider.of<AppServiceBloc>(context).api,
      ),
      child: Builder(builder: (context) {
        final ProductDetailsBloc productDetailsBloc =
            BlocProvider.of<ProductDetailsBloc>(context);
        productDetailsBloc
            .add(GetProductDetailsEvent(context: context, slug: slug));
        return BlocBuilder<ProductDetailsBloc, ProductDetailsState>(
          builder: (context, state) {
            return Container(
              color: backgroundColorLight,
              child: SafeArea(
                child: Scaffold(
                    appBar: TopBar(
                      needBackButton: true,
                      needMenu: false,
                      title: "Product Detail",
                      showAction: false,
                    ),
                    resizeToAvoidBottomInset: true,
                    body: state.apiStatus == ApiStatus.processing
                        ? const Center(
                            child: CircularProgressIndicator(),
                          )
                        : state.apiStatus == ApiStatus.completed
                            ? Column(
                                children: [
                                  Expanded(
                                    child: ListView(
                                      shrinkWrap: true,
                                      children: [
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            const ProductImageSlider(),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 8.0, right: 8.0),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  RobotoText(
                                                    fontSize: 16.0,
                                                    fontWeight:
                                                        FontWeight.normal,
                                                    fontColor: Colors.black87,
                                                    text: state
                                                        .productDetails!.enName,
                                                  ),
                                                  // Row(
                                                  //   mainAxisAlignment:
                                                  //       MainAxisAlignment
                                                  //           .spaceBetween,
                                                  //   children: [
                                                  //     Padding(
                                                  //       padding:
                                                  //           const EdgeInsets
                                                  //               .only(top: 8.0),
                                                  //       child: RobotoText(
                                                  //         fontSize: 15.0,
                                                  //         fontWeight:
                                                  //             FontWeight.w700,
                                                  //         fontColor:
                                                  //             Colors.black87,
                                                  //         text: "104,111 MMK",
                                                  //       ),
                                                  //     ),
                                                  //     const Padding(
                                                  //       padding:
                                                  //           EdgeInsets.only(
                                                  //               top: 8.0,
                                                  //               right: 10.0),
                                                  //       child: Icon(Icons
                                                  //           .favorite_outline),
                                                  //     )
                                                  //   ],
                                                  // )
                                                ],
                                              ),
                                            ),
                                            // const SizedBox(
                                            //   height: 15,
                                            // ),
                                            // const ProductPromotion(),
                                            Html(
                                              data: state
                                                      .productDetails!.mmDesc ??
                                                  state.productDetails!.enDesc,
                                            ),
                                            10.vertical,
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 10),
                                              child: RobotoText(
                                                fontSize: 16.0,
                                                fontColor: Colors.black,
                                                text: "Select Specifications",
                                              ),
                                            ),
                                            10.vertical,
                                            const ProductSpecAndPriceSelectSection(),
                                            10.vertical,
                                            // Builder(builder: (context) {
                                            //   return Padding(
                                            //     padding: const EdgeInsets.only(
                                            //         left: 8.0, right: 8.0),
                                            //     child: ElevatedButton(
                                            //       style: ElevatedButton.styleFrom(
                                            //           elevation: 0,
                                            //           foregroundColor:
                                            //               Colors.white,
                                            //           backgroundColor:
                                            //               Colors.white,
                                            //           disabledForegroundColor:
                                            //               Colors.white),
                                            //       onPressed: () {
                                            //         showBottomSheet(
                                            //           context: context,
                                            //           builder: (context) {
                                            //             return const Specification();
                                            //           },
                                            //         );
                                            //       },
                                            //       child: Row(
                                            //         mainAxisAlignment:
                                            //             MainAxisAlignment
                                            //                 .spaceBetween,
                                            //         children: [
                                            //           RobotoText(
                                            //               fontSize: 16.0,
                                            //               fontColor:
                                            //                   Colors.black,
                                            //               text:
                                            //                   "Specifications"),
                                            //           const SizedBox(
                                            //             width: 5,
                                            //           ),
                                            //           const Icon(
                                            //             // <-- Icon
                                            //             Icons
                                            //                 .keyboard_arrow_down_rounded,
                                            //             color: Colors.black87,
                                            //             size: 24.0,
                                            //           ),
                                            //         ],
                                            //       ),
                                            //     ),
                                            //   );
                                            // }),

                                            // const Divider(
                                            //   color: dividerColor,
                                            //   height: 5,
                                            // ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 30.0,
                                                  right: 30.0,
                                                  bottom: 10.0,
                                                  top: 13.0),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
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
                                                          fontColor:
                                                              Colors.black,
                                                          text:
                                                              "3 days Delivery"),
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
                                            const Padding(
                                              padding:
                                                  EdgeInsets.only(top: 5.0),
                                              child: Divider(
                                                color: dividerColor,
                                                height: 2,
                                              ),
                                            ),
                                            const Review(),
                                            const ReviewList(),
                                            Row(
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 8.0,
                                                          bottom: 10.0,
                                                          top: 10.0),
                                                  child: RobotoText(
                                                    fontSize: 18.0,
                                                    fontColor: Colors.black,
                                                    text: "Related Products",
                                                    fontWeight: FontWeight.w400,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            const RelatedProducts()
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 10.0, bottom: 10.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        AddToCard(
                                          width: 150,
                                          height: 50,
                                        ),
                                        const BuyNow()
                                      ],
                                    ),
                                  )
                                ],
                              )
                            : Center(
                                child: InnwaError(
                                  onClick: () {
                                    productDetailsBloc.add(
                                        GetProductDetailsEvent(
                                            context: context, slug: slug));
                                  },
                                ),
                              )),
              ),
            );
          },
        );
      }),
    );
  }
}
