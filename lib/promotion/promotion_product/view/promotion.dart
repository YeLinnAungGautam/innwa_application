import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:innwa_mobile_dev/_application/bloc/app_service_bloc.dart';
import 'package:innwa_mobile_dev/_application/extension/sb_extension.dart';
import 'package:innwa_mobile_dev/_application/service/localization/loclaization_view.dart';
import 'package:innwa_mobile_dev/promotion/promotion_product/bloc/promotion_product_bloc.dart';
import 'package:innwa_mobile_dev/promotion/promotion_product/view/widgets/horizontal_promotion_list.dart';
import 'package:innwa_mobile_dev/shared/drawer/drawer.dart';
import 'package:innwa_mobile_dev/shared/texts/roboto_text/roboto_text.dart';
import 'package:innwa_mobile_dev/shared/top_bar/topbar.dart';
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
      ),
      child: Builder(builder: (context) {
        BlocProvider.of<PromotionProductBloc>(context)
            .listenPromtionPagingController(context: context);
        return BlocBuilder<PromotionProductBloc, PromotionProductState>(
          builder: (context, state) {
            return Scaffold(
              appBar: TopBar(
                needBackButton: false,
                needMenu: true,
              ),
              drawer: CustomDrawerWidget(
                onDrawerTap: () {},
              ),
              body: RefreshIndicator(
                onRefresh: () async {
                  BlocProvider.of<PromotionProductBloc>(context)
                      .promotionPagingController
                      .refresh();
                },
                child: CustomScrollView(
                  slivers: [
                    const ProductSearchAppbar(),
                    SliverToBoxAdapter(
                      child: 15.vertical,
                    ),
                    SliverToBoxAdapter(
                      child: LocalizationWidget(
                          en: "Promotions",
                          mm: "ပရိုမိုးရှင်းများ",
                          child: (val) {
                            return Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 12),
                                  child: RobotoText(
                                    fontSize: 18,
                                    fontColor: null,
                                    fontWeight: FontWeight.w600,
                                    text: val,
                                  ),
                                ),
                              ],
                            );
                          }),
                    ),
                    SliverToBoxAdapter(
                      child: 15.vertical,
                    ),
                    SliverList.list(children: const [
                      HorizontalPromotionList(),
                      HorizontalPromotionList(),
                      HorizontalPromotionList(),
                    ])
                    // PagedSliverList(
                    //   pagingController:
                    //       BlocProvider.of<PromotionProductBloc>(context)
                    //           .promotionPagingController,
                    //   builderDelegate:
                    //       PagedChildBuilderDelegate<PromotionListModel>(
                    //           itemBuilder: (context, item, index) {
                    //     return PromotionItems(
                    //         imagePrefix: state.promotionImagePath ?? "",
                    //         promotion: item);
                    //   }),
                    // )
                  ],
                ),
              ),
            );
          },
        );
      }),
    );
  }
}
