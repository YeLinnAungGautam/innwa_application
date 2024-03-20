import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:innwa_mobile_dev/_application/bloc/app_service_bloc.dart';
import 'package:innwa_mobile_dev/_application/constant/api_key.dart';
import 'package:innwa_mobile_dev/_application/extension/sb_extension.dart';
import 'package:innwa_mobile_dev/promotion_product/bloc/promotion_product_bloc.dart';
import 'package:innwa_mobile_dev/promotion_product/view/widgets/promotion_thumbnail.dart';
import 'package:innwa_mobile_dev/screen/products/components/filter_button.dart';
import 'package:innwa_mobile_dev/shared/banner/image_banner.dart';
import 'package:innwa_mobile_dev/shared/product_card/product_card.dart';
import 'package:innwa_mobile_dev/shared/texts/heading.dart';

class Promotion extends StatefulWidget {
  const Promotion({super.key});

  @override
  State<Promotion> createState() => _PromotionState();
}

class _PromotionState extends State<Promotion> {
  List<String> filterTypes = ['Best Selling', 'Most Popular', 'New Arrival'];
  List<String> selectTypes = [];

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PromotionProductBloc(
        BlocProvider.of<AppServiceBloc>(context).api,
      ),
      child: Builder(builder: (context) {
        BlocProvider.of<PromotionProductBloc>(context)
            .add(GetPromotionProductEvent(context: context));
        return BlocBuilder<PromotionProductBloc, PromotionProductState>(
          builder: (context, state) {
            return RefreshIndicator(
              onRefresh: () async {
                BlocProvider.of<PromotionProductBloc>(context)
                    .add(GetPromotionProductEvent(context: context));
              },
              child: CustomScrollView(
                slivers: [
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
                ],
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
