import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:innwa_mobile_dev/_application/bloc/app_service_bloc.dart';
import 'package:innwa_mobile_dev/_application/constant/api_key.dart';
import 'package:innwa_mobile_dev/_application/extension/sb_extension.dart';
import 'package:innwa_mobile_dev/_application/product_list/widgets/filter_button.dart';
import 'package:innwa_mobile_dev/promotion/promotion_product/bloc/promotion_product_bloc.dart';
import 'package:innwa_mobile_dev/promotion/promotion_product/model/promotion_list_model.dart';
import 'package:innwa_mobile_dev/promotion/promotion_product/view/widgets/promotion_items.dart';
import 'package:innwa_mobile_dev/promotion/promotion_product/view/widgets/promotion_thumbnail.dart';
import 'package:innwa_mobile_dev/shared/banner/image_banner.dart';
import 'package:innwa_mobile_dev/shared/product_card/product_card.dart';
import 'package:innwa_mobile_dev/shared/texts/heading.dart';
import 'package:innwa_mobile_dev/util/ui/search_product_bar/view/product_search_app_bar.dart';

class Promotion extends StatefulWidget {
  const Promotion({super.key});

  @override
  State<Promotion> createState() => _PromotionState();
}

class _PromotionState extends State<Promotion> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PromotionProductBloc(
        BlocProvider.of<AppServiceBloc>(context).api,
      )..add(GetPromotionProductEvent(context: context)),
      child: Builder(builder: (context) {
        BlocProvider.of<PromotionProductBloc>(context)
            .listenPromtionPagingController(context: context);
        return BlocBuilder<PromotionProductBloc, PromotionProductState>(
          builder: (context, state) {
            return RefreshIndicator(
              onRefresh: () async {
                BlocProvider.of<PromotionProductBloc>(context)
                  ..add(GetPromotionProductEvent(context: context))
                  ..promotionPagingController.refresh();
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: CustomScrollView(
                  slivers: [
                    const ProductSearchAppbar(),
                    SliverToBoxAdapter(
                      child: 15.vertical,
                    ),
                    if (state.productGetState == ApiStatus.completed)
                      SliverGrid(
                        delegate: SliverChildBuilderDelegate(
                          childCount: state.products.length,
                          (context, index) => ProductCard(
                            product: state.products[index],
                            imagePath: state.productImagePath!,
                          ),
                        ),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          childAspectRatio:
                              MediaQuery.of(context).size.width <= 600
                                  ? 0.6
                                  : 0.65,
                          crossAxisCount:
                              MediaQuery.of(context).size.width <= 600 ? 2 : 3,
                        ),
                      ),
                    if (state.productGetState != ApiStatus.completed)
                      const SliverToBoxAdapter(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CircularProgressIndicator(),
                          ],
                        ),
                      ),
                    SliverToBoxAdapter(
                      child: 15.vertical,
                    ),
                    SliverToBoxAdapter(
                      child: Heading(text: "Promotions"),
                    ),
                    SliverToBoxAdapter(
                      child: 15.vertical,
                    ),
                    PagedSliverList(
                      pagingController:
                          BlocProvider.of<PromotionProductBloc>(context)
                              .promotionPagingController,
                      builderDelegate:
                          PagedChildBuilderDelegate<PromotionListModel>(
                              itemBuilder: (context, item, index) {
                        return PromotionItems(
                            imagePrefix: state.promotionImagePath ?? "",
                            promotion: item);
                      }),
                    )
                  ],
                ),
              ),
            );
          },
        );
      }),
    );
    return SizedBox(
      height: MediaQuery.of(context).size.height / 1.32,
      child: SingleChildScrollView(
        child: Column(
          children: [
            const PromotionThumbnail(),
            GridView.count(
              physics: const NeverScrollableScrollPhysics(),
              childAspectRatio:
                  MediaQuery.of(context).size.width <= 600 ? 0.6 : 0.65,
              shrinkWrap: true,
              crossAxisCount: MediaQuery.of(context).size.width <= 600 ? 2 : 3,
              semanticChildCount: 4,
              children: const [
                Text("Implement Product"),
              ],
            ),
            // children: products.entries
            //     .map((e) => ProductCard(
            //         url: e.value["image"],
            //         text: e.value["name"],
            //         price: ""))
            //     .toList()),
            ImageBanner(url: "url"),

            const Padding(
              padding: EdgeInsets.symmetric(vertical: 20.0),
              child: FilterButton(),
            ),

            // Row(
            //   mainAxisAlignment: MainAxisAlignment.center,
            //   children: [
            //     Padding(
            //       padding: const EdgeInsets.all(8.0),
            //       child: PromotionFilterButton(),
            //     ),
            //     Padding(
            //       padding: const EdgeInsets.all(8.0),
            //       child: PromotionSortButton(),
            //     )
            //   ],
            // ),

            Row(
              children: [
                Heading(text: "Best Selling Products"),
              ],
            ),
            GridView.count(
              physics: const NeverScrollableScrollPhysics(),
              childAspectRatio:
                  MediaQuery.of(context).size.width <= 600 ? 0.6 : 0.65,
              shrinkWrap: true,
              crossAxisCount: MediaQuery.of(context).size.width <= 600 ? 2 : 3,
              semanticChildCount: 4,
              children: const [Text("Product IMplement")],
              // children: products.entries
              //     .map((e) => ProductCard(
              //         url: e.value["image"],
              //         text: e.value["name"],
              //         price: ""))
              //     .toList()),
            ),
          ],
        ),
      ),
    );
    // return SizedBox(
    //   height: MediaQuery.of(context).size.height/1.6,
    //   child: ListView.builder(
    //     shrinkWrap: true,
    //     itemCount: 1,
    //     itemBuilder: (context, index) {
    //       return
    //       Column(
    //      children: [
    //        PromotionThumbnail(),
    //        GridView.count(
    //            physics: const NeverScrollableScrollPhysics(),
    //            childAspectRatio: MediaQuery.of(context).size.width<=600?  0.6 :0.65,
    //            shrinkWrap: true,
    //            crossAxisCount:  MediaQuery.of(context).size.width<=600? 2:3,
    //            semanticChildCount: 4,
    //            children: products.entries.map((e) => ProductCard(url: e.value["image"], text: e.value["name"], price: "")).toList()

    //          ),
    //      ],
    //     );
    //     },

    //   ),
    // );
  }
}
