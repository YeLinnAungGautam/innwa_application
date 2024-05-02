import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:innwa_mobile_dev/_application/bloc/app_service_bloc.dart';
import 'package:innwa_mobile_dev/_application/extension/sb_extension.dart';
import 'package:innwa_mobile_dev/home/latest_phone/model/product_model.dart';
import 'package:innwa_mobile_dev/promotion/promotion_details/bloc/promotion_details_bloc.dart';
import 'package:innwa_mobile_dev/shared/product_card/product_card.dart';
import 'package:innwa_mobile_dev/shared/texts/roboto_text/roboto_text.dart';
import 'package:innwa_mobile_dev/shared/top_bar/topbar.dart';

class PromotionsDetailsScreen extends StatelessWidget {
  const PromotionsDetailsScreen({required this.slug, super.key});
  final String slug;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          PromotionDetailsBloc((BlocProvider.of<AppServiceBloc>(context).api)),
      child: BlocBuilder<PromotionDetailsBloc, PromotionDetailsState>(
        builder: (context, state) {
          return Scaffold(
            appBar: TopBar(
              needBackButton: true,
              needMenu: false,
              title: "Promotions",
            ),
            body: CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: CachedNetworkImage(
                    imageUrl:
                        "https://cdn.pixabay.com/photo/2015/04/19/08/32/marguerite-729510_640.jpg",
                    width: MediaQuery.of(context).size.width,
                    fit: BoxFit.cover,
                    height: 250,
                  ),
                ),
                SliverToBoxAdapter(
                  child: 12.vertical,
                ),
                SliverPadding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  sliver: SliverToBoxAdapter(
                    child: RobotoText(
                      fontSize: 18,
                      fontColor: null,
                      fontWeight: FontWeight.bold,
                      text: "Happy Summer Promotion  (April 20th - 12 th May)",
                      maxLine: 3,
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: 12.vertical,
                ),
                SliverGrid(
                  delegate: SliverChildBuilderDelegate(
                    childCount: 8,
                    (context, index) => ProductCard(
                      product: ProductModel.fromJson(const {
                        "id": 402,
                        "name_en": "Oppo A58 (6/128GB)",
                        "name_mm": "Oppo A58 (6/128GB)",
                        "feature_image":
                            '20240201114065125e6ab0cbdoppo-a58 (1).webp',
                        "slug": 'oppo-a58-6128gb-402',
                        "first_price": {
                          "product_price_id": 559,
                          "product_id": 402,
                          "dis_image": null,
                          "dis_start_date": '2024-02-01',
                          "dis_end_date": '2024-02-11',
                          "dis_price": '30000',
                          "cashback": null,
                          "gift": null,
                          "price_mmk": 629900,
                        },
                      }),
                      imagePath:
                          "https://shop.innwa.com.mm/storage/product/feature_image/",
                    ),
                  ),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    childAspectRatio:
                        MediaQuery.of(context).size.width <= 600 ? 0.6 : 0.65,
                    crossAxisCount:
                        MediaQuery.of(context).size.width <= 600 ? 2 : 3,
                  ),
                )
              ],
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
        },
      ),
    );
  }
}
