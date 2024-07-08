import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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

import '../../wishlist/bloc/wishlist_bloc.dart';

class ProductDetail extends StatelessWidget {
  const ProductDetail({required this.slug, super.key});

  final String slug;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProductDetailsBloc(
        BlocProvider.of<AppServiceBloc>(context).api,
        WishlistBloc(BlocProvider.of<AppServiceBloc>(context).api)
          ..add(GetWishlistEvent(context: context)),
      ),
      child: Builder(
        builder: (context) {
          final ProductDetailsBloc productDetailsBloc =
              BlocProvider.of<ProductDetailsBloc>(context);
          final WishlistBloc wishListBloc =
              BlocProvider.of<WishlistBloc>(context);
          productDetailsBloc
              .add(GetProductDetailsEvent(context: context, slug: slug));
          wishListBloc.add(GetWishlistEvent(context: context));
          return BlocListener<WishlistBloc, WishlistState>(
            listener: (context, wishlistState) {
              // to change toggle fav color using wish list data and detail slug
              if (wishlistState.apiStatus == ApiStatus.completed) {
                productDetailsBloc
                    .add(GetProductDetailsEvent(context: context, slug: slug));
              }
            },
            child: BlocBuilder<ProductDetailsBloc, ProductDetailsState>(
              builder: (context, state) {
                return BlocBuilder<UserBloc, UserState>(
                  builder: (context, userState) {
                    print(" product detail slug ===> $slug");
                    print(
                        "product detail id ===> ${state.productDetails?.id ?? 0}");
                    print("product detail toggle state => ${state.isFavorite}");

                    return Container(
                      color: backgroundColorLight,
                      child: LocalizationWidget(
                        en: "Product Details",
                        mm: "ကုန်ပစ္စည်း အချက်အလက်များ",
                        child: (details) {
                          return SafeArea(
                            child: Scaffold(
                              appBar: TopBar(
                                needBackButton: true,
                                needMenu: false,
                                title: details,
                                showAction: true,
                              ),
                              drawer: CustomDrawerWidget(
                                onDrawerTap: () {},
                              ),
                              body: Scaffold(
                                resizeToAvoidBottomInset: true,
                                body: state.apiStatus == ApiStatus.processing
                                    ? const Center(
                                        child: CircularProgressIndicator(),
                                      )
                                    : state.apiStatus == ApiStatus.completed
                                        ? _productDetailItemsView(
                                            state,
                                            productDetailsBloc,
                                            userState,
                                            context,
                                          )
                                        : Center(
                                            child: ErrorRetry(
                                              retryFun: () {
                                                productDetailsBloc.add(
                                                  GetProductDetailsEvent(
                                                      context: context,
                                                      slug: slug),
                                                );
                                              },
                                            ),
                                          ),
                              ),
                            ),
                          );
                        },
                      ),
                    );
                  },
                );
              },
            ),
          );
        },
      ),
    );
  }

  Column _productDetailItemsView(
    ProductDetailsState state,
    ProductDetailsBloc productDetailsBloc,
    UserState userState,
    BuildContext context,
  ) {
    return Column(
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
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const ProductImageSlider(),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Flexible(
                              child: LocalizationWidget(
                                  en: state.productDetails!.enName,
                                  mm: state.productDetails!.mmName,
                                  child: (productTitle) {
                                    return RobotoText(
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.w600,
                                      fontColor: Colors.black87,
                                      maxLine: 4,
                                      text: productTitle,
                                    );
                                  }),
                            ),
                            BlocBuilder<ProductDetailsBloc,
                                ProductDetailsState>(
                              builder: (context, subDetailState) {
                                print(
                                    "detail sub detail toggle state => ${subDetailState.isFavorite}");
                                return CircleAvatar(
                                  radius: 20,
                                  backgroundColor: Colors.white,
                                  child: IconButton(
                                    color: Colors.white,
                                    onPressed: state.wishlistApiStatus ==
                                            ApiStatus.processing
                                        ? null
                                        : () {
                                            productDetailsBloc.add(
                                              ClickWishlistBtnEvent(
                                                  context: context,
                                                  productId: subDetailState
                                                          .productDetails?.id ??
                                                      0,
                                                  slug: slug),
                                            );
                                            // productDetailsBloc
                                            //     .add(ToggleFavoriteEvent(
                                            //   context: context,
                                            //   isFavorite: isFav,
                                            // ));
                                          },
                                    icon: Icon(
                                      subDetailState.isFavorite ?? false
                                          ? CupertinoIcons.heart_fill
                                          : CupertinoIcons.heart,
                                      color: subDetailState.isFavorite ?? false
                                          ? Colors.red
                                          : Colors.black,
                                    ),
                                  ),
                                );
                              },
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                  const ProductPriceSection(),
                  Builder(builder: (context) {
                    return Padding(
                      padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                      child: _showSpecificationBtnView(
                          context, productDetailsBloc),
                    );
                  }),
                  const Padding(
                    padding: EdgeInsets.only(top: 5.0),
                    child: Divider(
                      color: dividerColor,
                      height: 2,
                    ),
                  ),
                  if ((state.canReview ?? true) && userState.user != null)
                    10.vertical,
                  if ((state.canReview ?? true) && userState.user != null)
                    const Review(),
                  _reviewText(),
                  10.vertical,
                  const ReviewList(),
                  _relatedProductText(),
                  const RelatedProducts()
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
              AddToCart(
                width: 150,
                height: 50,
              ),
              const BuyNow()
            ],
          ),
        )
      ],
    );
  }

  ElevatedButton _showSpecificationBtnView(
      BuildContext context, ProductDetailsBloc productDetailsBloc) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
          elevation: 0,
          foregroundColor: Colors.white,
          backgroundColor: Colors.white,
          disabledForegroundColor: Colors.white),
      onPressed: () {
        showBottomSheet(
          context: context,
          builder: (context) {
            return BlocProvider.value(
              value: productDetailsBloc,
              child: const Specification(),
            );
          },
        );
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          RobotoText(
              fontSize: 16.0, fontColor: Colors.black, text: "Specifications"),
          const SizedBox(
            width: 5,
          ),
          const Icon(
            // <-- Icon
            Icons.keyboard_arrow_down_rounded,
            color: Colors.black87,
            size: 24.0,
          ),
        ],
      ),
    );
  }

  LocalizationWidget _reviewText() {
    return LocalizationWidget(
        en: "Reviews",
        mm: "သုံးသပ်ချက်များ",
        child: (review) {
          return Padding(
            padding: const EdgeInsets.only(
              top: 10.0,
              left: 12,
            ),
            child: RobotoText(
              fontSize: 18.0,
              fontColor: Colors.black,
              text: review,
              fontWeight: FontWeight.w600,
            ),
          );
        });
  }

  Row _relatedProductText() {
    return Row(
      children: [
        LocalizationWidget(
            en: "Related Products",
            mm: "ဆက်စပ်ထုတ်ကုန်များ",
            child: (related) {
              return Padding(
                padding:
                    const EdgeInsets.only(left: 8.0, bottom: 10.0, top: 10.0),
                child: RobotoText(
                  fontSize: 18.0,
                  fontColor: Colors.black,
                  text: related,
                  fontWeight: FontWeight.w600,
                ),
              );
            }),
      ],
    );
  }
}
