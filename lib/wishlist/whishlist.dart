import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:innwa_mobile_dev/_application/bloc/app_service_bloc.dart';
import 'package:innwa_mobile_dev/_application/service/localization/loclaization_view.dart';
import 'package:innwa_mobile_dev/shared/drawer/drawer.dart';
import 'package:innwa_mobile_dev/shared/product_card/product_card.dart';
import 'package:innwa_mobile_dev/shared/top_bar/topbar.dart';
import 'package:innwa_mobile_dev/util/constants.dart';
import 'package:innwa_mobile_dev/util/ui/search_product_bar/model/search_product_model.dart';
import 'package:innwa_mobile_dev/wishlist/bloc/wishlist_bloc.dart';

class WishList extends StatelessWidget {
  const WishList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => WishlistBloc(
        BlocProvider.of<AppServiceBloc>(context).api,
      )..listenFilterPagingController(context: context),
      child: Builder(
        builder: (context) {
          final WishlistBloc wishlistBloc =
              BlocProvider.of<WishlistBloc>(context);
          return BlocBuilder<WishlistBloc, WishlistState>(
            builder: (context, state) {
              print(
                  "this is wishlist state from wishlist screen ===> ${state.wishListData}");
              return Container(
                color: backgroundColorLight,
                child: LocalizationWidget(
                  en: "Wishlists",
                  mm: "ဆန္ဒစာရင်းများ",
                  child: (wishlist) {
                    return SafeArea(
                      child: Scaffold(
                        appBar: TopBar(
                          needBackButton: true,
                          needMenu: false,
                          title: wishlist,
                        ),
                        drawer: CustomDrawerWidget(onDrawerTap: () {
                          FocusScopeNode currentFocus = FocusScope.of(context);

                          if (!currentFocus.hasPrimaryFocus &&
                              currentFocus.hasFocus) {
                            currentFocus.unfocus();
                          }
                        }),
                        body: state.message == "null"
                            ? CustomScrollView(
                                slivers: [
                                  PagedSliverGrid(
                                    pagingController:
                                        wishlistBloc.produtPagingController,
                                    gridDelegate:
                                        SliverGridDelegateWithFixedCrossAxisCount(
                                      childAspectRatio:
                                          MediaQuery.of(context).size.width <=
                                                  600
                                              ? 0.6
                                              : 0.65,
                                      crossAxisCount:
                                          MediaQuery.of(context).size.width <=
                                                  600
                                              ? 2
                                              : 3,
                                    ),
                                    builderDelegate: PagedChildBuilderDelegate<
                                        SearchProductModel>(
                                      itemBuilder: (context, item, index) {
                                        return ProductCard(
                                          product: item,
                                          imagePath: "${state.imagePath}/",
                                          isRoot: true,
                                        );
                                      },
                                    ),
                                  ),
                                ],
                              )
                            : Center(child: Text(state.message)),
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
  }
}
