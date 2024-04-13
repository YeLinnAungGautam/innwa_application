import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:innwa_mobile_dev/_application/bloc/app_service_bloc.dart';
import 'package:innwa_mobile_dev/_application/constant/api_key.dart';
import 'package:innwa_mobile_dev/_application/extension/sb_extension.dart';
import 'package:innwa_mobile_dev/promotion/promotion_details/bloc/promotion_details_bloc.dart';
import 'package:innwa_mobile_dev/shared/product_card/product_card.dart';
import 'package:innwa_mobile_dev/shared/texts/heading.dart';
import 'package:innwa_mobile_dev/util/ui/back_btn.dart';
import 'package:innwa_mobile_dev/util/ui/innwa_error.dart';

class PromotionsDetailsScreen extends StatelessWidget {
  const PromotionsDetailsScreen({required this.slug, super.key});
  final String slug;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          PromotionDetailsBloc((BlocProvider.of<AppServiceBloc>(context).api))
            ..add(GetPromotionDetailsEvent(context: context, slug: slug)),
      child: BlocBuilder<PromotionDetailsBloc, PromotionDetailsState>(
        builder: (context, state) {
          return Scaffold(
              body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
            child: CustomScrollView(
              slivers: state.apiStatus == ApiStatus.processing
                  ? [
                      const SliverFillRemaining(
                        child: Center(
                          child: CircularProgressIndicator(),
                        ),
                      )
                    ]
                  : state.apiStatus == ApiStatus.completed
                      ? [
                          SliverToBoxAdapter(
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8),
                              child: Row(
                                children: [
                                  const BackBtn(),
                                  Expanded(
                                    child: Text(
                                      state.promotionDetails!.enName,
                                      style: const TextStyle(
                                        fontSize: 20.0,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SliverToBoxAdapter(
                            child: 10.vertical,
                          ),
                          if (state.promotionDetails?.bannerImage != null)
                            SliverToBoxAdapter(
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: CachedNetworkImage(
                                  imageUrl: (state.bannerImagePath +
                                      state.promotionDetails!.bannerImage!),
                                  width: MediaQuery.of(context).size.width,
                                ),
                              ),
                            ),
                          if (state.promotionDetails!.mmDesc != null ||
                              state.promotionDetails!.enDesc != null)
                            SliverToBoxAdapter(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 8,
                                ),
                                child: Html(
                                  data: state.promotionDetails!.mmDesc ??
                                      state.promotionDetails!.enDesc,
                                ),
                              ),
                            ),
                          SliverToBoxAdapter(
                            child: 10.vertical,
                          ),
                          if (state.promotionDetails?.featuredImage != null)
                            SliverToBoxAdapter(
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: CachedNetworkImage(
                                  imageUrl: (state.featureImagepath +
                                      state.promotionDetails!.featuredImage),
                                  width: MediaQuery.of(context).size.width,
                                ),
                              ),
                            ),
                          SliverToBoxAdapter(
                            child: 10.vertical,
                          ),
                          SliverToBoxAdapter(
                            child: 15.vertical,
                          ),
                          SliverToBoxAdapter(
                            child: Heading(
                                text:
                                    "Promotion Products ${state.promotionsProducts.length}"),
                          ),
                          SliverToBoxAdapter(
                            child: 15.vertical,
                          ),
                          SliverGrid(
                            delegate: SliverChildBuilderDelegate(
                              childCount: state.promotionsProducts.length,
                              (context, index) => ProductCard(
                                product: state.promotionsProducts[index],
                                imagePath: state.featureImagepath,
                              ),
                            ),
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
                          )
                        ]
                      : [
                          SliverToBoxAdapter(
                            child: InnwaError(onClick: () {
                              BlocProvider.of<PromotionDetailsBloc>(context)
                                  .add(GetPromotionDetailsEvent(
                                      context: context, slug: slug));
                            }),
                          ),
                        ],
            ),
          ));
        },
      ),
    );
  }
}
