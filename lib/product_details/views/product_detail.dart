import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:innwa_mobile_dev/_application/bloc/app_service_bloc.dart';
import 'package:innwa_mobile_dev/_application/constant/api_key.dart';
import 'package:innwa_mobile_dev/_application/extension/sb_extension.dart';
import 'package:innwa_mobile_dev/_application/service/localization/loclaization_view.dart';
import 'package:innwa_mobile_dev/product_details/bloc/product_details_bloc.dart';
import 'package:innwa_mobile_dev/product_details/widgets/buy_now_btn.dart';
import 'package:innwa_mobile_dev/product_details/widgets/product_image_slider.dart';
import 'package:innwa_mobile_dev/product_details/widgets/product_price_section.dart';
import 'package:innwa_mobile_dev/product_details/widgets/review.dart';
import 'package:innwa_mobile_dev/product_details/widgets/review_lists.dart';
import 'package:innwa_mobile_dev/product_details/widgets/specification.dart';
import 'package:innwa_mobile_dev/shared/add_to_cart/add_to_cart.dart';
import 'package:innwa_mobile_dev/shared/drawer/drawer.dart';
import 'package:innwa_mobile_dev/shared/related_products/related_products.dart';
import 'package:innwa_mobile_dev/shared/texts/roboto_text/roboto_text.dart';
import 'package:innwa_mobile_dev/shared/top_bar/topbar.dart';
import 'package:innwa_mobile_dev/user/bloc/user_bloc.dart';
import 'package:innwa_mobile_dev/util/constants.dart';
import 'package:innwa_mobile_dev/util/ui/error_retry.dart';
import 'package:innwa_mobile_dev/util/ui/search_product_bar/view/product_search_app_bar.dart';

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
            return BlocBuilder<UserBloc, UserState>(
              builder: (context, userState) {
                return Container(
                  color: backgroundColorLight,
                  child: LocalizationWidget(
                      en: "Product Details",
                      mm: "ကုန်ပစ္စည်း အချက်အလက်များ",
                      child: (details) {
                        return SafeArea(
                          child: Scaffold(
                            appBar: TopBar(
                              needBackButton: false,
                              needMenu: true,
                            ),
                            drawer: CustomDrawerWidget(
                              onDrawerTap: () {},
                            ),
                            body: Scaffold(
                                appBar: TopBar(
                                  needBackButton: true,
                                  needMenu: false,
                                  title: details,
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
                                              const CustomScrollView(
                                                shrinkWrap: true,
                                                slivers: [
                                                  ProductSearchAppbar(),
                                                ],
                                              ),
                                              Expanded(
                                                child: ListView(
                                                  shrinkWrap: true,
                                                  children: [
                                                    Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceEvenly,
                                                      children: [
                                                        const ProductImageSlider(),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .only(
                                                                  left: 8.0,
                                                                  right: 8.0),
                                                          child: Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            children: [
                                                              Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .spaceBetween,
                                                                children: [
                                                                  Flexible(
                                                                    child: LocalizationWidget(
                                                                        en: state.productDetails!.enName,
                                                                        mm: state.productDetails!.mmName,
                                                                        child: (productTitle) {
                                                                          return RobotoText(
                                                                            fontSize:
                                                                                18.0,
                                                                            fontWeight:
                                                                                FontWeight.w600,
                                                                            fontColor:
                                                                                Colors.black87,
                                                                            maxLine:
                                                                                4,
                                                                            text:
                                                                                productTitle,
                                                                          );
                                                                        }),
                                                                  ),
                                                                  BlocBuilder<
                                                                      UserBloc,
                                                                      UserState>(
                                                                    builder:
                                                                        (context,
                                                                            userState) {
                                                                      final bool
                                                                          isContain =
                                                                          userState
                                                                              .wishlistProductId
                                                                              .contains(state.productDetails!.id);
                                                                      return CircleAvatar(
                                                                        radius:
                                                                            20,
                                                                        backgroundColor:
                                                                            Colors.white,
                                                                        child:
                                                                            IconButton(
                                                                          color:
                                                                              Colors.white,
                                                                          onPressed: state.wishlistApiStatus == ApiStatus.processing
                                                                              ? null
                                                                              : () {
                                                                                  productDetailsBloc.add(ClickWishlistBtnEvent(context: context));
                                                                                },
                                                                          icon:
                                                                              Icon(
                                                                            CupertinoIcons.heart_fill,
                                                                            color: isContain
                                                                                ? Colors.red
                                                                                : Colors.black,
                                                                          ),
                                                                        ),
                                                                      );
                                                                    },
                                                                  ),
                                                                ],
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                        const ProductPriceSection(),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .symmetric(
                                                                  horizontal:
                                                                      10),
                                                          child:
                                                              LocalizationWidget(
                                                            en: state
                                                                .productDetails!
                                                                .enDesc,
                                                            mm: state
                                                                .productDetails!
                                                                .mmDesc,
                                                            child: (desc) {
                                                              return HtmlWidget(
                                                                desc,
                                                              );
                                                            },
                                                          ),
                                                        ),
                                                        10.vertical,
                                                        Builder(
                                                            builder: (context) {
                                                          return Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .only(
                                                                    left: 8.0,
                                                                    right: 8.0),
                                                            child:
                                                                ElevatedButton(
                                                              style: ElevatedButton.styleFrom(
                                                                  elevation: 0,
                                                                  foregroundColor:
                                                                      Colors
                                                                          .white,
                                                                  backgroundColor:
                                                                      Colors
                                                                          .white,
                                                                  disabledForegroundColor:
                                                                      Colors
                                                                          .white),
                                                              onPressed: () {
                                                                showBottomSheet(
                                                                  context:
                                                                      context,
                                                                  builder:
                                                                      (context) {
                                                                    return BlocProvider
                                                                        .value(
                                                                      value:
                                                                          productDetailsBloc,
                                                                      child:
                                                                          const Specification(),
                                                                    );
                                                                  },
                                                                );
                                                              },
                                                              child: Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .spaceBetween,
                                                                children: [
                                                                  RobotoText(
                                                                      fontSize:
                                                                          16.0,
                                                                      fontColor:
                                                                          Colors
                                                                              .black,
                                                                      text:
                                                                          "Specifications"),
                                                                  const SizedBox(
                                                                    width: 5,
                                                                  ),
                                                                  const Icon(
                                                                    // <-- Icon
                                                                    Icons
                                                                        .keyboard_arrow_down_rounded,
                                                                    color: Colors
                                                                        .black87,
                                                                    size: 24.0,
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                          );
                                                        }),
                                                        const Padding(
                                                          padding:
                                                              EdgeInsets.only(
                                                                  top: 5.0),
                                                          child: Divider(
                                                            color: dividerColor,
                                                            height: 2,
                                                          ),
                                                        ),
                                                        if ((state.canReview ??
                                                                true) &&
                                                            userState.user !=
                                                                null)
                                                          10.vertical,
                                                        if ((state.canReview ??
                                                                true) &&
                                                            userState.user !=
                                                                null)
                                                          const Review(),
                                                        LocalizationWidget(
                                                            en: "Reviews",
                                                            mm: "သုံးသပ်ချက်များ",
                                                            child: (review) {
                                                              return Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                        .only(
                                                                  top: 10.0,
                                                                  left: 12,
                                                                ),
                                                                child:
                                                                    RobotoText(
                                                                  fontSize:
                                                                      18.0,
                                                                  fontColor:
                                                                      Colors
                                                                          .black,
                                                                  text: review,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                ),
                                                              );
                                                            }),
                                                        10.vertical,
                                                        const ReviewList(),
                                                        Row(
                                                          children: [
                                                            LocalizationWidget(
                                                                en:
                                                                    "Related Products",
                                                                mm:
                                                                    "ဆက်စပ်ထုတ်ကုန်များ",
                                                                child:
                                                                    (related) {
                                                                  return Padding(
                                                                    padding: const EdgeInsets
                                                                        .only(
                                                                        left:
                                                                            8.0,
                                                                        bottom:
                                                                            10.0,
                                                                        top:
                                                                            10.0),
                                                                    child:
                                                                        RobotoText(
                                                                      fontSize:
                                                                          18.0,
                                                                      fontColor:
                                                                          Colors
                                                                              .black,
                                                                      text:
                                                                          related,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w600,
                                                                    ),
                                                                  );
                                                                }),
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
                                                    AddToCart(
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
                                            child: ErrorRetry(
                                              retryFun: () {
                                                productDetailsBloc.add(
                                                    GetProductDetailsEvent(
                                                        context: context,
                                                        slug: slug));
                                              },
                                            ),
                                          )),
                          ),
                        );
                      }),
                );
              },
            );
          },
        );
      }),
    );
  }
}
