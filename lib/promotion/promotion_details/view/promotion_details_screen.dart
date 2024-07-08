import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:innwa_mobile_dev/_application/constant/api_key.dart';
import 'package:innwa_mobile_dev/_application/extension/sb_extension.dart';
import 'package:innwa_mobile_dev/_application/service/localization/loclaization_view.dart';
import 'package:innwa_mobile_dev/constant/api_constant.dart';
import 'package:innwa_mobile_dev/shared/product_card/product_card.dart';
import 'package:innwa_mobile_dev/shared/texts/roboto_text/roboto_text.dart';
import 'package:innwa_mobile_dev/shared/top_bar/topbar.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../../../_application/bloc/app_service_bloc.dart';
import '../../promotion_product/response/vos/data_vo/data_vo.dart';
import '../bloc/promotion_details_bloc.dart';

class PromotionsDetailsScreen extends StatelessWidget {
  const PromotionsDetailsScreen(
      {super.key, this.promotionData, required this.slug});

  final String slug;
  final Data? promotionData;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PromotionDetailsBloc(
          (BlocProvider.of<AppServiceBloc>(context).api), slug)
        ..add(
          GetPromotionDetailsEvent(slug: slug),
        ),
      child: BlocBuilder<PromotionDetailsBloc, PromotionDetailsState>(
        buildWhen: (previous, current) => previous.data != current.data,
        builder: (context, state) {
          debugPrint("state is ===> ${state.apiStatus}");
          return Scaffold(
            appBar: TopBar(
              needBackButton: true,
              needMenu: false,

              // title: "Promotions",
            ),
            body: state.apiStatus == ApiStatus.processing
                ? Center(
                    child: LoadingAnimationWidget.staggeredDotsWave(
                      size: 50,
                      color: Colors.purple,
                    ),
                  )
                : state.apiStatus == ApiStatus.completed
                    ? CustomScrollView(
                        controller:
                            BlocProvider.of<PromotionDetailsBloc>(context)
                                .scrollController,
                        slivers: [
                          SliverToBoxAdapter(
                            child: CachedNetworkImage(
                              imageUrl:
                                  "$kPromotionFeatureImageBaseUrl${state.promotionsDetail?.featuredImage}",
                              width: MediaQuery.of(context).size.width,
                              fit: BoxFit.cover,
                              height: 250,
                            ),
                          ),
                          SliverToBoxAdapter(
                            child: 12.vertical,
                          ),
                          SliverPadding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 10.0),
                            sliver: SliverToBoxAdapter(
                              child: LocalizationWidget(
                                en: state.promotionsDetail?.nameEn,
                                mm: state.promotionsDetail?.nameMm,
                                child: (String val) {
                                  return RobotoText(
                                    fontSize: 18,
                                    fontColor: null,
                                    fontWeight: FontWeight.bold,
                                    text: val,
                                    maxLine: 3,
                                  );
                                },
                              ),
                            ),
                          ),
                          SliverToBoxAdapter(
                            child: 12.vertical,
                          ),
                          SliverGrid(
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              childAspectRatio:
                                  MediaQuery.of(context).size.width <= 600
                                      ? 0.6
                                      : 0.65,
                              crossAxisCount:
                                  MediaQuery.of(context).size.width <= 600
                                      ? 2
                                      : 3,
                            ),
                            delegate: SliverChildBuilderDelegate(
                              childCount: state.data?.length ?? 0,
                              (context, index) {
                                print(
                                    "product id is ===> ${state.data?[index].productId}");
                                final productPrice = state.data?[index];
                                final product = state.data?[index].product;
                                return ProductCard(
                                  imagePath:
                                      "https://shop.innwa.com.mm/storage/product/feature_image/",
                                  isPromotionProduct: true,
                                  productEnName: product?.nameEn,
                                  productMmName: product?.nameMm,
                                  productImageUrl: product?.featureImage,
                                  productPrice: productPrice?.priceMmk,
                                  productDisPrice: productPrice?.disPrice,
                                  productCashBack: productPrice?.cashback,
                                  gift: productPrice?.gift,
                                  productSlug: product?.slug,
                                );
                              },
                            ),
                          ),
                        ],
                      )
                    : Container(),
          );
        },
      ),
    );
    // return Scaffold(
    //     body: Padding(
    //   padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
    //   child: CustomScrollView(
    //     slivers: state.apiStatus == ApiStatus.processing
    //         ? [
    //             const SliverFillRemaining(
    //               child: Center(
    //                 child: CircularProgressIndicator(),
    //               ),
    //             )
    //           ]
    //         : state.apiStatus == ApiStatus.completed
    //             ? [
    //                 SliverToBoxAdapter(
    //                   child: Padding(
    //                     padding:
    //                         const EdgeInsets.symmetric(horizontal: 8),
    //                     child: Row(
    //                       children: [
    //                         const BackBtn(),
    //                         Expanded(
    //                           child: Text(
    //                             state.promotionDetails!.enName,
    //                             style: const TextStyle(
    //                               fontSize: 20.0,
    //                               color: Colors.black,
    //                               fontWeight: FontWeight.bold,
    //                             ),
    //                           ),
    //                         ),
    //                       ],
    //                     ),
    //                   ),
    //                 ),
    //                 SliverToBoxAdapter(
    //                   child: 10.vertical,
    //                 ),
    //                 if (state.promotionDetails?.bannerImage != null)
    //                   SliverToBoxAdapter(
    //                     child: ClipRRect(
    //                       borderRadius: BorderRadius.circular(10),
    //                       child: CachedNetworkImage(
    //                         imageUrl: (state.bannerImagePath +
    //                             state.promotionDetails!.bannerImage!),
    //                         width: MediaQuery.of(context).size.width,
    //                       ),
    //                     ),
    //                   ),
    //                 if (state.promotionDetails!.mmDesc != null ||
    //                     state.promotionDetails!.enDesc != null)
    //                   SliverToBoxAdapter(
    //                     child: Padding(
    //                       padding: const EdgeInsets.symmetric(
    //                         horizontal: 8,
    //                       ),
    //                       child: LocalizationWidget(
    //                           en: state.promotionDetails!.enDesc,
    //                           mm: state.promotionDetails!.mmDesc,
    //                           child: (val) {
    //                             return HtmlWidget(
    //                               val,
    //                             );
    //                           }),
    //                     ),
    //                   ),
    //                 SliverToBoxAdapter(
    //                   child: 10.vertical,
    //                 ),
    //                 if (state.promotionDetails?.featuredImage != null)
    //                   SliverToBoxAdapter(
    //                     child: ClipRRect(
    //                       borderRadius: BorderRadius.circular(10),
    //                       child: CachedNetworkImage(
    //                         imageUrl: (state.featureImagepath +
    //                             state.promotionDetails!.featuredImage),
    //                         width: MediaQuery.of(context).size.width,
    //                       ),
    //                     ),
    //                   ),
    //                 SliverToBoxAdapter(
    //                   child: 10.vertical,
    //                 ),
    //                 SliverToBoxAdapter(
    //                   child: 15.vertical,
    //                 ),
    //                 SliverToBoxAdapter(
    //                   child: LocalizationWidget(
    //                     en: "Promotion Products",
    //                     mm: "ပရိုမိုးရှင်းထုတ်ကုန်များ",
    //                     child: (val) {
    //                       return Row(
    //                         children: [
    //                           Padding(
    //                             padding: const EdgeInsets.symmetric(
    //                               vertical: 15.0,
    //                               horizontal: 15,
    //                             ),
    //                             child: RobotoText(
    //                               fontSize: 18,
    //                               fontColor: null,
    //                               fontWeight: FontWeight.w600,
    //                               text: val,
    //                             ),
    //                           ),
    //                         ],
    //                       );
    //                     },
    //                   ),
    //                 ),
    //                 SliverToBoxAdapter(
    //                   child: 15.vertical,
    //                 ),
    //                 SliverGrid(
    //                   delegate: SliverChildBuilderDelegate(
    //                     childCount: state.promotionsProducts.length,
    //                     (context, index) => ProductCard(
    //                       product: state.promotionsProducts[index],
    //                       imagePath: state.featureImagepath,
    //                     ),
    //                   ),
    //                   gridDelegate:
    //                       SliverGridDelegateWithFixedCrossAxisCount(
    //                     childAspectRatio:
    //                         MediaQuery.of(context).size.width <= 600
    //                             ? 0.6
    //                             : 0.65,
    //                     crossAxisCount:
    //                         MediaQuery.of(context).size.width <= 600
    //                             ? 2
    //                             : 3,
    //                   ),
    //                 )
    //               ]
    //             : [
    //                 SliverToBoxAdapter(
    //                   child: InnwaError(onClick: () {
    //                     BlocProvider.of<PromotionDetailsBloc>(context)
    //                         .add(GetPromotionDetailsEvent(
    //                             context: context, slug: slug));
    //                   }),
    //                 ),
    //               ],
    //   ),
    // ));
    //       },
    //     ),
    //   );
  }
}
